#' @title Finds accepted PJS-codes
#' @description Finds accepted PJS-codes for a certain purpose / program.
#'
#' @details The accepted PJS-codes for a certain purpose is stored in an a table. The
#'     function reads the table and finds the PJS-codes that are accepted for the
#'     purpose. Thereafter the list of accepted codes can be used in control routines.
#'
#' @param data Data frame with accepted PJS-codes.
#' @param purpose The purpose for which accepted PJS-codes should be found.
#' @param codetype The type of PJS-code.
#'
#' @return A vector with accepted code combinations.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export

find_accepted_code <- function(data, purpose, codetype) {
  data = subset(data, data$program == purpose)

  accepted_codes <- c(data[which(data$var1 == codetype[1]), "verdi1"])

  return(unique(accepted_codes))
}
