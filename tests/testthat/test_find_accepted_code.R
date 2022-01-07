library(OKcheck)
library(testthat)

test_that("find accepted code", {
  # Generate test data
  accepted_codes <- cbind(as.data.frame(rep(2021, 6)),
                          as.data.frame(rep("ok_gris_virus", 6)),
                          as.data.frame(rep("artkode", 6)),
                          as.data.frame(c("0310010100", "0310010100%", "0310010100",
                                          "0310010100", "0310010100%", "0310010100")))
  colnames(accepted_codes) <- c("aar", "program", "var1", "verdi1")

  expect_equal(find_accepted_code(data = accepted_codes, purpose = "ok_gris_virus", codetype = "artkode"),
                    c("0310010100", "0310010100%"))
  })
