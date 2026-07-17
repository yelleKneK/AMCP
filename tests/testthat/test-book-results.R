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

test_that("chapter_7_exercise_18 salaries match the 4th-ed book (Assistant/Associate x F/M)", {
  # Book Exercise 18 (Table for the 2x2 gender x rank salary example, in
  # thousands): Assistant Females 73,76,75,78,82,77; Assistant Males
  # 79,78,80,84; Associate Females 82,80,84,83; Associate Males
  # 83,80,89,87,88,91,88,85. (AMCP had held these values 40 too low.)
  d <- get1("chapter_7_exercise_18")
  expect_equal(dim(d), c(22L, 3L))
  expect_identical(names(d), c("level", "gender", "salary"))
  expect_equal(d$salary[d$level == 1 & d$gender == 1], c(73, 76, 75, 78, 82, 77))
  expect_equal(d$salary[d$level == 1 & d$gender == 2], c(79, 78, 80, 84))
  expect_equal(d$salary[d$level == 2 & d$gender == 1], c(82, 80, 84, 83))
  expect_equal(d$salary[d$level == 2 & d$gender == 2], c(83, 80, 89, 87, 88, 91, 88, 85))
})

test_that("chapter_16 Table 16.1 and its reusing exercises agree in shape and order", {
  # The book's Exercise 5 analyzes the Table 16.1 data, and Exercises 7 and 9
  # analyze the Table 16.4 data. Each exercise data set should therefore be
  # identical to the table it reuses, column order included.
  t1 <- get1("chapter_16_table_1")
  expect_identical(names(t1), c("Trainee", "Gender", "Severity"))
  expect_identical(get1("chapter_16_exercise_5"), t1)
  t4 <- get1("chapter_16_table_4")
  expect_identical(get1("chapter_16_exercise_7"), t4)
  expect_identical(get1("chapter_16_exercise_9"), t4)
})

test_that("chapter_12_exercise_22 reproduces the Hu cuing-by-time interaction", {
  # Instructor manual: cuing x time interaction F(1, 39) = 14.61.
  d <- get1("chapter_12_exercise_22")
  expect_equal(dim(d), c(40L, 8L))
  expect_true(all(c("Cued_Prenap", "Cued_Postnap", "Uncued_Prenap", "Uncued_Postnap") %in% names(d)))
  ic <- (d$Cued_Postnap - d$Cued_Prenap) - (d$Uncued_Postnap - d$Uncued_Prenap)
  expect_equal(unname(t.test(ic)$statistic)^2, 14.61, tolerance = 5e-3)   # F(1, 39)
})

test_that("chapter_12_exercise_23 is the six-score follow-up with the reported interaction contrast", {
  # Instructor manual: n = 38 (two participants lack delayed scores); the
  # prenap-vs-delayed x cuing interaction contrast is F(1, 37) = 4.67.
  d <- get1("chapter_12_exercise_23")
  expect_equal(dim(d), c(38L, 10L))
  expect_true(all(c("Cued_Delayed", "Uncued_Delayed") %in% names(d)))
  ic <- (d$Cued_Delayed - d$Cued_Prenap) - (d$Uncued_Delayed - d$Uncued_Prenap)
  expect_equal(unname(t.test(ic)$statistic)^2, 4.67, tolerance = 1e-2)
})

test_that("chapter_12_exercise_25 uses the book's variable names and matches the Kroes Ch4 data", {
  # The book names the variables cond / reactivated / nonreactivated. The same
  # Kroes (2014) study supplies the one-way data of chapter_4_exercise_21, so
  # the reactivated-story scores here are those Chapter 4 memory scores.
  d <- get1("chapter_12_exercise_25")
  expect_equal(dim(d), c(39L, 3L))
  expect_identical(names(d), c("cond", "reactivated", "nonreactivated"))
  expect_equal(as.integer(table(d$cond)), c(13L, 13L, 13L))
  c4 <- get1("chapter_4_exercise_21")
  expect_equal(as.integer(d$reactivated), as.integer(c4$dv))
  expect_equal(as.integer(d$cond), as.integer(c4$cond))
})

test_that("chapter_12_exercise_24 reproduces the Carnes context main effect", {
  # Instructor manual: main effect of social context, Greenhouse-Geisser
  # adjusted, F(2.58, 301.61) = 509.10, p < .001.
  d <- get1("chapter_12_exercise_24")
  expect_equal(dim(d), c(118L, 25L))
  prin <- c("CARE", "FAIR", "LOYA", "AUTH", "PURE", "JUST")
  ctx  <- c("SOC", "TAS", "INT", "LOO")
  expect_identical(names(d), c("ID", as.vector(t(outer(prin, ctx, paste, sep = "_")))))
  M <- sapply(ctx, function(c0) rowMeans(d[, paste0(prin, "_", c0)]))
  n <- nrow(M); a <- ncol(M)
  gm <- mean(M); cm <- colMeans(M); sm <- rowMeans(M)
  SSa  <- n * sum((cm - gm)^2)
  SSas <- sum((M - outer(sm, rep(1, a)) - outer(rep(1, n), cm) + gm)^2)
  Fv <- (SSa / (a - 1)) / (SSas / ((n - 1) * (a - 1)))
  expect_equal(Fv, 509.10, tolerance = 1e-4)          # F(3, 351)
  # Greenhouse-Geisser epsilon -> adjusted df of (2.58, 301.61)
  S <- cov(M); p <- a
  Sb <- S - rowMeans(S) %o% rep(1, p) - rep(1, p) %o% colMeans(S) + mean(S)
  lam <- eigen(Sb, only.values = TRUE)$values[1:(p - 1)]
  eps <- sum(lam)^2 / ((p - 1) * sum(lam^2))
  expect_equal(eps * (a - 1), 2.58, tolerance = 5e-3)
  expect_equal(eps * (n - 1) * (a - 1), 301.61, tolerance = 5e-4)
})

