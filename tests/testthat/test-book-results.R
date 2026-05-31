# Reproduce specific numeric results reported in the printed book, so a
# bad re-serialization or a wrong table swapped in is caught by R CMD
# check. Each block recomputes a quantity the book states and compares.
#
# These complement test-content-anchors.R (which pins shapes/columns and
# the Pygmalion ANCOVA slopes).

get1 <- function(nm) {
  e <- new.env()
  suppressWarnings(data(list = nm, package = "AMCP", envir = e))
  get(nm, envir = e, inherits = FALSE)
}

test_that("chapter_3_table_1: one-sample t vs mu = 98 gives t = 3, F = 9", {
  d <- get1("chapter_3_table_1")
  expect_equal(dim(d), c(6L, 1L))
  expect_identical(names(d), "IQ")
  tt <- t.test(d$IQ, mu = 98)
  expect_equal(unname(tt$statistic), 3, tolerance = 1e-6)   # t(5) = 3
  expect_equal(unname(tt$statistic)^2, 9, tolerance = 1e-6) # F(1,5) = 9
})

test_that("chapter_13_table_2: trend-contrast omnibus F = 19.148 (book pp.646-647)", {
  d <- get1("chapter_13_table_2")
  expect_equal(dim(d), c(8L, 3L))
  expect_identical(names(d), c("Time1", "Time2", "Time3"))
  # Linear and quadratic D variables, analyzed as a Hotelling T^2.
  D <- cbind(lin  = d$Time3 - d$Time1,
             quad = d$Time1 - 2 * d$Time2 + d$Time3)
  n <- nrow(D); p <- ncol(D)
  dbar <- colMeans(D); S <- cov(D)
  T2 <- n * as.numeric(t(dbar) %*% solve(S) %*% dbar)
  Fval <- (n - p) / (p * (n - 1)) * T2   # df = (p, n - p) = (2, 6)
  expect_equal(Fval, 19.148, tolerance = 5e-3)
})

# ---- Structural anchors for the data sets whose @section Variables were
# corrected in documentation.R (they had blocks copy-pasted from other
# tables). Pinning the columns keeps the docs and the data in lock-step.

test_that("chapter_7_table_11 is the 3x3 diagnosis-by-task design", {
  d <- get1("chapter_7_table_11")
  expect_equal(dim(d), c(45L, 3L))
  expect_identical(names(d), c("Diagnosis", "Task", "Y"))
  expect_identical(sort(unique(d$Diagnosis)), 1:3)
  expect_identical(sort(unique(d$Task)), 1:3)
})

test_that("chapter_10_table_9 is gender / nested-trainee / severity", {
  d <- get1("chapter_10_table_9")
  expect_equal(dim(d), c(24L, 3L))
  expect_identical(names(d), c("Gender", "Trainee", "Severity"))
})

test_that("chapter_11_table_20 is subject / judge / rating", {
  d <- get1("chapter_11_table_20")
  expect_equal(dim(d), c(15L, 3L))
  expect_identical(names(d), c("Subject", "Judge", "Rating"))
})

test_that("chapter_13_table_12 holds the linear and quadratic D variables", {
  d <- get1("chapter_13_table_12")
  expect_equal(dim(d), c(8L, 2L))
  expect_identical(names(d), c("Linear", "Quadratic"))
})

test_that("chapter_3_table_3 is condition / rating", {
  d <- get1("chapter_3_table_3")
  expect_equal(dim(d), c(NROW(d), 2L))
  expect_identical(names(d), c("Condition", "Rating"))
})

test_that("chapter_14_table_10 values are the chapter-12 angle RT data plus a group code", {
  # FIDELITY FLAG (for Ken): the shipped column NAMES of
  # chapter_14_table_10 are GridLeft/GridRight/BraceLeft/BraceRight, which
  # appear to be a mislabel. Its documentation and the book describe
  # Angle0/Angle4/Angle8 plus a Group code, and the VALUES below confirm
  # that: rows 1-10 columns 1-3 are identical to chapter_12_table_7, and
  # the 4th column is a 1/2 group indicator (10 per group). The data are
  # therefore correct; only the names look wrong. We pin the values (not
  # the suspect names) and leave the data structure unchanged pending
  # Ken's decision, since renaming columns touches data structure.
  d10 <- get1("chapter_14_table_10")
  d7  <- get1("chapter_12_table_7")
  expect_equal(dim(d10), c(20L, 4L))
  expect_equal(unname(as.matrix(d10[1:10, 1:3])),
               unname(as.matrix(d7)))
  expect_identical(as.integer(d10[[4]]), rep(1:2, each = 10L))
})
