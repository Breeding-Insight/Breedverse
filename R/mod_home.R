#' Home UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom bs4Dash renderValueBox valueBox
#' @importFrom utils capture.output sessionInfo read.csv read.table
#' @importFrom grDevices jpeg png tiff svg dev.off
#' @importFrom stats dbinom
#'
#'
mod_Home_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(width = 4,
               box(
                 title = "Breedverse", status = "info", solidHeader = FALSE, width = 12, collapsible = FALSE,
                 HTML(
                   paste0(
                     "<p><b>About Breedverse.</b> Breedverse is a user-friendly, easy-to-install interface ",
                     "that brings together a curated catalog of applications developed by ",
                     "<b>Breeding Insight</b> to support a wide range of breeding and data analysis tasks.</p>",
                     "<p>Getting started is simple:</p>",
                     "<ul>",
                     "  <li>Navigate to the <b>Install</b> tab to browse the available features.</li>",
                     "  <li>Select the tools that match your needs &mdash; features are organized by the individual apps modules and activated based on user demand.</li>",
                     "  <li>Once installed, all enabled features will appear in the <b>left navigation menu</b>, ready to use.</li>",
                     "</ul>",
                     "<p>Whether you are working with genomic data, phenotypic records, or population analyses, ",
                     "Breedverse provides a seamless environment to access the right tools without complex setup.</p>",
                     "<p>For detailed information on <b>input files</b>, <b>parameters</b>, and <b>outputs</b> for each tool, ",
                     "refer to the <b>Help</b> pages available at the bottom of the left navigation menu.</p>"
                   )
                 ),
                 style = "overflow-y: auto; height: 500px"
               )
        ),
        column(width = 4,
               box(
                 title = "About Breeding Insight", status = "success", solidHeader = FALSE, width = 12, collapsible = FALSE,
                 HTML(
                   "We provide scientific consultation and data management software to the specialty crop and animal breeding communities.
            <ul>
              <li>Genomics</li>
              <li>Phenomics</li>
              <li>Data Management</li>
              <li>Software Tools</li>
              <li>Analysis</li>
            </ul>
            Breeding Insight is funded by the U.S. Department of Agriculture (USDA) Agricultural Research Service (ARS) through Cornell University.
            <div style='text-align: center; margin-top: 20px;'>
              <img src='www/BreedingInsight.png' alt='Breeding Insight' style='width: 85px; height: 85px;'>
            </div>"
                 ),
                 style = "overflow-y: auto; height: 500px"
               )
        ),
        column(width = 4,
               a(
                 href = "https://www.breedinginsight.org",  # Replace with your desired URL
                 target = "_blank",  # Optional: opens the link in a new tab
                 valueBox(
                   value = NULL,
                   subtitle = "Learn More About Breeding Insight",
                   icon = icon("link"),
                   color = "purple",
                   gradient = TRUE,
                   width = 11
                 ),
                 style = "text-decoration: none; color: inherit;"  # Optional: removes underline and retains original color
               ),
               a(
                 href = "https://breedinginsight.org/contact-us/",  # Replace with your desired URL
                 target = "_blank",  # Optional: opens the link in a new tab
                 valueBox(
                   value = NULL,
                   subtitle = "Contact Us",
                   icon = icon("envelope"),
                   color = "danger",
                   gradient = TRUE,
                   width = 11
                 ),
                 style = "text-decoration: none; color: inherit;"  # Optional: removes underline and retains original color
               ),
               a(
                 href = "file:///Users/cht47/Documents/github/Breedverse/doc/Breedverse.html",  # Replace with your desired URL
                 target = "_blank",  # Optional: opens the link in a new tab
                 valueBox(
                   value = NULL,
                   subtitle = "Breedverse Tutorial",
                   icon = icon("compass"),
                   color = "info",
                   gradient = TRUE,
                   width = 11
                 ),
                 style = "text-decoration: none; color: inherit;"  # Optional: removes underline and retains original color
               )
        )
      ),
      fluidRow(
        column(width = 8,
               uiOutput(ns("news_box"))
        )
      )
    )
  )
}

#' Home Server Functions
#'
#'
#' @noRd
mod_Home_server <- function(input, output, session, parent_session){

  ns <- session$ns

  output$news_box <- renderUI({
    # Locate NEWS.md via golem helper, then dev working directory fallbacks
    news_file <- app_sys("NEWS.md")
    if (!nzchar(news_file) || !file.exists(news_file)) {
      candidates <- c(
        file.path(getwd(), "NEWS.md"),
        file.path(getwd(), "..", "NEWS.md"),
        file.path(getwd(), "..", "..", "NEWS.md")
      )
      news_file <- Filter(file.exists, candidates)[1]
      if (is.null(news_file) || is.na(news_file)) return(NULL)
    }

    lines <- readLines(news_file, warn = FALSE)
    version_starts <- grep("^## ", lines)
    if (length(version_starts) == 0) return(NULL)

    # Parse up to the two most recent versions
    n_versions <- min(2, length(version_starts))

    parse_section <- function(content) {
      html_parts <- character(0)
      in_list    <- FALSE
      for (line in content) {
        if (grepl("^### ", line)) {
          if (in_list) { html_parts <- c(html_parts, "</ul>"); in_list <- FALSE }
          heading    <- sub("^### ", "", line)
          html_parts <- c(html_parts, paste0("<h5><b>", heading, "</b></h5>"))
        } else if (grepl("^\\* ", line)) {
          if (!in_list) { html_parts <- c(html_parts, "<ul>"); in_list <- TRUE }
          item       <- sub("^\\* ", "", line)
          item       <- gsub("\\*\\*(.+?)\\*\\*", "<b>\\1</b>", item)
          html_parts <- c(html_parts, paste0("<li>", item, "</li>"))
        } else if (nzchar(trimws(line))) {
          if (in_list) { html_parts <- c(html_parts, "</ul>"); in_list <- FALSE }
          text       <- gsub("\\*\\*(.+?)\\*\\*", "<b>\\1</b>", line)
          html_parts <- c(html_parts, paste0("<p>", text, "</p>"))
        }
      }
      if (in_list) html_parts <- c(html_parts, "</ul>")
      html_parts
    }

    all_html <- character(0)
    for (i in seq_len(n_versions)) {
      v_start <- version_starts[i]
      v_title <- sub("^## ", "", lines[v_start])
      v_end   <- if (i < length(version_starts)) version_starts[i + 1] - 1 else length(lines)
      content <- lines[(v_start + 1):v_end]

      section_html <- parse_section(content)

      if (i > 1) all_html <- c(all_html, "<hr/>")
      all_html <- c(all_html,
                    paste0("<h4><b>", v_title, "</b></h4>"),
                    section_html)
    }

    box(
      title       = "What's New",
      status      = "info",
      solidHeader = FALSE,
      width       = 12,
      collapsible = TRUE,
      HTML(paste(all_html, collapse = "\n"))
    )
  })

}

# Suppress global variable and function notes for CRAN checks
utils::globalVariables(c(
  ".__hl__", "Xb", "Yb"
))

## To be copied in the UI
# mod_Home_ui("Home_1")

## To be copied in the server
# mod_Home_server("Home_1")
