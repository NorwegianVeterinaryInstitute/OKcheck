library(OKcheck)
library(NVIdb)
library(NVIpjsr)
library(testthat)
library(checkmate)


test_that("check counting in count_PJScodes for metodekode", {
  # Generate test data
  PJSdata <- as.data.frame(c("010001", "010002", "060154", "010001", "010002", "070013"))
  colnames(PJSdata) <- "metodekode"

  ktr <- count_PJScodes(PJSdata = PJSdata,
                        variable = "metodekode",
                        accepted = NULL,
                        translation_table = NULL)

  checkmate::expect_data_frame(ktr, nrows = 4, ncols = 2)

  checkmate::expect_subset(colnames(ktr), c("metodekode", "n_obs"))

  expect_identical(ktr$n_obs, c(2L, 2L, 1L, 1L))


  # skip if no connection to 'FAG' have been established
  skip_if_not(dir.exists(set_dir_NVI("FAG")))

  PJS_codes_2_text <- NVIpjsr::read_PJS_codes_2_text()

  ktr <- count_PJScodes(PJSdata = PJSdata,
                        variable = "metodekode",
                        accepted = c("010001", "010002"),
                        translation_table = PJS_codes_2_text)

  checkmate::expect_data_frame(ktr, nrows = 4, ncols = 4)

  checkmate::expect_subset(colnames(ktr), c("metodekode", "metode", "n_obs", "accepted"))

  expect_identical(ktr$accepted, c(1L, 1L, 0L, 0L))
})


test_that("check counting in count_PJScodes for hensiktkode", {

  # skip if no connection to 'FAG' have been established
  skip_if_not(dir.exists(set_dir_NVI("FAG")))

  PJS_codes_2_text <- NVIpjsr::read_PJS_codes_2_text()

  # Generate test data
  PJSdata <- as.data.frame(c("0100101015", "0100101015", "01001", "0200105", "0200126", "0400109"))
  colnames(PJSdata) <- "hensiktkode"

  ktr <- count_PJScodes(PJSdata = PJSdata,
                        variable = "hensiktkode",
                        accepted = c("01001%", "0100201005", "04%"),
                        translation_table = NULL)

  checkmate::expect_data_frame(ktr, nrows = 5, ncols = 3)

  checkmate::expect_subset(colnames(ktr), c("hensiktkode", "n_obs", "accepted"))

  expect_identical(ktr$n_obs, c(1L, 2L, 1L, 1L, 1L))

  expect_identical(ktr$accepted, c(1L, 1L, 0L, 0L, 1L))
  })

# cHECKING ERRORS IN ARGUMENT CHECKING ----
test_that("errors for count_PJScodes", {

  linewidth <- options("width")
  options(width = 80)

  expect_error(count_PJScodes(PJSdata = "no_data",
                              variable = "metodekode",
                              accepted = NULL,
                              translation_table = NULL),
               regexp = "Variable 'PJSdata': Must be of type 'data.frame', not 'character'.")

  PJSdata <- as.data.frame(c("010001", "010002", "060154", "010001", "010002", "070013"))
  colnames(PJSdata) <- "metodekode"

  expect_error(count_PJScodes(PJSdata = PJSdata,
                              variable = "Metodekoder",
                              accepted = NULL,
                              translation_table = NULL),
               regexp = "Variable 'variable': Must be element of set {'metodekode'}, but is",
               fixed = TRUE)

  # skip if no connection to 'FAG' have been established
  skip_if_not(dir.exists(set_dir_NVI("FAG")))

  PJS_codes_2_text <- NVIpjsr::read_PJS_codes_2_text()

  expect_error(count_PJScodes(PJSdata = PJSdata,
                              variable = "metodekode",
                              accepted = TRUE,
                              translation_table = PJS_codes_2_text),
               regexp = "Variable 'accepted': Must be of type 'character' (or 'NULL'), not",
               fixed = TRUE)

  expect_error(count_PJScodes(PJSdata = PJSdata,
                              variable = "metodekode",
                              accepted = "010001",
                              translation_table = "no_translation_table"),
               regexp = "Variable 'translation_table': Must be of type 'data.frame' (or",
               fixed = TRUE)

  options(width = unlist(linewidth))
})
