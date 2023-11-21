library(testthat)
test_that("Individual creation", {
  expect_error(Individual$new('Male', '25', 1.75, 70))
  expect_error(Individual$new('M', 25, 1.75, 70))
  expect_error(Individual$new('Male', 25, 175, 70))
  expect_error(Individual$new('Male', 25, 1.75, 700))
})
