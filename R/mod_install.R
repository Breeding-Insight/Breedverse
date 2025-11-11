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
      .install-card {
        border-radius: 8px;
        border: 1px solid #e0e0e0;
        padding: 18px 20px;
        margin-bottom: 20px;
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
              p("BIGapp is installed. You can now access BIGapp features in the app.")
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
      )
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
  bigapp_installed <- reactiveVal(
    requireNamespace("BIGapp", quietly = TRUE)
  )
  
  output$qploidyInstalled <- reactive({ qploidy_installed() })
  outputOptions(output, "qploidyInstalled", suspendWhenHidden = FALSE)
  
  output$BIGappInstalled <- reactive({ bigapp_installed() })
  outputOptions(output, "BIGappInstalled", suspendWhenHidden = FALSE)
  
  # Initialize logs as empty
  output$install_log_qploidy <- renderUI(NULL)
  output$install_log_BIGapp <- renderUI(NULL)
  
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
