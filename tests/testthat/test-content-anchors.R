# Content anchors for fidelity to the printed book. These pin the
# dimensions, column names, and a few key values of data sets whose
# content matters most, so that any accidental change to the data
# (a bad re-serialization, a wrong table swapped in) is caught.
#
# chapter_13_table_6 is the table that was swapped in for the 4th
# edition; pinning it guards that edition-specific change.

get1 <- function(nm) {
  e <- new.env()
  suppressWarnings(data(list = nm, package = "AMCP", envir = e))
  get(nm, envir = e, inherits = FALSE)
}

test_that("chapter_1_table_1 has the expected shape", {
  d <- get1("chapter_1_table_1")
  expect_equal(dim(d), c(10L, 3L))
  expect_identical(names(d), c("treat", "control", "week"))
})

test_that("the teacher-expectancy (Pygmalion) data are intact", {
  # Chapter 3 exercise 22: 310 x 5 (no IQGain).
  d3 <- get1("chapter_3_exercise_22")
  expect_equal(dim(d3), c(310L, 5L))
  expect_identical(names(d3), c("Grade", "Treatment", "IQPre", "IQ4", "IQ8"))

  # Chapter 9 exercise 15: 310 x 6 (adds IQGain).
  d9 <- get1("chapter_9_exercise_15")
  expect_equal(dim(d9), c(310L, 6L))
  expect_identical(names(d9),
                   c("Grade", "Treatment", "IQPre", "IQ4", "IQ8", "IQGain"))

  # Group sizes: 246 control, 64 expectancy ("bloomer").
  tt <- table(d9$Treatment)
  expect_equal(as.integer(tt[["0"]]), 246L)
  expect_equal(as.integer(tt[["1"]]), 64L)
  # IQGain is exactly the pretest-to-IQ8 change.
  expect_true(all(d9$IQGain == d9$IQ8 - d9$IQPre))
  # The book's heterogeneity-of-regression slopes reproduce.
  b <- coef(lm(IQ8 ~ IQPre * factor(Treatment), data = d9))
  expect_equal(unname(b["IQPre"]), 0.77799, tolerance = 1e-4)
  expect_equal(unname(b["IQPre"] + b["IQPre:factor(Treatment)1"]),
               0.96895, tolerance = 1e-4)
})

test_that("chapter_13_table_6 (the 4th-edition table) is in place", {
  d <- get1("chapter_13_table_6")
  expect_equal(dim(d), c(12L, 4L))
  expect_identical(names(d),
                   c("Months30", "Months36", "Months42", "Months48"))
})
