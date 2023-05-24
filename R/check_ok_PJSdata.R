#' @title Checks the standard output data frame with the OK selection
#' @description Standard checks of PJSdata by checking for illegal or rare
#'     combinations of values in variables in PJSdata.
#'     \code{check_ok_PJSdata} is a wrapper for \code{NVIbatch::output_rendered}.
#'
#' @details Gives tables listing journals with mistakes, or probable mistakes.
#'     These should be further checked and eventually reported to the laboratory
#'     in charge of correcting the information in the journal.
#'
#' The check must be performed on a data frame with standardised
#'     column names. This is ensured by using \code{data(OKplan::OK_column_standards)}
#'     to standardise the column names.
#'
#' The default behaviour is to display the resulting html-file in the
#'     browser. To save the result in a permanent file, use a permanent
#'     directory as input to \code{output_dir = }. The resulting file
#'     can also be sent by email by using additional arguments, see
#'     \code{NVIbatch::output_rendered}.
#'
#' If a check don't find any mistakes that should be reported, there is not
#'     produced any table for that check.
#'
#' @param input \[\code{character(1)}\]\cr
#' The path to the rmarkdown document with the checks.Defaults to 
#'     "check_ok_PJSdata.Rmd" in the \code{OKplan}.
#' @param output_file \[\code{character(1)}\]\cr
#' The name of the output file.
#' @param output_dir \[\code{character(1)}\]\cr
#' The directory to save the output file. Defaults to \code{NULL}.
#' @param data \[\code{data.frame}\]\cr
#' The table with data describing the selection for a OK programme.
#' @param purpose \[\code{character(1)}\]\cr
#' String with descriptive text to be used in file name and heading of the report.
#' @param aar \[\code{numeric(1)}\]\cr
#' The year for which the selection is planned. Defaults to previous year.
#' @param accept \[\code{character(1)}\]\cr
#' How strict should the check of code combinations be. Defaults to 
#'     "accept_always", i.e. the most strict check.
#' @param display \[\code{logical(1)} | \code{character(1)}\]\cr
#' Set "browser" for the default browser or "viewer" for the R studio
#'      viewer. `TRUE` equals "browser". If `FALSE`, don't display
#'      the results file. Defaults to "browser".
#' @param \dots Other arguments to be passed to `NVIbatch::output_rendered`.
#'
#' @return Generates an html-file with the results of the checks to be displayed in the browser.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Checking OK selection data
#'
#' purpose = "ok_virus_svin"
#' aar = 2023
#' accept = "accept_always"
#'
#' # Check
#' check_ok_PJSdata(data = PJSdata,
#'                  purpose = purpose,
#'                  aar = aar,
#'                  accept = accept)
#' }
#'
check_ok_PJSdata <- function(input = system.file('templates', "check_ok_PJSdata.Rmd", package = "OKcheck"),
                               output_file = paste0("Kontroll av PJS-data for ",
                                                    purpose,
                                                    " ",
                                                    format(Sys.Date(), "%Y%m%d"),
                                                    ".html"),
                               output_dir = NULL,
                               data = NULL,
                               purpose = NULL,
                               aar = as.numeric(format(Sys.Date(), "%Y")) - 1,
                               accept = "accept_always",
                               display = "browser",
                               ...) {

  # PREPARE ARGUMENTS BEFORE CHECKING ----
  if (is.null(output_dir)) {output_dir = tempdir()}
  if (isTRUE(display)) {display = "browser"}

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  checkmate::assert_file(input, access = "r", add = checks)
  checkmate::assert_string(output_file, min.chars = 6, pattern = "\\.html$", ignore.case = TRUE, add = checks)
  checkmate::assert_directory(output_dir, access = "r", add = checks)
  checkmate::assert_data_frame(data, min.rows = 1, add = checks)
  checkmate::assert_string(purpose, min.chars = 1, add = checks)
  checkmate::assert_integerish(aar,
                               lower = 1995, upper = (as.numeric(format(Sys.Date(), "%Y"))),
                               any.missing = FALSE, all.missing = FALSE,
                               len = 1,
                               add = checks)
  checkmate::assert(checkmate::check_false(display),
                    checkmate::check_choice(display, choices = c("browser", "viewer")),
                    add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)


  # RUN output_rendered ----
  NVIbatch::output_rendered(input = input,
                            output_file = output_file,
                            output_dir = output_dir,
                            intermediates_dir = tempdir(),
                            params = list("data" = data, "purpose" = purpose, "aar" = aar, "accept" = accept),
                            display = display,
                            ...)

}
