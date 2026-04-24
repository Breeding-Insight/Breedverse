#' qploidy placeholder UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList includeMarkdown
#' @importFrom utils install.packages
mod_install_ui <- function(id) {
  ns <- NS(id)

  tagList(
    # Small CSS to style the cards and badges
    tags$style(HTML("
      .install-row {
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 20px;
      }
      .install-row > [class*='col-'] {
        display: flex;
      }
      .install-card {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        border-radius: 8px;
        border: 1px solid #e0e0e0;
        padding: 18px 20px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
        background-color: #ffffff;
      }
      .install-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
      }
      .install-title {
        margin: 0;
        font-size: 20px;
        font-weight: 600;
      }
      .install-status-badge {
        font-size: 11px;
        padding: 3px 10px;
        border-radius: 999px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }
      .install-status-ok {
        background-color: #e8f5e9;
        color: #2e7d32;
      }
      .install-status-missing {
        background-color: #ffebee;
        color: #c62828;
      }
      .install-log {
        max-height: 180px;
        overflow-y: auto;
        font-size: 11px;
        background-color: #fafafa;
        border-radius: 4px;
      }
    ")),

    fluidPage(
      fluidRow(
        class = "install-row",
        # --- Qploidy card ----------------------------------------------------
        column(
          width = 6,
          div(
            class = "install-card",

            # Already installed
            conditionalPanel(
              condition = sprintf("output['%s'] == true", ns("qploidyInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/Qploidy_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "Qploidy")
                  ),
                )),
                span("Installed", class = "install-status-badge install-status-ok")
              ),
              p(tags$a(href = "https://github.com/Cristianetaniguti/Qploidy", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Allele intensities/read counts standardization"),
                  tags$li("Sample ploidy estimation"),
                  tags$li("Aneuploidy detection"),
                  tags$li("Multipoint (HMM) copy number estimation (beta)")
                ),
                br()
              ),
              p("Qploidy is installed. You can access ploidy estimation features in the app.")
            ),

            # Not installed
            conditionalPanel(
              condition = sprintf("output['%s'] == false", ns("qploidyInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/Qploidy_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "Qploidy")
                  ),
                )),
                span("Not installed", class = "install-status-badge install-status-missing")
              ),
              p(tags$a(href = "https://github.com/Cristianetaniguti/Qploidy", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Allele intensities/read counts standardization"),
                  tags$li("Sample ploidy estimation"),
                  tags$li("Aneuploidy detection"),
                  tags$li("Multipoint (HMM) copy number estimation (beta)")
                ),
                br()
              ),
              p("Install the Qploidy package to enable ploidy estimation workflows."),
              div(
                style = "margin-top: 12px; margin-bottom: 10px;",
                actionButton(
                  ns("install_qploidy"),
                  "Install Qploidy",
                  icon = icon("download")
                )
              )
            ),

            # Log (always visible)
            tags$label("Installation log"),
            div(
              class = "install-log",
              uiOutput(ns("install_log_qploidy"))
            )
          )
        ),

        # --- BIGapp card -----------------------------------------------------
        column(
          width = 6,
          div(
            class = "install-card",

            # Already installed
            conditionalPanel(
              condition = sprintf("output['%s'] == true", ns("BIGappInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/BIG_R_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "BIGapp")
                  ),
                )),
                span("Installed", class = "install-status-badge install-status-ok")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/BIGapp", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Genotype Processing (call off-targets SNPs, Filtering)"),
                  tags$li("Markers Summary Statistics"),
                  tags$li("Population Structure Analysis (PCA, DAPC)"),
                  tags$li("Genome-Wide Association Studies (GWAS)"),
                  tags$li("Genomic Selection (GS)")
                ),
                br()
              ),
              p("BIGapp is installed. You can access BIGapp features in the app.")
            ),

            # Not installed
            conditionalPanel(
              condition = sprintf("output['%s'] == false", ns("BIGappInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/BIG_R_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "BIGapp")
                  )
                )),
                span("Not installed", class = "install-status-badge install-status-missing")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/BIGapp", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Genotype Processing (call off-targets SNPs, Filtering)"),
                  tags$li("Markers Summary Statistics"),
                  tags$li("Population Structure Analysis (PCA, DAPC)"),
                  tags$li("Genome-Wide Association Studies (GWAS)"),
                  tags$li("Genomic Selection (GS)")
                ),
                br()
              ),
              p("Install the BIGapp package to enable the genomic analysis features."),
              div(
                style = "margin-top: 12px; margin-bottom: 10px;",
                actionButton(
                  ns("install_bigapp"),
                  "Install BIGapp",
                  icon = icon("download")
                )
              )
            ),

            # Log (always visible)
            tags$label("Installation log"),
            div(
              class = "install-log",
              uiOutput(ns("install_log_BIGapp"))
            )
          )
        )
      ),
      fluidRow(
        class = "install-row",
        # --- Familia card ----------------------------------------------------
        column(
          width = 6,
          div(
            class = "install-card",

            # Already installed
            conditionalPanel(
              condition = sprintf("output['%s'] == true", ns("familiaInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/familia_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "Familia")
                  ),
                )),
                span("Installed", class = "install-status-badge install-status-ok")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/familia", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Unsupervised ancestry estimation with SNMF() ADMIXTURE-like algorithms"),
                  tags$li("Supervised ancestry estimation with PolyBreedTools"),
                  tags$li("Support for diploid and polyploid species")
                ),
                br(),
                br()
              ),
              p("Familia is installed. You can access ancestry estimation features in the app.")
            ),

            # Not installed
            conditionalPanel(
              condition = sprintf("output['%s'] == false", ns("familiaInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/familia_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "Familia")
                  ),
                )),
                span("Not installed", class = "install-status-badge install-status-missing")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/familia", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Unsupervised ancestry estimation with SNMF() ADMIXTURE-like algorithms"),
                  tags$li("Supervised ancestry estimation with PolyBreedTools"),
                  tags$li("Support for diploid and polyploid species")
                ),
                br()
              ),
              p("Install the familia package to enable ancestry estimation workflows."),
              div(
                style = "margin-top: 12px; margin-bottom: 10px;",
                actionButton(
                  ns("install_familia"),
                  "Install Familia",
                  icon = icon("download")
                )
              )
            ),

            # Log (always visible)
            tags$label("Installation log"),
            div(
              class = "install-log",
              uiOutput(ns("install_log_familia"))
            )
          )
        ),

        # --- AlloMate Card -----------------------------------------------------
        column(
          width = 6,
          div(
            class = "install-card",

            # Already installed
            conditionalPanel(
              condition = sprintf("output['%s'] == true", ns("allomateInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/allomate_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "AlloMate")
                  ),
                )),
                span("Installed", class = "install-status-badge install-status-ok")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/AlloMate", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Evaluating genetic relatedness among breeding candidates"),
                  tags$li("Combining multiple EBV traits using user-defined weights"),
                  tags$li("Optimizing individual contributions via Optimum Contribution Selection"),
                  tags$li("Producing feasible mating plans under kinship constraints")
                ),
                br()
              ),
              p("AlloMate is installed. You can access mating estimation features in the app.")
            ),

            # Not installed
            conditionalPanel(
              condition = sprintf("output['%s'] == false", ns("allomateInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/allomate_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "AlloMate")
                  ),
                )),
                span("Not installed", class = "install-status-badge install-status-missing")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/AlloMate", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Evaluating genetic relatedness among breeding candidates"),
                  tags$li("Combining multiple EBV traits using user-defined weights"),
                  tags$li("Optimizing individual contributions via Optimum Contribution Selection"),
                  tags$li("Producing feasible mating plans under kinship constraints")
                ),
                br()
              ),
              p("Install the AlloMate package to enable mating estimation workflows."),
              div(
                style = "margin-top: 12px; margin-bottom: 10px;",
                actionButton(
                  ns("install_allomate"),
                  "Install AlloMate",
                  icon = icon("download")
                )
              )
            ),

            # Log (always visible)
            tags$label("Installation log"),
            div(
              class = "install-log",
              uiOutput(ns("install_log_allomate"))
            )
          )
        ),
        # --- GenoBrew card ----------------------------------------------------
        column(
          width = 6,
          div(
            class = "install-card",

            # Already installed
            conditionalPanel(
              condition = sprintf("output['%s'] == true", ns("genobrewInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/GenoBrew_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "GenoBrew")
                  ),
                )),
                span("Installed", class = "install-status-badge install-status-ok")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/GenoBrew", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Allele intensities/read counts standardization"),
                  tags$li("Sample ploidy estimation"),
                  tags$li("Aneuploidy detection"),
                  tags$li("Multipoint (HMM) copy number estimation (beta)")
                ),
                br()
              ),
              p("GenoBrew is installed. You can access ploidy estimation features in the app.")
            ),

            # Not installed
            conditionalPanel(
              condition = sprintf("output['%s'] == false", ns("genobrewInstalled")),
              div(
                class = "install-header",
                h3(class = "install-title", div(
                  class = "install-header",
                  tags$div(
                    style = "display:flex; align-items:center;",
                    tags$img(
                      src = "www/GenoBrew_logo.png",
                      height = "100px",
                      style = "margin-right:8px;"
                    ),
                    h3(class = "install-title", "GenoBrew")
                  ),
                )),
                span("Not installed", class = "install-status-badge install-status-missing")
              ),
              p(tags$a(href = "https://github.com/Breeding-Insight/GenoBrew", target = "_blank",
                       icon("github"), " GitHub Repository")),
              tagList(
                p("Features:"),
                tags$ul(
                  tags$li("Test marker panel performance with historical data"),
                  tags$li("Markers basic filters"),
                  tags$li("Interactive visualization of Qploidy2 CNV profiles results"),
                  tags$li("Find copy number variation hostspots in the genome")
                ),
                br()
              ),
              p("Install the GenoBrew package to enable marker panel tests and CNV visualization workflows."),
              div(
                style = "margin-top: 12px; margin-bottom: 10px;",
                actionButton(
                  ns("install_genobrew"),
                  "Install GenoBrew",
                  icon = icon("download")
                )
              )
            ),

            # Log (always visible)
            tags$label("Installation log"),
            div(
              class = "install-log",
              uiOutput(ns("install_log_genobrew"))
            )
          )
        )
      ) #Closing fluidrow parentheses
    )
  )
}

