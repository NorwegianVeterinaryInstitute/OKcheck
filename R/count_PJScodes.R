#' @title Count used PJS-codes
#' @description Count used PJS-codes and marks whether they are accepted or not.
#'
#' @details The purpose is to give an overview of the PJS-codes used. PJS-codes
#'    that are included in the control routines as accepted codes are marked. To
#'    facilitate checking if additional codes should be added to the list of 
#'    selected or deleted codes, the description text is added to the used codes.
#'    This is under the condition that the PJSdata have standardised column names. 
#'
#'    The \code{translation_table} for PJS-codes needs to be imported to add the 
#'    description text. The function \code{NVIdb::read_PJS_code_2_text} should 
#'    be used, see example.
#'
#' @param PJSdata \[\code{data.frame}\]\cr
#'     Data from PJS.
#' @param variable \[\code{character(1)}\]\cr
#'     The variable in the data that should be checked.
#' @param accepted \[\code{character}\]\cr
#'     Vector with accepted code values. Defaults to \code{NULL}.
#' @param translation_table \[\code{data.frame}\]\cr
#'     The translation table for PJS-codes, see details.
#'
#' @importFrom magrittr %>%
#'
#' @return A data frame with the used codes, their description and the number of
#'     rows where the codes have been used.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @export
#' @examples
#' \dontrun{
#' # Reads translation table for PJS-codes
#' PJS_codes_2_text <- NVIdb::read_PJS_codes_2_text()
#'
#' ktr <- count_PJScodes(PJSdata = PJSdata,
#'                       variable = "metodekode",
#'                       accepted = c("010001", "010002"),
#'                       translation_table = PJS_codes_2_text)
#' }
#'
count_PJScodes <- function(PJSdata,
                           variable,
                           accepted = NULL,
                           translation_table = PJS_codes_2_text) {
  
  # # Translation table between standard PJS column name and PJS-type as used in PJS_codes_2_text
  # PJS_codetype <- c("ansvarlig_seksjon" = "seksjon",
  #                   "artkode" = "art", "driftsformkode" = "driftsform",
  #                   "provetypekode" = "provetype", "provematerialekode" = "provemateriale",
  #                   "metodekode" = "metode",
  #                   "konkl_kjennelsekode" = "kjennelse", "konkl_analyttkode" = "analytt",
  #                   "res_kjennelsekode" = "kjennelse", "res_analyttkode" = "analytt",
  #                   "konkl_type" = "konkl_type", "eier_lokalitetstype" = "registertype")
  # 
  # # PJStype <- PJS_codetype[variable]
  
  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  checkmate::assert_data_frame(PJSdata, add = checks)
  checkmate::assert_choice(variable, choices = colnames(PJSdata), add = checks)
  checkmate::assert_character(accepted, null.ok = TRUE, add = checks)
  checkmate::assert_data_frame(translation_table, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)
  
  
  used_codes <- as.data.frame(PJSdata[, variable]) %>%
    dplyr::count(PJSdata[, variable]) 
  colnames(used_codes) <- c("used_code", "n_obs") 
  used_codes$used_code = as.character(used_codes$used_code)
  used_codes$var <- variable # %>%
  used_codes <- used_codes[, c("var", "used_code", "n_obs")]
  
  if (!is.null(accepted)) {
    used_codes$accepted <- 0
    used_codes[which(used_codes$used_code %in% accepted), "accepted"] <- 1
  }
  
  if (!is.null(translation_table) & variable %in% NVIdb::PJS_code_description_colname$code_colname) {
    # if (!is.null(translation_table) & variable %in% names(PJS_codetype)) {
    used_codes <- NVIdb::add_PJS_code_description(data = used_codes,
                                                  translation_table = translation_table,
                                                  PJS_variable_type = "auto",
                                                  code_colname = variable,
                                                  new_column = "auto")
  }
  return(as.data.frame(used_codes))
}
