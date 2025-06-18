test_that("basic run works right", {
  expect_snapshot(get_TuNs("AA", type = "df"))
  expect_snapshot(get_TuNs("AA", type = "vec"))
})

test_that("diAA must be found in tangleDB", {
  expect_error(get_TuNs("XX"), "diAA 'XX' not found in tangledDB")
})

test_that("invalid types fail", {
  expect_error(get_TuNs("AA", type = "not_a_type"), "type must be either 'df' or 'vec'")
})

