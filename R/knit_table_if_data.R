#' @title Knit table if data to report
#' @description Knits a table for presenting within an rmarkdown document.
#' @details Knits a table if the table is non-empty. Else, no datas is shown.
#'     \ifelse{html}{\code{\link[knitr:kable]{knitr::kable}}}{\code{knitr::kable}}
#'     is used to knit the table.
#'
#' The column names are standardized using
#'     \ifelse{html}{\code{\link[NVIdb:standardize_columns]{NVIdb::standardize_columns}}}{\code{NVIdb::standardize_columns}}.
#'     The output also includes a table heading.
#'
#' This is primary used in rmarkdown reports for checking PJS-data for
#'     potential mistakes. If data with potential mistakes are identified, these
#'     are reported in a table. If no mistakes are found, no report is created.
#'
#' The heading should explain why the data needs to be checked so that the
#'     laboratory should know what to change in the source data, i.e. PJS.
#'
#' @param data [\code{data.frame}]\cr
#'     Data to be formatted. Can be empty.
#' @param heading [\code{character(1)}]\cr
#'     Table title and caption.
#'
#' @return A knitted table formatted by kable for output from rmarkdown. If no
#'      data in the data source, an empty document.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @noMd

#' @export


knit_table_if_data <- function(data, heading) {
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()

  # Perform checks
  # data
  checkmate::assert_data_frame(data, add = checks)

  # heading
  checkmate::assert_string(heading, add = checks)

  # Report check-results
  checkmate::reportAssertions(checks)

  # WRITE NOTHING WHEN NO ROWS TO CHECK ----
  # Remove heading if no data to report
  if (dim(data)[1] == 0) {
    heading <- ""
  }

  # Makes output with only heading, resets output below if data for checking
  output <- knitr::asis_output(heading) # placed here as kitr::asis_output cannot be within a for-loop or an if-clause

  # WRITE DATA WHEN ROWS TO CHECK ----
  # Output data if any cases need to be checked
  if (dim(data)[1] > 0) {
    colnames(data) <- NVIdb::standardize_columns(data = data, property = "collabels")

    output <- knitr::kable(data, caption = heading) |>
      kableExtra::kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
  }
  # RETURN HTML-TABLE WITH DATA FOR CHECKING ----
  return(output)
}
