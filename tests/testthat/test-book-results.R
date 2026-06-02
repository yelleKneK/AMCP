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

test_that("chapter_13_table_2: trend-contrast omnibus F = 19.148 (4th ed.)", {
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

test_that("chapter_7_table_9 is the six additional blood-pressure observations", {
  # Book Table 7.9 ("Additional Observations for Table 7.5 Data"): one extra
  # observation for each of the six cells of the 2 (Feedback) x 3 (Drug)
  # design in Table 7.5, in the same cell order (Feedback slowest).
  d9 <- get1("chapter_7_table_9")
  expect_equal(dim(d9), c(6L, 3L))
  expect_identical(names(d9), c("Score", "Feedback", "Drug"))
  expect_identical(d9$Score,    c(158L, 209L, 194L, 198L, 195L, 204L))
  expect_identical(d9$Feedback, c(1L, 1L, 1L, 2L, 2L, 2L))
  expect_identical(d9$Drug,     c(1L, 2L, 3L, 1L, 2L, 3L))

  # Stacking onto Table 7.5 gives six observations per cell; the cell and
  # marginal means of the combined data are those reported in Table 7.10.
  d5 <- get1("chapter_7_table_5")
  combined <- rbind(d5, d9)
  expect_equal(dim(combined), c(36L, 3L))
  cm <- tapply(combined$Score, list(combined$Feedback, combined$Drug), mean)
  expect_equal(as.vector(cm["1", ]), c(168, 204, 189))  # biofeedback present
  expect_equal(as.vector(cm["2", ]), c(188, 200, 209))  # biofeedback absent
  expect_equal(as.vector(tapply(combined$Score, combined$Feedback, mean)),
               c(187, 199))                              # Feedback marginals
  expect_equal(as.vector(tapply(combined$Score, combined$Drug, mean)),
               c(178, 202, 199))                         # Drug marginals
  expect_equal(mean(combined$Score), 193)                # grand mean
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

test_that("chapter_13_table_10 holds the linear and quadratic D variables", {
  d <- get1("chapter_13_table_10")
  expect_equal(dim(d), c(8L, 2L))
  expect_identical(names(d), c("Linear", "Quadratic"))
  # Formed from the three-level data of Table 13.2 using the orthogonal
  # polynomial coefficients for three levels (Appendix Table A.10): linear
  # (-1, 0, 1); quadratic reported with the equally valid sign (-1, 2, -1).
  raw <- get1("chapter_13_table_2")
  expect_equal(d$Linear,    raw$Time3 - raw$Time1)
  expect_equal(d$Quadratic, 2 * raw$Time2 - raw$Time1 - raw$Time3)
})

test_that("chapter_3_table_3 is condition / rating", {
  d <- get1("chapter_3_table_3")
  expect_equal(dim(d), c(NROW(d), 2L))
  expect_identical(names(d), c("Condition", "Rating"))
})

test_that("chapter_14_table_9 is the three-angle reaction-time data (Angle0/4/8 + Group)", {
  # Book Table 14.9: raw reaction times for 10 young + 10 old participants
  # at 0/4/8 degrees off center. Rows 1-10 columns 1-3 reproduce the young
  # participants' angle data in chapter_12_table_7; the 4th column is a 1/2
  # group indicator (10 per group).
  d9 <- get1("chapter_14_table_9")
  d7 <- get1("chapter_12_table_7")
  expect_equal(dim(d9), c(20L, 4L))
  expect_identical(names(d9), c("Angle0", "Angle4", "Angle8", "Group"))
  expect_equal(unname(as.matrix(d9[1:10, 1:3])), unname(as.matrix(d7)))
  expect_identical(as.integer(d9[[4]]), rep(1:2, each = 10L))
})

test_that("chapter_14_table_7 is the two-angle (0/8) subset of the angle data", {
  # Book Table 14.7: the same participants restricted to the 0 and 8 degree
  # conditions (the 4 degree column of Table 14.9 dropped).
  d7r <- get1("chapter_14_table_7")
  d9  <- get1("chapter_14_table_9")
  expect_equal(dim(d7r), c(20L, 3L))
  expect_identical(names(d7r), c("Angle0", "Angle8", "Group"))
  expect_equal(d7r$Angle0, d9$Angle0)
  expect_equal(d7r$Angle8, d9$Angle8)
  expect_identical(as.integer(d7r$Group), rep(1:2, each = 10L))
})

test_that("chapter_14_table_8 holds the M and D transforms of Table 14.7", {
  # Book Table 14.8: M = mean(0, 8), D = 8 - 0, per participant.
  d8 <- get1("chapter_14_table_8")
  d7r <- get1("chapter_14_table_7")
  expect_equal(dim(d8), c(20L, 3L))
  expect_identical(names(d8), c("M", "D", "Group"))
  expect_equal(d8$M, (d7r$Angle0 + d7r$Angle8) / 2)
  expect_equal(d8$D, d7r$Angle8 - d7r$Angle0)
  expect_equal(mean(d8$M[d8$Group == 1L]), 561)     # young, book mean
  expect_equal(mean(d8$M[d8$Group == 2L]), 667.5)   # old, book mean
})

test_that("chapter_14_table_10 holds the M, D1, D2 transforms of Table 14.9", {
  # Book Table 14.10: M = mean(0, 4, 8), D1 = 8 - 0 (linear),
  # D2 = 0 - 2*4 + 8 (quadratic), per participant.
  d10 <- get1("chapter_14_table_10")
  d9  <- get1("chapter_14_table_9")
  expect_equal(dim(d10), c(20L, 4L))
  expect_identical(names(d10), c("M", "D1", "D2", "Group"))
  expect_equal(d10$M,  (d9$Angle0 + d9$Angle4 + d9$Angle8) / 3)
  expect_equal(d10$D1, d9$Angle8 - d9$Angle0)
  expect_equal(d10$D2, d9$Angle0 - 2 * d9$Angle4 + d9$Angle8)
  expect_equal(mean(d10$M[d10$Group == 1L]), 569)   # young group mean
  expect_equal(mean(d10$M[d10$Group == 2L]), 663)   # old group mean
  expect_equal(mean(d10$M), 616)                    # grand mean
})
