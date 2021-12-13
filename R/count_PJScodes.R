#' @title Count used PJS-codes
#' @description Count used PJS-codes and marks whether they are accepted or not.
#'
#' @details The purpose is to give an overview of the PJS-codes used. PJS-codes
#'    that are included in the control routines as accepted codes are marked. The
#'    description text is added to all used codes to facilitate checking if the
#'    codes shoud be accepted or not.
#'
#'    The \code{translation_table} for PJS-codes neeeds to be imported. The function
#'    \code{NVIdb::read_PJS_code_2_text} should be used, see example.
#'
#' @param PJSdata Data frame with data from PJS.
#' @param variable The variabel in the data frame that should be checked.
#' @param accepted Vector with accepted code values. Can be code\{NULL}.
#' @param translation_table The translation table for PJS-codes, see details.
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

  # Translation table between standard PJS column name and PJS-type as used in PJS_codes_2_text
  PJS_codetype <- c("ansvarlig_seksjon" = "seksjon",
                    "artkode" = "art", "driftsformkode" = "driftsform",
                    "provetypekode" = "provetype", "provematerialekode" = "provemateriale",
                    "metodekode" = "metode",
                    "konkl_kjennelsekode" = "kjennelse", "konkl_analyttkode" = "analytt",
                    "res_kjennelsekode" = "kjennelse", "res_analyttkode" = "analytt",
                    "konkl_type" = "konkl_type", "eier_lokalitetstype" = "registertype")

  # PJStype <- PJS_codetype[variable]

  used_codes <- as.data.frame(PJSdata[, variable]) %>%
    dplyr::count(PJSdata[, variable]) %>%
    dplyr::rename(used_code = 1, n_obs = 2) %>%
    dplyr::mutate(used_code = as.character(used_code)) %>%
    dplyr::mutate(var = variable) %>%
    dplyr::select(var, used_code, n_obs)

  if (!is.null(accepted)) {
    used_codes$accepted <- 0
    used_codes[which(used_codes$used_code %in% accepted), "accepted"] <- 1
  }

  if (!is.null(translation_table) & variable %in% names(PJS_codetype)) {
    used_codes <- NVIdb::add_PJS_code_description(data = used_codes,
                                                  translation_table = translation_table,
                                                  PJS_variable_type = PJS_codetype[variable],
                                                  code_colname = "used_code",
                                                  new_column = PJS_codetype[variable])
  }
  return(as.data.frame(used_codes))
}
