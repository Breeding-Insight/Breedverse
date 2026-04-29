#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom bs4Dash bs4Badge bs4DashSidebar bs4DashNavbar bs4DashPage sidebarMenu menuItem menuSubItem dashboardBody tabItems tabItem box dashboardFooter
#' @importFrom shinydisconnect disconnectMessage
#' @import shinyWidgets
#' @importFrom utils getFromNamespace
#'
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    bs4DashPage(
      skin = "black",
      bs4DashNavbar(
        title = tagList(
          tags$img(src = 'www/BreedingInsight.png', height = '40', width = '50'),
        ),
        rightUi = tags$li(
          class = "dropdown",
          tags$a(
            href = "#",
            class = "nav-link",
            `data-toggle` = "dropdown",
            icon("info-circle")
          ),
          tags$div(
            class = "dropdown-menu dropdown-menu-right",
            tags$a(
              class = "dropdown-item",
              href = "#",
              "Session Info",
              onclick = "Shiny.setInputValue('session_info_button', Math.random())"
            ),
            tags$a(
              class = "dropdown-item",
              href = "#",
              "Check for Updates",
              onclick = "Shiny.setInputValue('updates_info_button', Math.random())"
            )
          )
        )
      ),
      help = NULL, #This is the default bs4Dash button to control the presence of tooltips and popovers, which can be added as a user help/info feature.
      bs4DashSidebar(
        skin="light",
        status = "info",
        fixed=TRUE,
        #minified = F,
        expandOnHover = TRUE,
        sidebarMenu(id = "MainMenu",
                    flat = FALSE,
                    tags$li(class = "header", style = "color: grey; margin-top: 10px; margin-bottom: 10px; padding-left: 15px;", "Menu"),
                    menuItem("Home", tabName = "welcome", icon = icon("house"),startExpanded = FALSE),
                    menuItem("Install modules", tabName = "install", icon = icon("share-from-square")),

                    # conditionalPanel(
                    #   condition = "output.qploidyInstalled == true",
                    #   tags$li(class = "header", style = "color: grey; margin-top: 18px; margin-bottom: 10px; padding-left: 15px;", "Ploidy Estimation"),
                    #   menuItem("Qploidy", tabName = "qploidy", icon = icon("dna")),
                    # ),

                    conditionalPanel(
                      condition = "output.familiaInstalled == true",
                      tags$li(class = "header", style = "color: grey; margin-top: 18px; margin-bottom: 10px; padding-left: 15px;", "Ancestry (R/familia)"),
                      menuItem(
                        "familia",
                        icon = icon("seedling"),
                        startExpanded = FALSE,
                        menuSubItem("Supervised", tabName = "snmf", icon = icon("list-ol")),
                        menuSubItem("Unsupervised", tabName = "polybreedtools", icon = icon("share-from-square"))
                      )
                    ),

                    conditionalPanel(
                      condition = "output.allomateInstalled == true",
                      tags$li(class = "header", style = "color: grey; margin-top: 18px; margin-bottom: 10px; padding-left: 15px;", "Mating Estimation (R/AlloMate)"),
                      menuItem("AlloMate", tabName = "allomate", icon = icon("diagram-project"))
                    ),

                    conditionalPanel(
                      condition = "output.BIGappInstalled == true",
                      tags$li(class = "header", style = "color: grey; margin-top: 18px; margin-bottom: 10px; padding-left: 15px;", "Genotype Processing"),
                      menuItem(
                        "BIGapp",
                        icon = icon("dna"),
                        startExpanded = FALSE,
                        menuSubItem("Convert to VCF", tabName = "dosage2vcf", icon = icon("share-from-square")),
                        menuSubItem("Dosage Calling", tabName = "updog", icon = icon("list-ol")),
                        menuSubItem("VCF Filtering", tabName = "filtering", icon = icon("filter")),
                        menuSubItem("Genomic Diversity", tabName = "diversity", icon = icon("chart-pie")),
                        menuSubItem("PCA", tabName = "pca", icon = icon("chart-simple")),
                        menuSubItem("DAPC", tabName = "dapc", icon = icon("circle-nodes")),
                        menuSubItem("GWASpoly", tabName = "gwas", icon = icon("think-peaks")),
                        menuSubItem("Predictive Ability", tabName = "prediction_accuracy", icon = icon("right-left")),
                        menuSubItem("Genomic Prediction", tabName = "prediction", icon = icon("angles-right"))
                      )
                    ),
                    conditionalPanel(
                      condition = "output.genobrewInstalled == true",
                      tags$li(class = "header", style = "color: grey; margin-top: 18px; margin-bottom: 10px; padding-left: 15px;", "Marker Panel Test &\n CNV Profiles"),
                      menuItem(
                        "GenoBrew",
                        icon = icon("dna"),
                        startExpanded = FALSE,
                        menuSubItem("Select Markers", tabName = "mk_select", icon = icon("magnifying-glass")),
                        menuSubItem("CNV profiles", tabName = "cnv", icon = icon("dna"))
                      )
                    ),

                    tags$li(class = "header", style = "color: grey; margin-top: 18px; margin-bottom: 10px; padding-left: 15px;", "Information"),
                    menuItem("Source Code", icon = icon("circle-info"), href = "https://www.github.com/Breeding-Insight/Genomics_Shiny_App"),
                    menuItem("Help", tabName = "help", icon = icon("circle-question"))
        )
      ),
      footer = dashboardFooter(
        right = div(
          style = "display: flex; align-items: center;",  # Align text and images horizontally
          div(
            style = "display: flex; flex-direction: column; margin-right: 15px; text-align: right;",
            div("2026 Breeding Insight"),
            div("Funded by USDA through UF|IFAS")
          ),
          div(
            a(
              img(src = "www/usda-logo-color.png", height = "45px"),
              style = "margin-right: 15px;"
            ),
            a(
              img(src = "www/cornell_seal_simple_web_b31b1b.png", height = "45px")
            ),
            a(
              img(src = "www/IFAS.jpg", height = "45px")
            )
          )
        ),
        left = div(
          style = "display: flex; align-items: center; height: 100%;",
          sprintf("v%s", as.character(utils::packageVersion("Breedverse"))))
      ),
      dashboardBody(
        disconnectMessage(), #Adds generic error message for any error if not already accounted for
        tabItems(
          tabItem(
            tabName = "welcome", mod_Home_ui("Home_1")
          ),
          tabItem(
            tabName = "install", mod_install_ui("install_1")
          ),
          # tabItem(
          #   tabName = "qploidy",
          #   if(isTRUE(requireNamespace("Qploidy", quietly = TRUE)))
          #     getFromNamespace("mod_qploidy_ui", "Qploidy")("qploidy_1")
          # ),
          tabItem(
            tabName = "snmf",
            if(isTRUE(requireNamespace("familia", quietly = TRUE)))
              getFromNamespace("mod_SNMF_ui", "familia")("SNMF_1")
          ),
          tabItem(
            tabName = "polybreedtools",
            if(isTRUE(requireNamespace("familia", quietly = TRUE)))
              getFromNamespace("mod_polybreedtools_ui", "familia")("PolyBreedTools_1")
          ),
          tabItem(
            tabName = "allomate",
            if(isTRUE(requireNamespace("AlloMate", quietly = TRUE)))
              getFromNamespace("mod_allomate_ui", "AlloMate")("allomate_1")
          ),
          tabItem(
            tabName = "filtering",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_Filtering_ui", "BIGapp")("Filtering_1")
          ),
          tabItem(
            tabName = "updog",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_DosageCall_ui", "BIGapp")("DosageCall_1")
          ),
          tabItem(
            tabName = "dosage2vcf",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_dosage2vcf_ui", "BIGapp")("dosage2vcf_1")
          ),
          tabItem(
            tabName = "pca",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_PCA_ui", "BIGapp")("PCA_1")
          ),
          tabItem(
            tabName = "dapc",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_dapc_ui", "BIGapp")("dapc_1")
          ),
          tabItem(
            tabName = "gwas",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_gwas_ui", "BIGapp")("gwas_1")
          ),
          tabItem(
            tabName = "diversity",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_diversity_ui", "BIGapp")("diversity_1")
          ),
          tabItem(
            tabName = "prediction_accuracy",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_GSAcc_ui", "BIGapp")("GSAcc_1")
          ),
          tabItem(
            tabName = "prediction",
            if(isTRUE(requireNamespace("BIGapp", quietly = TRUE)))
              getFromNamespace("mod_GS_ui", "BIGapp")("GS_1")
          ),
          tabItem(
            tabName = "mk_select",
            if(isTRUE(requireNamespace("GenoBrew", quietly = TRUE)))
              getFromNamespace("mod_mk_select_ui", "GenoBrew")("mk_select_1")
          ),
          tabItem(
            tabName = "cnv",
            if(isTRUE(requireNamespace("GenoBrew", quietly = TRUE)))
              getFromNamespace("mod_cnv_ui", "GenoBrew")("cnv_1")
          ),
          tabItem(
            tabName = "help", mod_help_ui("help_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Breedverse"
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    tags$style(HTML("
      /* Ensure box collapse/expand buttons are always on top */
      .card-tools { position: relative; z-index: 10; }
      /* Make collapse/expand icons visible on white box headers */
      .card-tools .btn-tool { color: #495057 !important; }
      .card-tools .btn-tool:hover { color: #212529 !important; }
    ")),
    tags$script(HTML("
      $(document).ready(function() {
        // On page load: mirror active class from <li> onto <a> for CSS targeting
        $('#cnv_1-sample_select_tabs li.active > a').addClass('active');

        // After each tab switch (content already swapped): sync active on <a> only
        $(document).on('shown.bs.tab', '#cnv_1-sample_select_tabs a[data-toggle=\"tab\"]', function(e) {
          $('#cnv_1-sample_select_tabs a[data-toggle=\"tab\"]').removeClass('active');
          $(e.target).addClass('active');
        });
      });
    "))
  )
}
