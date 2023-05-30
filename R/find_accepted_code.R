#' @title Finds accepted PJS-codes
#' @description Finds accepted PJS-codes for a certain purpose / program.
#'
#' @details The accepted PJS-codes for a certain purpose is stored in an a table. The
#'     function reads the table and finds the PJS-codes that are accepted for the
#'     purpose. Thereafter the list of accepted codes can be used in control routines.
#'
#' @param data [\code{data.frame}]\cr
#'     Data with accepted PJS-codes.
#' @param purpose [\code{character(1)}]\cr
#'     The purpose for which accepted PJS-codes should be found.
#' @param code_variable [\code{character}]\cr
#'     Vector with the combinations of PJS-code types that should be checked.
#'
#' @return A vector with accepted code combinations.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @noMd
#' @export

find_accepted_code <- function(data, purpose, code_variable) {
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  checkmate::assert_data_frame(data, add = checks)
  checkmate::assert_string(purpose, min.chars = 1, all, add = checks)
  checkmate::assert_character(code_variable, max.len = 4, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  data = subset(data, data$program == purpose)

  data[which(is.na(data$var2)), c("var2", "verdi2")] <- c("", "")
  data[which(is.na(data$var3)), c("var3", "verdi3")] <- c("", "")

  code_variable <- c(code_variable, rep("", 3 - length(code_variable)))

  data <- subset(data, data$var1 == code_variable[1] & data$var2 == code_variable[2] & data$var3 == code_variable[3])

  data <- within(data, accepted <- paste(data$hensikt, data$verdi1, data$verdi2, data$verdi3, sep = "-"))
  data$accepted <- trimws(data$accepted, which = "right", whitespace = "[-]")

  return(unique(data$accepted))
}