#' install Server Functions
#'
#' @noRd
mod_install_server <- function(input, output, session, parent_session){

  ns <- session$ns

  # --- reactive installation flags ---------------------------------------
  qploidy_installed <- reactiveVal(
    requireNamespace("Qploidy", quietly = TRUE)
  )
  familia_installed <- reactiveVal(
    requireNamespace("familia", quietly = TRUE)
  )
  bigapp_installed <- reactiveVal(
    requireNamespace("BIGapp", quietly = TRUE)
  )
  allomate_installed <- reactiveVal(
    requireNamespace("AlloMate", quietly = TRUE)
  )
  genobrew_installed <- reactiveVal(
    requireNamespace("GenoBrew", quietly = TRUE)
  )

  output$qploidyInstalled <- reactive({ qploidy_installed() })
  outputOptions(output, "qploidyInstalled", suspendWhenHidden = FALSE)

  output$familiaInstalled <- reactive({ familia_installed() })
  outputOptions(output, "familiaInstalled", suspendWhenHidden = FALSE)

  output$BIGappInstalled <- reactive({ bigapp_installed() })
  outputOptions(output, "BIGappInstalled", suspendWhenHidden = FALSE)

  output$allomateInstalled <- reactive({ allomate_installed() })
  outputOptions(output, "allomateInstalled", suspendWhenHidden = FALSE)

  output$genobrewInstalled <- reactive({ genobrew_installed() })
  outputOptions(output, "genobrewInstalled", suspendWhenHidden = FALSE)

  # Initialize logs as empty
  output$install_log_qploidy <- renderUI(NULL)
  output$install_log_BIGapp <- renderUI(NULL)
  output$install_log_familia <- renderUI(NULL)
  output$install_log_allomate <- renderUI(NULL)
  output$install_log_genobrew <- renderUI(NULL)


  # --- Qploidy installation ----------------------------------------------
  observeEvent(input$install_qploidy, {
    err_msg <- NULL
    ok      <- FALSE
    log_lines <- character(0)

    output$install_log_qploidy <- renderUI(NULL)

    withProgress(message = "Installing Qploidy", value = 0, {

      capture_msg <- function(m) {
        log_lines <<- c(log_lines, conditionMessage(m))
        output$install_log_qploidy <- renderUI(
          pre(style = "font-size:11px; white-space:pre-wrap;",
              paste(log_lines, collapse = ""))
        )
        invokeRestart("muffleMessage")
      }

      withCallingHandlers(
        tryCatch({
          if (!requireNamespace("remotes", quietly = TRUE)) {
            incProgress(0.05, detail = "Installing remotes...")
            install.packages("remotes")
          }
          incProgress(0.1, detail = "Contacting GitHub...")
          remotes::install_github(
            "Cristianetaniguti/Qploidy",
            upgrade = "never",
            quiet   = FALSE
          )
          incProgress(0.9, detail = "Verifying...")
          ok <- requireNamespace("Qploidy", quietly = TRUE)
          incProgress(1,   detail = "Done")
        }, error = function(e) {
          err_msg <<- conditionMessage(e)
        }),
        message = capture_msg
      )
    })

    if (ok) {
      qploidy_installed(TRUE)
      showNotification("Qploidy installed successfully.", type = "message", duration = 8)
      output$install_log_qploidy <- renderUI(HTML(
        paste0(if (length(log_lines)) paste0('<pre style="font-size:11px;white-space:pre-wrap;">', paste(log_lines, collapse=""), '</pre>'),
               'Qploidy installation completed. <b style="color:#d9534f;">Restart</b> the app to load Qploidy features.')
      ))
    } else {
      showNotification("Qploidy installation failed. See log below.", type = "error", duration = NULL)
      output$install_log_qploidy <- renderUI(
        pre(style = "font-size:11px; white-space:pre-wrap; color:#c62828;",
            if (is.null(err_msg)) "Unknown error (check server permissions/logs)." else
              paste(c(log_lines, err_msg), collapse = ""))
      )
    }
  })

  # --- Familia installation ----------------------------------------------
  observeEvent(input$install_familia, {
    err_msg <- NULL
    ok      <- FALSE
    log_lines <- character(0)

    output$install_log_familia <- renderUI(NULL)

    withProgress(message = "Installing familia", value = 0, {

      capture_msg <- function(m) {
        log_lines <<- c(log_lines, conditionMessage(m))
        output$install_log_familia <- renderUI(
          pre(style = "font-size:11px; white-space:pre-wrap;",
              paste(log_lines, collapse = ""))
        )
        invokeRestart("muffleMessage")
      }

      withCallingHandlers(
        tryCatch({
          if (!requireNamespace("remotes", quietly = TRUE)) {
            incProgress(0.05, detail = "Installing remotes...")
            install.packages("remotes")
          }
          incProgress(0.1, detail = "Contacting GitHub...")
          remotes::install_github(
            "Breeding-Insight/familia",
            upgrade = "never",
            quiet   = FALSE
          )
          incProgress(0.9, detail = "Verifying...")
          ok <- requireNamespace("familia", quietly = TRUE)
          incProgress(1,   detail = "Done")
        }, error = function(e) {
          err_msg <<- conditionMessage(e)
        }),
        message = capture_msg
      )
    })

    if (ok) {
      familia_installed(TRUE)
      showNotification("familia installed successfully.", type = "message", duration = 8)
      output$install_log_familia <- renderUI(HTML(
        paste0(if (length(log_lines)) paste0('<pre style="font-size:11px;white-space:pre-wrap;">', paste(log_lines, collapse=""), '</pre>'),
               'familia installation completed. <b style="color:#d9534f;">Restart</b> the app to load familia features.')
      ))
    } else {
      showNotification("familia installation failed. See log below.", type = "error", duration = NULL)
      output$install_log_familia <- renderUI(
        pre(style = "font-size:11px; white-space:pre-wrap; color:#c62828;",
            if (is.null(err_msg)) "Unknown error (check server permissions/logs)." else
              paste(c(log_lines, err_msg), collapse = ""))
      )
    }
  })

  # --- AlloMate installation ----------------------------------------------
  observeEvent(input$install_allomate, {
    err_msg <- NULL
    ok      <- FALSE
    log_lines <- character(0)

    output$install_log_allomate <- renderUI(NULL)

    withProgress(message = "Installing AlloMate", value = 0, {

      capture_msg <- function(m) {
        log_lines <<- c(log_lines, conditionMessage(m))
        output$install_log_allomate <- renderUI(
          pre(style = "font-size:11px; white-space:pre-wrap;",
              paste(log_lines, collapse = ""))
        )
        invokeRestart("muffleMessage")
      }

      withCallingHandlers(
        tryCatch({
          if (!requireNamespace("remotes", quietly = TRUE)) {
            incProgress(0.05, detail = "Installing remotes...")
            install.packages("remotes")
          }
          incProgress(0.1, detail = "Contacting GitHub...")
          remotes::install_github(
            "Breeding-Insight/AlloMate",
            upgrade = "never",
            ref     = "development",
            quiet   = FALSE
          )
          incProgress(0.9, detail = "Verifying...")
          ok <- requireNamespace("AlloMate", quietly = TRUE)
          incProgress(1,   detail = "Done")
        }, error = function(e) {
          err_msg <<- conditionMessage(e)
        }),
        message = capture_msg
      )
    })

    if (ok) {
      allomate_installed(TRUE)
      showNotification("AlloMate installed successfully.", type = "message", duration = 8)
      output$install_log_allomate <- renderUI(HTML(
        paste0(if (length(log_lines)) paste0('<pre style="font-size:11px;white-space:pre-wrap;">', paste(log_lines, collapse=""), '</pre>'),
               'AlloMate installation completed. <b style="color:#d9534f;">Restart</b> the app to load AlloMate features.')
      ))
    } else {
      showNotification("AlloMate installation failed. See log below.", type = "error", duration = NULL)
      output$install_log_allomate <- renderUI(
        pre(style = "font-size:11px; white-space:pre-wrap; color:#c62828;",
            if (is.null(err_msg)) "Unknown error (check server permissions/logs)." else
              paste(c(log_lines, err_msg), collapse = ""))
      )
    }
  })

  # --- BIGapp installation -----------------------------------------------
  observeEvent(input$install_bigapp, {
    err_msg <- NULL
    ok      <- FALSE
    log_lines <- character(0)

    output$install_log_BIGapp <- renderUI(NULL)

    withProgress(message = "Installing BIGapp", value = 0, {

      capture_msg <- function(m) {
        log_lines <<- c(log_lines, conditionMessage(m))
        output$install_log_BIGapp <- renderUI(
          pre(style = "font-size:11px; white-space:pre-wrap;",
              paste(log_lines, collapse = ""))
        )
        invokeRestart("muffleMessage")
      }

      withCallingHandlers(
        tryCatch({
          if (!requireNamespace("remotes", quietly = TRUE)) {
            incProgress(0.05, detail = "Installing remotes...")
            install.packages("remotes")
          }
          incProgress(0.1, detail = "Contacting GitHub...")
          remotes::install_github(
            "Breeding-Insight/BIGapp",
            upgrade = "never",
            quiet   = FALSE
          )
          incProgress(0.9, detail = "Verifying...")
          ok <- requireNamespace("BIGapp", quietly = TRUE)
          incProgress(1,   detail = "Done")
        }, error = function(e) {
          err_msg <<- conditionMessage(e)
        }),
        message = capture_msg
      )
    })

    if (ok) {
      bigapp_installed(TRUE)
      showNotification("BIGapp installed successfully.", type = "message", duration = 8)
      output$install_log_BIGapp <- renderUI(HTML(
        paste0(if (length(log_lines)) paste0('<pre style="font-size:11px;white-space:pre-wrap;">', paste(log_lines, collapse=""), '</pre>'),
               'BIGapp installation completed. <b style="color:#d9534f;">Restart</b> the app to load BIGapp features.')
      ))
    } else {
      showNotification("BIGapp installation failed. See log below.", type = "error", duration = NULL)
      output$install_log_BIGapp <- renderUI(
        pre(style = "font-size:11px; white-space:pre-wrap; color:#c62828;",
            if (is.null(err_msg)) "Unknown error (check server permissions/logs)." else
              paste(c(log_lines, err_msg), collapse = ""))
      )
    }
  })

  # --- GenoBrew installation ----------------------------------------------
  observeEvent(input$install_genobrew, {
    err_msg <- NULL
    ok      <- FALSE
    log_lines <- character(0)

    output$install_log_genobrew <- renderUI(NULL)

    withProgress(message = "Installing GenoBrew", value = 0, {

      capture_msg <- function(m) {
        log_lines <<- c(log_lines, conditionMessage(m))
        output$install_log_genobrew <- renderUI(
          pre(style = "font-size:11px; white-space:pre-wrap;",
              paste(log_lines, collapse = ""))
        )
        invokeRestart("muffleMessage")
      }

      withCallingHandlers(
        tryCatch({
          if (!requireNamespace("remotes", quietly = TRUE)) {
            incProgress(0.05, detail = "Installing remotes...")
            install.packages("remotes")
          }
          incProgress(0.1, detail = "Contacting GitHub...")
          remotes::install_github(
            "Breeding-Insight/GenoBrew",
            upgrade = "never",
            quiet   = FALSE
          )
          incProgress(0.9, detail = "Verifying...")
          ok <- requireNamespace("GenoBrew", quietly = TRUE)
          incProgress(1,   detail = "Done")
        }, error = function(e) {
          err_msg <<- conditionMessage(e)
        }),
        message = capture_msg
      )
    })

    if (ok) {
      genobrew_installed(TRUE)
      showNotification("GenoBrew installed successfully.", type = "message", duration = 8)
      output$install_log_genobrew <- renderUI(HTML(
        paste0(if (length(log_lines)) paste0('<pre style="font-size:11px;white-space:pre-wrap;">', paste(log_lines, collapse=""), '</pre>'),
               'GenoBrew installation completed. <b style="color:#d9534f;">Restart</b> the app to load GenoBrew features.')
      ))
    } else {
      showNotification("GenoBrew installation failed. See log below.", type = "error", duration = NULL)
      output$install_log_genobrew <- renderUI(
        pre(style = "font-size:11px; white-space:pre-wrap; color:#c62828;",
            if (is.null(err_msg)) "Unknown error (check server permissions/logs)." else
              paste(c(log_lines, err_msg), collapse = ""))
      )
    }
  })


}

## To be copied in the UI
# mod_install_ui("install_1")

## To be copied in the server
# mod_install_server("install_1")
