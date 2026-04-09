#' qploidy placeholder UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList includeMarkdown
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
  
  output$qploidyInstalled <- reactive({ qploidy_installed() })
  outputOptions(output, "qploidyInstalled", suspendWhenHidden = FALSE)
  
  output$familiaInstalled <- reactive({ familia_installed() })
  outputOptions(output, "familiaInstalled", suspendWhenHidden = FALSE)
  
  output$BIGappInstalled <- reactive({ bigapp_installed() })
  outputOptions(output, "BIGappInstalled", suspendWhenHidden = FALSE)
  
  output$allomateInstalled <- reactive({ allomate_installed() })
  outputOptions(output, "allomateInstalled", suspendWhenHidden = FALSE)
  
  # Initialize logs as empty
  output$install_log_qploidy <- renderUI(NULL)
  output$install_log_BIGapp <- renderUI(NULL)
  output$install_log_familia <- renderUI(NULL)
  output$install_log_allomate <- renderUI(NULL)
  
  # --- Qploidy installation ----------------------------------------------
  observeEvent(input$install_qploidy, {
    err_msg <- NULL
    ok <- FALSE
    
    showNotification("Installing Qploidy...", type = "message")
    
    # clear previous log
    output$install_log_qploidy <- renderUI(NULL)
    
    tryCatch({
      if (!requireNamespace("remotes", quietly = TRUE)) {
        install.packages("remotes")
      }
      
      remotes::install_github(
        "Cristianetaniguti/Qploidy",
        upgrade = "never",
        quiet = TRUE
      )
      
      ok <- requireNamespace("Qploidy", quietly = TRUE)
    }, error = function(e) {
      err_msg <<- conditionMessage(e)
    })
    
    if (ok) {
      qploidy_installed(TRUE)
      showNotification(
        "Qploidy installed successfully.",
        type = "message",
        duration = 8
      )
      output$install_log_qploidy <- renderUI(HTML(
        'Qploidy installation completed. <b style="color:#d9534f;">Restart</b> the app to load Qploidy features.'
      ))
    } else {
      showNotification(
        "Qploidy installation failed. See details below.",
        type = "error",
        duration = NULL
      )
      output$install_log_qploidy <- renderUI(
        if (is.null(err_msg))
          "Unknown error (check server permissions/logs)."
        else
          err_msg
      )
    }
  })
  
  # --- Familia installation ----------------------------------------------
  observeEvent(input$install_familia, {
    err_msg <- NULL
    ok <- FALSE
    
    showNotification("Installing familia...", type = "message")
    
    # clear previous log
    output$install_log_familia <- renderUI(NULL)
    
    tryCatch({
      if (!requireNamespace("remotes", quietly = TRUE)) {
        install.packages("remotes")
      }
      
      remotes::install_github(
        "Breeding-Insight/familia",
        upgrade = "never",
        quiet = TRUE
      )
      
      ok <- requireNamespace("familia", quietly = TRUE)
    }, error = function(e) {
      err_msg <<- conditionMessage(e)
    })
    
    if (ok) {
      familia_installed(TRUE)
      showNotification(
        "familia installed successfully.",
        type = "message",
        duration = 8
      )
      output$install_log_familia <- renderUI(HTML(
        'familia installation completed. <b style="color:#d9534f;">Restart</b> the app to load familia features.'
      ))
    } else {
      showNotification(
        "familia installation failed. See details below.",
        type = "error",
        duration = NULL
      )
      output$install_log_familia <- renderUI(
        if (is.null(err_msg))
          "Unknown error (check server permissions/logs)."
        else
          err_msg
      )
    }
  })
  
  # --- AlloMate installation ----------------------------------------------
  observeEvent(input$install_allomate, {
    err_msg <- NULL
    ok <- FALSE
    
    showNotification("Installing AlloMate...", type = "message")
    
    # clear previous log
    output$install_log_allomate <- renderUI(NULL)
    
    tryCatch({
      if (!requireNamespace("remotes", quietly = TRUE)) {
        install.packages("remotes")
      }
      
      remotes::install_github(
        "Breeding-Insight/AlloMate",
        upgrade = "never",
        ref="development",
        quiet = TRUE
      )
      
      ok <- requireNamespace("AlloMate", quietly = TRUE)
    }, error = function(e) {
      err_msg <<- conditionMessage(e)
    })
    
    if (ok) {
      allomate_installed(TRUE)
      showNotification(
        "AlloMate installed successfully.",
        type = "message",
        duration = 8
      )
      output$install_log_allomate <- renderUI(HTML(
        'AlloMate installation completed. <b style="color:#d9534f;">Restart</b> the app to load AlloMate features.'
      ))
    } else {
      showNotification(
        "AlloMate installation failed. See details below.",
        type = "error",
        duration = NULL
      )
      output$install_log_allomate <- renderUI(
        if (is.null(err_msg))
          "Unknown error (check server permissions/logs)."
        else
          err_msg
      )
    }
  })
  
  # --- BIGapp installation -----------------------------------------------
  observeEvent(input$install_bigapp, {
    err_msg <- NULL
    ok <- FALSE
    
    showNotification("Installing BIGapp...", type = "message")
    
    # clear previous log
    output$install_log_BIGapp <- renderUI(NULL)
    
    tryCatch({
      if (!requireNamespace("remotes", quietly = TRUE)) {
        install.packages("remotes")
      }
      
      remotes::install_github(
        "Breeding-Insight/BIGapp",
        upgrade = "never",
        quiet = TRUE
      )
      
      ok <- requireNamespace("BIGapp", quietly = TRUE)
    }, error = function(e) {
      err_msg <<- conditionMessage(e)
    })
    
    if (ok) {
      bigapp_installed(TRUE)
      showNotification(
        "BIGapp installed successfully.",
        type = "message",
        duration = 8
      )
      output$install_log_BIGapp <- renderUI(HTML(
        'BIGapp installation completed. <b style="color:#d9534f;">Restart</b> the app to load BIGapp features.'
      ))
    } else {
      showNotification(
        "BIGapp installation failed. See details below.",
        type = "error",
        duration = NULL
      )
      output$install_log_BIGapp <- renderUI(
        if (is.null(err_msg))
          "Unknown error (check server permissions/logs)."
        else
          err_msg
      )
    }
  })
}

## To be copied in the UI
# mod_install_ui("install_1")

## To be copied in the server
# mod_install_server("install_1")
