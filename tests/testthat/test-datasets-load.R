# Every advertised data set must load and be non-empty. This bakes in
# the audit that the data/ lazy-load database is intact and that every
# item promised by data(package = "AMCP") resolves to a real object.
# AMCP ships each data set under two names (a long canonical name such
# as chapter_1_table_1 and a short alias such as C1T1), so the total
# count is exactly twice the number of distinct data sets.

test_that("the catalog has the expected size (139 data sets x 2 names)", {
  items <- data(package = "AMCP")$results[, "Item"]
  expect_equal(length(items), 278L)

  long  <- items[grepl("^(chapter|tutorial)_", items)]
  expect_equal(length(long), 139L)
  # Every long-named data set is matched one-to-one by a short alias.
  expect_equal(length(items) - length(long), 139L)
})

test_that("every advertised data set loads and is non-empty", {
  items <- data(package = "AMCP")$results[, "Item"]
  e <- new.env()
  for (it in items) {
    suppressWarnings(data(list = it, package = "AMCP", envir = e))
    expect_true(exists(it, envir = e, inherits = FALSE), info = it)
    obj <- get(it, envir = e, inherits = FALSE)
    expect_false(is.null(obj), info = it)
    expect_gt(NROW(obj), 0L)
  }
})
