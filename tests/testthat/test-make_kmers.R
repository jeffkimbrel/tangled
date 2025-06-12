test_that("make_kmers works", {
  expect_equal(length(make_kmers(3)), 64)
  expect_equal(length(make_kmers(4)), 256)
})

test_that("n outside of range fails", {
  expect_error(make_kmers(1), "n must be between 3 and 6")
  expect_error(make_kmers(7), "n must be between 3 and 6")
})
