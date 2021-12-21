#' @title Write table with data that should be checked
#' @description Write a table with data that should be checked by those responsible
#'     for entering the data.
#' @details The data checks PJS-data for potential mistakes. If data with potential
#'     mistakes are identified, these are reporter in a table. If no mistakes are
#'     found, no report is created.
#'
#'     The heading should explain why the data needs to be checked so that the
#'     laboratory should know what to change in the source data, i.e. PJS.
#'
#' @param data data.frame with data that should be checked by the laboratory.
#' @param heading Table title and text.
#'
#' @importFrom magrittr %>%
#'
#' @return If no lines to check an empty document. Else, a table with potential
#'      mistakes in PJS. \code{standardize_columns} is used to standardize column
#'      names and the heading is the table caption.
#' @export


write_data_for_checking <- function(data, heading) {
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

    output <- knitr::kable(data, caption = heading) %>% 
      kableExtra::kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))
  }
  # RETURN HTML-TABLE WITH DATA FOR CHECKING ----
  return(output)
}
