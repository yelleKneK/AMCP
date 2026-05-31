# data-raw/build_catalog.R
#
# Build a machine-readable index of every AMCP data set from the single
# source of truth (R/documentation.R) and the shipped data/ directory.
# Writes data-raw/datasets_catalog.csv with one row per data set:
#
#   long_name   canonical long name      (e.g., chapter_1_table_1)
#   short_code  short alias that ships    (e.g., C1T1)
#   chapter     chapter number or NA      (tutorials have no chapter)
#   kind        table / exercise / extension_* / *_raw / *_univariate / tutorial_*
#   title       the human-readable title from the help page
#
# This script READS the canonical data; it never modifies data/ or
# documentation.R. Run from the package root:
#
#     Rscript data-raw/build_catalog.R
#
# ---------------------------------------------------------------------------
# ROADMAP / CUTOVER NOTE (deliberately NOT done here -- maintainer decision)
#
# The 139 roxygen blocks in R/documentation.R and the 278 hand-maintained
# .rda files contain a lot of mechanical duplication (long + short name,
# four alias forms, near-identical @usage/@examples). A future "reproducible
# build" could:
#   (1) treat datasets_catalog.csv (plus a per-dataset description file) as
#       the source of truth and GENERATE documentation.R from a template; and
#   (2) GENERATE each short-alias .rda from its long counterpart instead of
#       storing both by hand.
# That would remove the copy/paste surface entirely. It is intentionally left
# undone: AMCP's contract is exact fidelity to the printed book, so changing
# how the shipped files are produced should be a conscious, reviewed cutover,
# not a side effect. For now this directory is VERIFY-ONLY -- build_catalog.R
# indexes the canonical data and verify.R proves it is internally consistent.
# ---------------------------------------------------------------------------

source("data-raw/parse_documentation.R")

blocks    <- parse_amcp_docs("R/documentation.R")
rda_names <- sub("\\.rda$", "", list.files("data", pattern = "\\.rda$"))

chapter_of <- function(long) {
  if (grepl("^tutorial_", long)) return(NA_integer_)
  ch <- sub("^chapter_([0-9]+)_.*$", "\\1", long)
  suppressWarnings(as.integer(ch))
}

kind_of <- function(long) {
  parts <- character(0)
  if (grepl("_extension_", long))  parts <- c(parts, "extension")
  if (grepl("_figures_", long))    parts <- c(parts, "figures")
  if (grepl("_table_", long))      parts <- c(parts, "table")
  if (grepl("_exercise_", long))   parts <- c(parts, "exercise")
  if (grepl("_univariate$", long)) parts <- c(parts, "univariate")
  if (grepl("_raw$", long))        parts <- c(parts, "raw")
  if (grepl("^tutorial_", long))   parts <- c(parts, "tutorial")
  if (!length(parts)) parts <- "other"
  paste(parts, collapse = "_")
}

rows <- lapply(blocks, function(b) {
  ln    <- b$long_name
  # The short code is the alias that actually ships as its own .rda.
  short <- setdiff(intersect(unique(c(ln, b$aliases)), rda_names), ln)
  short <- if (length(short) == 1L) short else paste(short, collapse = "|")
  data.frame(
    long_name  = ln,
    short_code = short,
    chapter    = chapter_of(ln),
    kind       = kind_of(ln),
    title      = b$title,
    stringsAsFactors = FALSE
  )
})

catalog <- do.call(rbind, rows)
catalog <- catalog[order(catalog$chapter, catalog$kind, catalog$long_name), ]
rownames(catalog) <- NULL

write.csv(catalog, "data-raw/datasets_catalog.csv", row.names = FALSE)
cat(sprintf("Wrote data-raw/datasets_catalog.csv: %d rows\n", nrow(catalog)))
print(utils::head(catalog, 8))
