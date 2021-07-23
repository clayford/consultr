#' Run consultr shiny app
#'
#' \code{runShinyApp} runs the specified shiny app.
#'
#' This function is basically a copy of the function in Dean Attali's blog post,
#' \emph{Supplementing your R package with a Shiny app}:
#' \url{https://deanattali.com/2015/04/21/r-package-shiny-app/}.
#' @param app The name of the shiny app to run as a character string. For
#'   example, \code{app = 'ci'}. Submitting the function while leaving this argument blank
#'   returns a list of available shiny apps, albeit as an error message.
#'
#' @return Opens the requested shiny app in RStudio or a web browser, depending
#'   on your setup.
#'
#' @section Available shiny apps:
#' \describe{
#'   \item{ci}{illustrates confidence intervals}
#'   \item{correlation}{visualizes correlation via scatterplot}
#'   \item{interactions}{visualizes the effect of continuous interactions}
#'   \item{lme}{simulates and fits linear-mixed effect models and demonstrates random and fixed effects}
#'   \item{nhst}{visualizes power, sample size, and Type I and II errors in the context of a one-sample proportion test}
#'   \item{passa}{runs power and sample size analyses for one- and two-sample proportion and t-tests as well as one-way ANOVAs}
#' }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' runShinyApp()  # see all available shiny apps
#' runShinyApp('ci')
#' runShinyApp('lme')
#' }
#'
runShinyApp <- function(app) {
  # locate all the shiny app examples that exist
  validExamples <- list.files(system.file("shiny-apps", package = "consultr"))

  validExamplesMsg <-
    paste0(
      "Available app names: '",
      paste(validExamples, collapse = "', '"),
      "'")

  # if an invalid example is given, throw an error
  if (missing(app) || !nzchar(app) ||
      !app %in% validExamples) {
    stop(
      'Please use `runShinyApp()` with a valid app names as an argument. For example: runShinyApp(\'ci\')\n',
      validExamplesMsg,
      call. = FALSE)
  }

  # find and launch the app

  appDir <- system.file("shiny-apps", app, package = "consultr")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `consultr`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
