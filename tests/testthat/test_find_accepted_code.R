library(OKcheck)
library(testthat)

test_that("find accepted code", {
  # Generate test data
  accepted_codes <- cbind(as.data.frame(rep(2021, 6)),
                          as.data.frame(rep("ok_gris_virus", 6)),
                          as.data.frame(rep("0200102", 6)),
                          as.data.frame(rep("artkode", 6)),
                          as.data.frame(c("0310010100", "0310010100%", "0310010100",
                                          "0310010100", "0310010100%", "0310010100")),
                          as.data.frame(rep(NA, 6)),
                          as.data.frame(rep(NA, 6)),
                          as.data.frame(rep(NA, 6)),
                          as.data.frame(rep(NA, 6)))
  colnames(accepted_codes) <- c("aar", "program", "hensikt", "var1", "verdi1", "var2", "verdi2", "var3", "verdi3")

  expect_equal(find_accepted_code(data = accepted_codes, purpose = "ok_gris_virus", code_variable = "artkode"),
                    c("0200102-0310010100", "0200102-0310010100%"))
  })
