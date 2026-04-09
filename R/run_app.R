#' Run the Shiny Application
#'
#' @param onStart A function that will be called before the app is actually run.
#' @param options Named options that should be passed to the `shiny::runApp` call.
#' @param enableBookmarking Can be one of `"url"`, `"server"`, or `"disable"`.
#' @param uiPattern A regular expression that will be applied to each `GET` request.
#' @param ... arguments to pass to golem_opts.
#' See `?golem::get_golem_options` for more details.
#'
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#'
#' @export 
#' 
run_app <- function(
    onStart = NULL,
    options = list(),
    enableBookmarking = NULL,
    uiPattern = "/",
    ...
) {

  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = onStart,
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(...)
  )
}
