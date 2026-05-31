# AMCP ships each data set twice: once under a long canonical name
# (e.g., chapter_1_table_1) and once under a short alias (e.g., C1T1).
# The two must be byte-for-byte identical objects. These pairs span
# every naming family in the package (chapter tables, chapter
# exercises, chapter extension exercises, and tutorial tables); if the
# alias convention ever drifts, one of these will fail.

alias_pairs <- list(
  c("chapter_1_table_1",              "C1T1"),
  c("chapter_3_exercise_22",          "C3E22"),
  c("chapter_9_exercise_15",          "C9E15"),
  c("chapter_9_extension_exercise_3", "C9ExtE3"),
  c("tutorial_1_table_1",             "T1T1"),
  c("tutorial_2_table_2",             "T2T2")
)

test_that("long canonical names and short aliases are identical objects", {
  e <- new.env()
  for (pr in alias_pairs) {
    long <- pr[1]; short <- pr[2]
    suppressWarnings(data(list = long,  package = "AMCP", envir = e))
    suppressWarnings(data(list = short, package = "AMCP", envir = e))
    expect_true(exists(long,  envir = e, inherits = FALSE), info = long)
    expect_true(exists(short, envir = e, inherits = FALSE), info = short)
    expect_identical(get(long, envir = e), get(short, envir = e),
                     info = paste(long, "==", short))
  }
})
