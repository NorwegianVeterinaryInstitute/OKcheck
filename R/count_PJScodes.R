#' @title Count used PJS-codes
#' @description Count used PJS-codes and marks whether they are accepted or not.
#'
#' @details The purpose is to give an overview of the PJS-codes used. For codes
#'    at sak-level, the number of saker for which the codes have been used is
#'    given. For codes at metode-level, the number of undersokelser for which
#'    the codes have been used is given, etc. The identifying of the PJS-level
#'    is dependent on column being standardised, see
#'    \ifelse{html}{\code{\link[NVIdb:standardize_PJSdata]{NVIdb::standardize_PJSdata}}}{\code{NVIdb::standardize_PJSdata}}.
#'
#' PJS-codes that are included in the control routines as accepted codes are marked.
#'    To facilitate checking if additional codes should be added to the list of
#'    selected or deleted codes, the description text is added to the used codes.
#'    This is under the condition that the PJSdata have standardised column names.
#'
#' The \code{translation_table} for PJS-codes needs to be imported to add the
#'    description text. You may use
#'     \ifelse{html}{\code{\link[NVIdb:add_PJS_code_description]{NVIdb::read_PJS_code_2_text}}}{\code{NVIdb::read_PJS_code_2_text}}
#'    for this, see example.
#'
#' The argument \code{accepted} accepts code values ending with "%" to include sub_levels.
#'
#' @param PJSdata [\code{data.frame}]\cr
#'     Data from PJS.
#' @param variable [\code{character(1)}]\cr
#'     The variable in the data that should be checked.
#' @param accepted [\code{character}]\cr
#'     Vector with accepted code values. Defaults to \code{NULL}.
#' @param excluded [\code{character}]\cr
#'     Vector with code values that should be excluded. Defaults to \code{NULL}.
#' @param translation_table [\code{data.frame}]\cr
#'     The translation table for PJS-codes, see details.
#'
#' @importFrom magrittr %>%
#'
#' @return A data frame with the used codes, their description and the number of
#'     rows where the codes have been used.
#'
#' @author Petter Hopp Petter.Hopp@@vetinst.no
#' @noMd
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
                           excluded = NULL,
                           translation_table = PJS_codes_2_text) {

  # ARGUMENT CHECKING ----
  # Object to store check-results
  checks <- checkmate::makeAssertCollection()
  # Perform checks
  checkmate::assert_data_frame(PJSdata, add = checks)
  checkmate::assert_choice(variable, choices = colnames(PJSdata), add = checks)
  checkmate::assert_character(accepted, null.ok = TRUE, add = checks)
  checkmate::assert_character(excluded, null.ok = TRUE, add = checks)
  checkmate::assert_data_frame(translation_table, null.ok = TRUE, add = checks)
  # Report check-results
  checkmate::reportAssertions(checks)

  # COUNT USED CODES ----
  # Identifies all variables in the index taking into consideration the PJS-level of the variable
  # index <- c("aar", "ansvarlig_seksjon", "innsendelsenr", "saksnr")
  # for (k in 1:length(variable)) {
  # index <- union(index,
  #                NVIdb::PJS_levels[which(NVIdb::PJS_levels[1:10, which(NVIdb::PJS_levels[which(NVIdb::PJS_levels$variable == variable), ] == 1)[1]] == 1), "variable"])
  index <- NVIpjsr::PJS_levels[which(NVIpjsr::PJS_levels[1:10, which(NVIpjsr::PJS_levels[which(NVIpjsr::PJS_levels$variable == variable), ] == 1)[1]] == 1), "variable"]
  # }
  # Keeps only variables that exist in PJSdata. Necessary as resnr will not be in PJSdata.
  index <- base::intersect(index, colnames(PJSdata))
  # Generate data frame for check that only contains the relevant variables
  used_codes <- as.data.frame(PJSdata[, unique(c(index, variable))])
  if (!identical(index, character(0))) {
    used_codes <- unique(used_codes)
  } else {
    colnames(used_codes) <- variable
  }

  # Counts number of rows
  # used_codes <- as.data.frame(used_codes[, variable]) %>%
  #   dplyr::count(used_codes[, variable])
  if (nrow(used_codes > 0)) {
  used_codes <- stats::aggregate(x = used_codes[, variable], by = list(used_codes[, variable]), FUN = length)
  } else {
    used_codes <- used_codes[, c(variable, variable)]
  }
  colnames(used_codes) <- c(variable, "n_obs")
  used_codes[, variable] <- as.character(used_codes[, variable])

  # MARK ACCEPTED CODES ----
  # Check which codes that are included in the selection parameters.
  # Marks the codes with accepted = 1 if the code are included in the selection parameters
  if (!is.null(accepted)) {
    # transform value_2_check to regular expressions
    accepted <- paste0("^", accepted)
    acceptedx <- gsub(pattern = "%", replacement = "[[:digit:]]*", x = accepted, fixed = TRUE)

    colnames(used_codes)[colnames(used_codes) == variable] <- "used_code"
    used_codes <- used_codes %>%
      dplyr::rowwise() %>%
      dplyr::mutate(accepted = max(unlist(lapply(acceptedx, grep, x = used_code)), 0))

    used_codes$accepted <- +(as.logical(used_codes$accepted))
    colnames(used_codes)[colnames(used_codes) == "used_code"] <- variable
  }

  # MARK EXCLUDED CODES ----
  # Check which codes that should be excluded from the selection parameters.
  # Marks the codes with accepted = 9 if the code are excluded from the selection parameters
  if (!is.null(excluded)) {
    # transform value_2_check to regular expressions
    excluded <- paste0("^", excluded)
    excludedx <- gsub(pattern = "%", replacement = "[[:digit:]]*", x = excluded, fixed = TRUE)

    colnames(used_codes)[colnames(used_codes) == variable] <- "used_code"
    used_codes <- used_codes %>%
      dplyr::rowwise() %>%
      dplyr::mutate(excluded = max(unlist(lapply(excludedx, grep, x = used_code)), 0))

    used_codes$excluded <- +(as.logical(used_codes$excluded))
    colnames(used_codes)[colnames(used_codes) == "used_code"] <- variable
  }

  if (!is.null(excluded)) {
    if (is.null(accepted)) {used_codes$accepted <- 0}
    used_codes[which(used_codes$excluded == 1), "accepted"] <- 9
    used_codes$excluded <- NULL
  }

  # INCLUDE DESCRIPTIVE TEXT ----
  # Includes description text for the codes, if the translation table is available
  if (!is.null(translation_table) & variable %in% NVIpjsr::PJS_code_description_colname$code_colname) {
    # if (!is.null(translation_table) & variable %in% names(PJS_codetype)) {
    used_codes <- NVIpjsr::add_PJS_code_description(data = used_codes,
                                                    translation_table = translation_table,
                                                    PJS_variable_type = "auto",
                                                    code_colname = variable,
                                                    new_column = "auto")
  }

  return(as.data.frame(used_codes))
}

# To avoid checking of the variable PJS_codes_2_text as default input argument in the function
utils::globalVariables(names = c("PJS_codes_2_text"))
