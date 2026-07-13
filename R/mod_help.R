#' help UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList includeMarkdown
#'
mod_help_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      column(width = 12),
      column(
        width = 12,
        div(
          style = "padding: 20px;",
          div(
            style = "text-align: center; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 2px solid #17a2b8;",
            tags$h2("Help Documentation", style = "color: #17a2b8; margin-bottom: 10px;"),
            tags$p("Click a module to expand its help section.",
              style = "color: #666; font-size: 16px;"
            )
          )
        ),
        ### AlloMate
        conditionalPanel(
          condition = "output.allomateInstalled == true",
          div(
            style = "display: flex; align-items: center; margin: 10px 0 20px 0; padding: 12px 16px; background: linear-gradient(135deg, #f0f7ff 0%, #e8f4fd 100%); border-left: 4px solid #17a2b8; border-radius: 0 6px 6px 0;",
            tags$img(src = "www/allomate_logo.png", height = "50px", style = "margin-right: 14px;"),
            div(
              tags$h4("AlloMate Help Material", style = "margin: 0; color: #17a2b8; font-weight: 600;"),
              tags$p("Documentation and guides for the AlloMate ancestry estimation modules.", style = "margin: 3px 0 0 0; color: #666; font-size: 13px;")
            )
          ),
          shiny::uiOutput(ns("help_accordion_allomate")),
        ),
        conditionalPanel(
          condition = "output.BIGappInstalled == true",
          div(
            style = "display: flex; align-items: center; margin: 10px 0 20px 0; padding: 12px 16px; background: linear-gradient(135deg, #f0f7ff 0%, #e8f4fd 100%); border-left: 4px solid #17a2b8; border-radius: 0 6px 6px 0;",
            tags$img(src = "www/BIG_R_logo.png", height = "50px", style = "margin-right: 14px;"),
            div(
              tags$h4("BIGapp Help Material", style = "margin: 0; color: #17a2b8; font-weight: 600;"),
              tags$p("Documentation and guides for the BIGapp genomic analysis modules.", style = "margin: 3px 0 0 0; color: #666; font-size: 13px;")
            )
          ),
          box(
            title = "Convert to VCF", id = "DArT_Report2VCF_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab converts the processed genotype and counts files from DArT into a VCF file (v4.3). This file can then be used as the genotype input for the analyses within BIGapp or used with other genomics applications.",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "DArT_Report2VCF_tabset",
              tabPanel("Parameters description",
                value = "DArT_Report2VCF_par", br(),
                includeMarkdown(system.file("help_files/DArT_Report2VCF_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "DArT_Report2VCF_results", br(),
                includeMarkdown(system.file("help_files/DArT_Report2VCF_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "DArT_Report2VCF_cite", br(),
                includeMarkdown(system.file("help_files/DArT_Report2VCF_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "Dosage Calling", id = "Updog_Dosage_Calling_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab is designed to handle the process of dosage calling in genomic data. Dosage calling is essential for determining the number of copies of a particular allele at each genomic location.",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "Updog_Dosage_Calling_tabset",
              tabPanel("Parameters description",
                value = "Updog_Dosage_Calling_par", br(),
                includeMarkdown(system.file("help_files/Updog_Dosage_Calling_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "Updog_Dosage_Calling_results", br(),
                includeMarkdown(system.file("help_files/Updog_Dosage_Calling_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "Updog_Dosage_Calling_cite", br(),
                includeMarkdown(system.file("help_files/Updog_Dosage_Calling_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "VCF Filtering", id = "VCF_Filtering_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "Filter SNPs and samples in a VCF file based on missing data, minor allele frequency, read depth, and Updog dosage calling metrics",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "VCF_Filtering_tabset",
              tabPanel("Parameters description",
                value = "VCF_Filtering_par", br(),
                includeMarkdown(system.file("help_files/VCF_Filtering_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "VCF_Filtering_results", br(),
                includeMarkdown(system.file("help_files/VCF_Filtering_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "VCF_Filtering_cite", br(),
                includeMarkdown(system.file("help_files/VCF_Filtering_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "PCA", id = "PCA_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab is used to perform a PCA to visualize the genomic relationships between samples (population structure)",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "PCA_tabset",
              tabPanel("Parameters description",
                value = "PCA_par", br(),
                includeMarkdown(system.file("help_files/PCA_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "PCA_results", br(),
                includeMarkdown(system.file("help_files/PCA_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "PCA_cite", br(),
                includeMarkdown(system.file("help_files/PCA_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "DAPC", id = "DAPC_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab group estimates the number of distinct groups that are present within the genomic dataset, and classifies each sample into a distinct group.",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "DAPC_tabset",
              tabPanel("Parameters description",
                value = "DAPC_par", br(),
                includeMarkdown(system.file("help_files/DAPC_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "DAPC_results", br(),
                includeMarkdown(system.file("help_files/DAPC_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "DAPC_cite", br(),
                includeMarkdown(system.file("help_files/DAPC_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "Genomic Diversity", id = "Genomic_Diversity_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab estimates summary metrics for the samples and SNPs within a genomic dataset and produces figures and tables.",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "Genomic_Diversity_tabset",
              tabPanel("Parameters description",
                value = "Genomic_Diversity_par", br(),
                includeMarkdown(system.file("help_files/Genomic_Diversity_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "Genomic_Diversity_results", br(),
                includeMarkdown(system.file("help_files/Genomic_Diversity_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "Genomic_Diversity_cite", br(),
                includeMarkdown(system.file("help_files/Genomic_Diversity_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "GWAS", id = "GWAS_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "The tab is for conducting Genome-Wide Association Studies (GWAS) to identify associations between genetic variants and traits of interest. Users can input phenotypic data and specify parameters for the GWAS analysis. The app performs statistical tests to identify significant associations between SNPs and traits, and visualizes the results using Manhattan plots and Q-Q plots. The tab helps in identifying potential genetic markers linked to specific traits. GWASpoly package is used to perform the analysis.",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "GWAS_tabset",
              tabPanel("Parameters description",
                value = "GWAS_par", br(),
                includeMarkdown(system.file("help_files/GWAS_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "GWAS_results", br(),
                includeMarkdown(system.file("help_files/GWAS_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "GWAS_cite", br(),
                includeMarkdown(system.file("help_files/GWAS_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "Predictive Ability", id = "Predictive_Ability_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab provides the predictive ability of a GBLUP model for each trait across all samples within a genomic dataset",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "Predictive_Ability_tabset",
              tabPanel("Parameters description",
                value = "Predictive_Ability_par", br(),
                includeMarkdown(system.file("help_files/Predictive_Ability_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "Predictive_Ability_results", br(),
                includeMarkdown(system.file("help_files/Predictive_Ability_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "Predictive_Ability_cite", br(),
                includeMarkdown(system.file("help_files/Predictive_Ability_cite.Rmd", package = "BIGapp"))
              )
            )
          ),
          box(
            title = "Genomic Prediction", id = "Genomic_Prediction_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "his tab estimates the trait and estimated-breeding-values (EBVs) for either all individuals in a genomic dataset, or by training the model with one genomic dataset to predict the values in another.",
            br(), br(),
            bs4Dash::tabsetPanel(
              id = "Genomic_Prediction_tabset",
              tabPanel("Parameters description",
                value = "Genomic_Prediction_par", br(),
                includeMarkdown(system.file("help_files/Genomic_Prediction_par.Rmd", package = "BIGapp"))
              ),
              tabPanel("Results description",
                value = "Genomic_Prediction_results", br(),
                includeMarkdown(system.file("help_files/Genomic_Prediction_res.Rmd", package = "BIGapp"))
              ),
              tabPanel("How to cite",
                value = "Genomic_Prediction_cite", br(),
                includeMarkdown(system.file("help_files/Genomic_Prediction_cite.Rmd", package = "BIGapp"))
              )
            )
          )
        ),
        ### Familia
        conditionalPanel(
          condition = "output.FamiliaInstalled == true",
          div(
            style = "display: flex; align-items: center; margin: 10px 0 20px 0; padding: 12px 16px; background: linear-gradient(135deg, #f0f7ff 0%, #e8f4fd 100%); border-left: 4px solid #17a2b8; border-radius: 0 6px 6px 0;",
            tags$img(src = "www/familia_logo.png", height = "50px", style = "margin-right: 14px;"),
            div(
              tags$h4("Familia Help Material", style = "margin: 0; color: #17a2b8; font-weight: 600;"),
              tags$p("Documentation and guides for the Familia ancestry estimation modules.", style = "margin: 3px 0 0 0; color: #666; font-size: 13px;")
            )
          ),
          shiny::uiOutput(ns("help_accordion")),
        ),

        ### GenoBrew
        conditionalPanel(
          condition = "output.genobrewInstalled == true",
          div(
            style = "display: flex; align-items: center; margin: 10px 0 20px 0; padding: 12px 16px; background: linear-gradient(135deg, #f0f7ff 0%, #e8f4fd 100%); border-left: 4px solid #17a2b8; border-radius: 0 6px 6px 0;",
            tags$img(src = "www/GenoBrew_logo.png", height = "50px", style = "margin-right: 14px;"),
            div(
              tags$h4("GenoBrew Help Material", style = "margin: 0; color: #17a2b8; font-weight: 600;"),
              tags$p("Documentation and guides for the GenoBrew marker panel and CNV modules.", style = "margin: 3px 0 0 0; color: #666; font-size: 13px;")
            )
          ),
          box(
            title = "Select Markers", id = "GenoBrew_Inputs_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "Here you will find detailed description of the Select Markers module inputs and outputs. Please access the tutorial for a step-by-step guide:",
            br(), br(),
            tabsetPanel(
              id = "Select_markers_tabset",
              tabPanel("Parameters description",
                value = "Select_markers_par", br(),
                includeMarkdown(system.file("help_files/GenoBrew_select_markers_par.Rmd", package = "GenoBrew"))
              ),
              tabPanel("Results description",
                value = "Select_markers_results", br(),
                includeMarkdown(system.file("help_files/GenoBrew_select_markers_res.Rmd", package = "GenoBrew"))
              ),
              tabPanel("How to cite",
                value = "Select_markers_cite", br(),
                includeMarkdown(system.file("help_files/GenoBrew_select_markers_cite.Rmd", package = "GenoBrew"))
              )
            )
          ),
          box(
            title = "CNV Profiles", id = "QTL_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "Here you will find detailed description of the CNV Profiles module inputs and outputs. Please access the tutorial for a step-by-step guide:",
            br(), br(),
            tabsetPanel(
              id = "CNV_profiles_tabset",
              tabPanel("Parameters description",
                value = "CNV_profiles_par", br(),
                includeMarkdown(system.file("help_files/GenoBrew_CNV_profile_par.Rmd", package = "GenoBrew"))
              ),
              tabPanel("Results description",
                value = "CNV_profiles_results", br(),
                includeMarkdown(system.file("help_files/GenoBrew_CNV_profile_res.Rmd", package = "GenoBrew"))
              ),
              tabPanel("How to cite",
                value = "CNV_profiles_cite", br(),
                includeMarkdown(system.file("help_files/GenoBrew_CNV_profile_cite.Rmd", package = "GenoBrew"))
              )
            )
          )
        ),
        conditionalPanel(
          condition = "output.viewpolyInstalled == true",
          div(
            style = "display: flex; align-items: center; margin: 10px 0 20px 0; padding: 12px 16px; background: linear-gradient(135deg, #f0f7ff 0%, #e8f4fd 100%); border-left: 4px solid #17a2b8; border-radius: 0 6px 6px 0;",
            tags$img(src = "www/viewpoly_logo.png", height = "50px", style = "margin-right: 14px;"),
            div(
              tags$h4("VIEWpoly Help Material", style = "margin: 0; color: #17a2b8; font-weight: 600;"),
              tags$p("Documentation and guides for the VIEWpoly multi-tool integration and QTL visualization modules.", style = "margin: 3px 0 0 0; color: #666; font-size: 13px;")
            )
          ),
          box(
            title = "Input Data", id = "Inputs_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab allows users to upload and manage input data for analysis.",
            br(), br(),
            tabsetPanel(
              id = "Inputs_tabset",
              tabPanel("Parameters description",
                value = "Inputs_par", br(),
                includeMarkdown(system.file("help_files/Inputs_par.Rmd", package = "viewpoly"))
              ),
              tabPanel("Results description",
                value = "Inputs_results", br(),
                includeMarkdown(system.file("help_files/Inputs_res.Rmd", package = "viewpoly"))
              ),
              tabPanel("How to cite",
                value = "Inputs_cite", br(),
                includeMarkdown(system.file("help_files/Inputs_cite.Rmd", package = "viewpoly"))
              )
            )
          ),
          box(
            title = "ViewQTL", id = "QTL_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab allows users to upload and manage input data for analysis.",
            br(), br(),
            tabsetPanel(
              id = "QTL_tabset",
              tabPanel("Parameters description",
                value = "QTL_par", br(),
                includeMarkdown(system.file("help_files/QTL_par.Rmd", package = "viewpoly"))
              ),
              tabPanel("Results description",
                value = "QTL_results", br(),
                includeMarkdown(system.file("help_files/QTL_res.Rmd", package = "viewpoly"))
              ),
              tabPanel("How to cite",
                value = "QTL_cite", br(),
                includeMarkdown(system.file("help_files/QTL_cite.Rmd", package = "viewpoly"))
              )
            )
          ),
          box(
            title = "ViewGenome", id = "Genome_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab allows users to upload and manage input data for analysis.",
            br(), br(),
            tabsetPanel(
              id = "Genome_tabset",
              tabPanel("Parameters description",
                value = "Genome_par", br(),
                includeMarkdown(system.file("help_files/Genome_par.Rmd", package = "viewpoly"))
              ),
              tabPanel("Results description",
                value = "Genome_results", br(),
                includeMarkdown(system.file("help_files/Genome_res.Rmd", package = "viewpoly"))
              ),
              tabPanel("How to cite",
                value = "Genome_cite", br(),
                includeMarkdown(system.file("help_files/Genome_cite.Rmd", package = "viewpoly"))
              )
            )
          ),
          box(
            title = "ViewMap", id = "Map_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab allows users to upload and manage input data for analysis.",
            br(), br(),
            tabsetPanel(
              id = "Map_tabset",
              tabPanel("Parameters description",
                value = "Map_par", br(),
                includeMarkdown(system.file("help_files/Map_par.Rmd", package = "viewpoly"))
              ),
              tabPanel("Results description",
                value = "Map_results", br(),
                includeMarkdown(system.file("help_files/Map_res.Rmd", package = "viewpoly"))
              ),
              tabPanel("How to cite",
                value = "Map_cite", br(),
                includeMarkdown(system.file("help_files/Map_cite.Rmd", package = "viewpoly"))
              )
            )
          ),
          box(
            title = "HIDECAN", id = "Hidecan_box", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
            "This tab allows users to upload and manage input data for analysis.",
            br(), br(),
            tabsetPanel(
              id = "Hidecan_tabset",
              tabPanel("Parameters description",
                value = "Hidecan_par", br(),
                includeMarkdown(system.file("help_files/Hidecan_par.Rmd", package = "viewpoly"))
              ),
              tabPanel("Results description",
                value = "Hidecan_results", br(),
                includeMarkdown(system.file("help_files/Hidecan_res.Rmd", package = "viewpoly"))
              ),
              tabPanel("How to cite",
                value = "Hidecan_cite", br(),
                includeMarkdown(system.file("help_files/Hidecan_cite.Rmd", package = "viewpoly"))
              )
            )
          )
        )
      ),
      column(width = 2)
      # Add Help content here
    )
  )
}

#' help Server Functions
#'
#' @noRd
mod_help_server <- function(input, output, session, parent_session) {
  ns <- session$ns

  if (isTRUE(requireNamespace("AlloMate", quietly = TRUE))) {
    output$help_accordion_allomate <- shiny::renderUI({
      shiny::tagList(
        box(
          title = "AlloMate", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          getFromNamespace("help_content_allomate", "AlloMate")()
        )
      )
    })
  }

  if (isTRUE(requireNamespace("Familia", quietly = TRUE))) {
    output$help_accordion <- shiny::renderUI({
      shiny::tagList(
        box(
          title = "Pedigree Cleaner", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          getFromNamespace("help_content_ped_cleaner", "Familia")()
        ),
        box(
          title = "Find Parentage", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          getFromNamespace("help_content_find_parentage", "Familia")()
        ),
        box(
          title = "Validate Pedigree", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          getFromNamespace("help_content_validate_ped", "Familia")()
        ),
        box(
          title = HTML("BreedTools<sup>poly</sup>"), width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          getFromNamespace("help_content_polybreedtools", "Familia")()
        ),
        box(
          title = "SNMF", width = 12, collapsible = TRUE, collapsed = TRUE, status = "info", solidHeader = TRUE,
          getFromNamespace("help_content_SNMF", "Familia")()
        )
      )
    })
  }
}

## To be copied in the UI
# mod_help_ui("help_1")

## To be copied in the server
# mod_help_server("help_1")
