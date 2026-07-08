#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom httr GET content status_code
#' @importFrom curl new_handle curl_fetch_memory
#' @importFrom utils getFromNamespace installed.packages packageVersion
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  ## Add server configurations
  options(shiny.maxRequestSize = 1000000 * 1024^2) # Set maximum upload size to 1000GB
  # shiny.maxRequestSize = 10000 * 1024^2; # 10 GB <- This is for a future limit when using BI's server remotely

  output$BIGappInstalled <- reactive({
    "BIGapp" %in% rownames(installed.packages())
  })

  output$familiaInstalled <- reactive({
    "familia" %in% rownames(installed.packages())
  })

  output$allomateInstalled <- reactive({
    "AlloMate" %in% rownames(installed.packages())
  })

  output$genobrewInstalled <- reactive({
    "GenoBrew" %in% rownames(installed.packages())
  })

  output$viewpolyInstalled <- reactive({
    "viewpoly" %in% rownames(installed.packages())
  })

  # Expose the value to JS even when panel is hidden
  # outputOptions(output, "qploidyInstalled", suspendWhenHidden = FALSE)
  outputOptions(output, "BIGappInstalled", suspendWhenHidden = FALSE)
  outputOptions(output, "familiaInstalled", suspendWhenHidden = FALSE)
  outputOptions(output, "allomateInstalled", suspendWhenHidden = FALSE)
  outputOptions(output, "genobrewInstalled", suspendWhenHidden = FALSE)
  outputOptions(output, "viewpolyInstalled", suspendWhenHidden = FALSE)

  ## Modules

  ## Home Module
  callModule(mod_Home_server,
    "Home_1",
    parent_session = session
  )

  ## Install Module
  callModule(mod_install_server,
    "install_1",
    parent_session = session
  )

  ## BIGapp

  if (isTRUE(requireNamespace("BIGapp", quietly = TRUE))) {
    do.call("library", list("BIGapp"))
    callModule(getFromNamespace("mod_DosageCall_server", "BIGapp"),
      "DosageCall_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_dosage2vcf_server", "BIGapp"),
      "dosage2vcf_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_PCA_server", "BIGapp"),
      "PCA_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_dapc_server", "BIGapp"),
      "dapc_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_gwas_server", "BIGapp"),
      "gwas_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_diversity_server", "BIGapp"),
      "diversity_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_GSAcc_server", "BIGapp"),
      "GSAcc_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_GS_server", "BIGapp"),
      "GS_1",
      parent_session = session
    )
  }

  ## familia

  if (isTRUE(requireNamespace("familia", quietly = TRUE))) {
    do.call("library", list("familia"))
    callModule(getFromNamespace("mod_SNMF_server", "familia"),
      "SNMF_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_polybreedtools_server", "familia"),
      "PolyBreedTools_1",
      parent_session = session
    )
  }

  ## AlloMate
  if (isTRUE(requireNamespace("AlloMate", quietly = TRUE))) {
    do.call("library", list("AlloMate"))
    getFromNamespace("mod_allomate_server", "AlloMate")(
      "allomate_1",
      parent_session = session
    )
  }

  ## GenoBrew
  if (isTRUE(requireNamespace("GenoBrew", quietly = TRUE))) {
    do.call("library", list("GenoBrew"))
    callModule(getFromNamespace("mod_mk_select_server", "GenoBrew"),
      "mk_select_1",
      parent_session = session
    )
    callModule(getFromNamespace("mod_cnv_server", "GenoBrew"),
      "cnv_1",
      parent_session = session
    )
  }

  ## VIEWpoly
  if (isTRUE(requireNamespace("viewpoly", quietly = TRUE))) {
    do.call("library", list("viewpoly"))
    datas <- callModule(getFromNamespace("mod_upload_server", "viewpoly"),
      "upload_1",
      parent_session = session
    )

    # QTL view
    callModule(getFromNamespace("mod_qtl_view_server", "viewpoly"),
      "qtl_1",
      loadMap = datas$loadMap,
      loadQTL = datas$loadQTL,
      parent_session = session
    )

    # Genes view
    callModule(getFromNamespace("mod_genes_view_server", "viewpoly"),
      "genes_1",
      loadMap = datas$loadMap,
      loadQTL = datas$loadQTL,
      loadJBrowse_fasta = datas$loadJBrowse_fasta,
      loadJBrowse_gff3 = datas$loadJBrowse_gff3,
      loadJBrowse_vcf = datas$loadJBrowse_vcf,
      loadJBrowse_align = datas$loadJBrowse_align,
      loadJBrowse_wig = datas$loadJBrowse_wig,
      parent_session = session
    )

    # Map view
    callModule(getFromNamespace("mod_map_view_server", "viewpoly"),
      "map_1",
      loadMap = datas$loadMap,
      loadQTL = datas$loadQTL,
      parent_session = session
    )

    # Hidecan view
    callModule(getFromNamespace("mod_hidecan_view_server", "viewpoly"),
      "hidecan_1",
      loadHidecan = datas$loadHidecan,
      parent_session = session
    )
  }

  # Session info popup
  observeEvent(input$session_info_button, {
    showModal(modalDialog(
      title = "Session Information",
      size = "l",
      easyClose = TRUE,
      footer = tagList(
        modalButton("Close"),
        downloadButton("download_session_info", "Download")
      ),
      pre(
        paste(capture.output(sessionInfo()), collapse = "\n")
      )
    ))
  })

  # Check for updates from GitHub for Breedverse
  get_latest_github_commit <- function(repo, owner) {
    url <- paste0("https://api.github.com/repos/", owner, "/", repo, "/releases/latest")
    response <- GET(url)
    content <- content(response, "parsed")

    if (status_code(response) == 200) {
      tag_name <- content$tag_name
      clean_tag_name <- sub("-.*", "", tag_name)
      clean_tag_name <- sub("v", "", clean_tag_name)
      return(clean_tag_name)
    } else {
      return(NULL)
    }
  }

  is_internet_connected <- function() {
    handle <- new_handle()
    success <- tryCatch(
      {
        curl_fetch_memory("https://www.google.com", handle = handle)
        TRUE
      },
      error = function(e) {
        FALSE
      }
    )
    return(success)
  }

  observeEvent(input$updates_info_button, {
    # Check internet connectivity
    if (!is_internet_connected()) {
      # Display internet connectivity issues message
      showModal(modalDialog(
        title = "No Internet Connection",
        easyClose = TRUE,
        footer = tagList(
          modalButton("Close")
        ),
        "Please check your internet connection and try again."
      ))
      return()
    }

    package_name <- "Breedverse"
    repo_name <- "Breedverse" # GitHub repo name
    repo_owner <- "Breeding-Insight" # User or organization name

    # Get the installed version
    installed_version <- as.character(packageVersion(package_name))

    # Get the latest version from GitHub (can be tag version or latest commit)
    latest_commit <- get_latest_github_commit(repo_name, repo_owner)

    # Compare versions and prepare message
    if (latest_commit > installed_version) {
      update_status <- "A new version is available. Please update your package."
      # Prepare styled HTML text for the modal
      message_html <- paste(
        "Installed version:", installed_version, "<br>",
        # "Latest version commit SHA:", latest_commit, "<br>",
        "<span>A new version is available on GitHub!</span><br>",
        "<span style='color: red;'>Please update your package.</span>"
      )
    } else {
      update_status <- "Your package is up-to-date!"
      # Prepare non-styled text for no update needed
      message_html <- paste(
        "Installed version:", installed_version, "<br>",
        # "Latest version commit SHA:", latest_commit, "<br>",
        update_status
      )
    }

    # Display message in a Shiny modal
    showModal(modalDialog(
      title = "Breedverse Updates",
      size = "m",
      easyClose = TRUE,
      footer = tagList(
        modalButton("Close")
      ),
      # Use HTML to format the message and include styling
      HTML(message_html)
    ))
  })

  # Download Session Info
  output$download_session_info <- downloadHandler(
    filename = function() {
      paste("session_info_", Sys.Date(), ".txt", sep = "")
    },
    content = function(file) {
      writeLines(paste(capture.output(sessionInfo()), collapse = "\n"), file)
    }
  )
}
