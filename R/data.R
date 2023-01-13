#' @title Data: heading_for_check_tables.
#'
#' @description A data frame with heading information for tables in check routines.
#'    The table keeps heading and subheading for the specific tables checking
#'    code combinations.
#'
#' @details The table also include information on whether code combinations
#'    should be checked for all or for closed journals only.
#'
#' @format A data frame with 7 variables:
#' \describe{
#'   \item{purpose}{A short text identifying the surveillance programme. Give
#'         the value "General" if it applies to all programmes.}
#'   \item{variable_combination}{The variable combination which the heading
#'         relates to.}
#'   \item{order}{The order of the table.}
#'   \item{tablenr}{Table number. Usually a letter and a number.}
#'   \item{title}{Heading for the table.}
#'   \item{subtitle}{Sub-heading for the table. Includes usually instruction on
#'         how to handle any mistakes.}
#'   \item{closed_journal}{If 1, check closed journals only.}
#' }
#' @source \code{heading_for_check_tables.xlsx}
"heading_for_check_tables"