test_that("chapter_12_exercise_26 reproduces the Gibson cell means", {
  # Instructor manual descriptive statistics (control n = 48, synesthesia n = 10).
  d <- get1("chapter_12_exercise_26")
  expect_equal(dim(d), c(58L, 6L))
  expect_identical(names(d), c("ID", "Group", "HFcorr", "LFcorr", "HFrecall", "LFrecall"))
  expect_equal(as.integer(table(d$Group)), c(48L, 10L))
  key <- list(HFcorr = c(.6871, .6693), LFcorr   = c(.5276, .5425),
              HFrecall = c(.4944, .7160), LFrecall = c(.3455, .5618))
  for (v in names(key)) {
    expect_equal(mean(d[[v]][d$Group == 0]), key[[v]][1], tolerance = 1e-4, info = v)
    expect_equal(mean(d[[v]][d$Group == 1]), key[[v]][2], tolerance = 1e-4, info = v)
  }
})

test_that("chapter_12_exercise_27 reproduces the Bray type-of-family effect", {
  # Instructor manual: main effect of type of family F(1, 191) = 19.53, p < .001;
  # 95 nuclear families and 98 stepfamilies.
  d <- get1("chapter_12_exercise_27")
  expect_equal(dim(d), c(193L, 6L))
  expect_identical(names(d), c("id", "grp", "sex", "mtb", "ftb", "ctb"))
  expect_equal(as.integer(table(d$grp)), c(95L, 98L))
  sm <- rowMeans(as.matrix(d[, c("mtb", "ftb", "ctb")]))
  fit <- anova(lm(sm ~ factor(d$grp)))
  expect_equal(fit$Df[2], 191L)
  expect_equal(fit$F[1], 19.53, tolerance = 1e-3)
})

test_that("chapter_4_exercise_18 is the four-therapy agoraphobia fear data", {
  d <- get1("chapter_4_exercise_18")
  expect_equal(dim(d), c(12L, 2L))
  expect_identical(names(d), c("dv", "cond"))
  expect_equal(d$dv[d$cond == 1], c(2, 4, 6))     # R-E
  expect_equal(d$dv[d$cond == 2], c(9, 12, 15))   # P
  expect_equal(d$dv[d$cond == 3], c(5, 6, 7))     # C-C
  expect_equal(d$dv[d$cond == 4], c(8, 10, 12))   # B
})

test_that("chapter_4_exercise_21 is the Kroes (2014) three-group memory data", {
  d <- get1("chapter_4_exercise_21")
  expect_equal(dim(d), c(39L, 2L))
  expect_identical(names(d), c("dv", "cond"))
  expect_equal(as.integer(table(d$cond)), c(13L, 13L, 13L))
  expect_equal(d$dv[d$cond == 1][1:3], c(30, 22, 21))
  expect_equal(d$dv[d$cond == 3][1:3], c(60, 36, 32))
})

test_that("chapter_6_exercise_11 is the drug-dosage maze-error data", {
  d <- get1("chapter_6_exercise_11")
  expect_equal(dim(d), c(20L, 2L))
  expect_identical(names(d), c("Errors", "Dosage"))
  expect_equal(d$Errors[d$Dosage == 1], c(6.6, 7.2, 5.0, 6.2, 5.8))
  expect_equal(d$Errors[d$Dosage == 4], c(4.2, 4.8, 5.0, 4.6, 5.2))
})

test_that("chapter_7_exercise_21 is the oxytocin/trust 2x2 data", {
  d <- get1("chapter_7_exercise_21")
  expect_equal(dim(d), c(40L, 3L))
  expect_identical(names(d), c("Gender", "Drug", "Trust"))
  expect_equal(d$Trust[d$Gender == 1 & d$Drug == 1], c(3, 5, 4, 5, 4, 2, 4, 3, 4, 2))
  expect_equal(d$Trust[d$Gender == 2 & d$Drug == 2], c(4, 3, 2, 3, 3, 1, 3, 2, 3, 3))
})

test_that("chapter_13_table_5 is the two-set determinant illustration (derived D scores)", {
  # Only the D1/D2 derived scores are given (no raw data). The book reports the
  # determinant of the D1,D2 SSCP matrix as 21.28 (set a) and 3157.03 (set b).
  d <- get1("chapter_13_table_5")
  expect_equal(dim(d), c(14L, 4L))
  expect_identical(names(d), c("SetA_D1", "SetA_D2", "SetB_D1", "SetB_D2"))
  expect_identical(d$SetA_D1, d$SetB_D1)                 # same D1 in both sets
  det2 <- function(x, y) sum(x^2) * sum(y^2) - sum(x * y)^2
  expect_equal(det2(d$SetA_D1, d$SetA_D2), 21.28, tolerance = 1e-6)
  expect_equal(det2(d$SetB_D1, d$SetB_D2), 3157.03, tolerance = 1e-6)
})

test_that("chapter_14_exercise_10 is the Kosslyn grids/brackets x hemisphere data", {
  # Book Exercise 10: 10 participants x (Grids/Brackets condition) x
  # (Left/Right hemisphere) response times. Same data as chapter_12_exercise_9;
  # AMCP once mislabeled the columns Angle0/Angle4/Angle8/Group.
  d <- get1("chapter_14_exercise_10")
  expect_equal(dim(d), c(10L, 4L))
  expect_identical(names(d), c("GridLeft", "GridRight", "BraceLeft", "BraceRight"))
  e <- get1("chapter_12_exercise_9")
  expect_equal(unname(as.matrix(d)), unname(as.matrix(e)))
})
