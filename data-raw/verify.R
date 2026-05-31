# data-raw/verify.R
#
# Verify-only integrity check for the AMCP data package. This script does
# NOT regenerate or overwrite any shipped artifact: it reads the canonical
# data/*.rda and the single documentation source (R/documentation.R) and
# confirms they are mutually consistent. It is meant to catch the kind of
# copy/paste slips that creep into 139 near-identical roxygen blocks and
# 278 hand-maintained .rda files.
#
# Run from the package root:
#
#     Rscript data-raw/verify.R
#
# Exit status is 0 on PASS and 1 on any FAIL, so it can gate a build.

source("data-raw/parse_documentation.R")

blocks    <- parse_amcp_docs("R/documentation.R")
rda_files <- list.files("data", pattern = "\\.rda$")
rda_names <- sub("\\.rda$", "", rda_files)

load_one <- function(path) {
  e  <- new.env(parent = emptyenv())
  nm <- load(path, envir = e)
  if (length(nm) != 1L) {
    stop(sprintf("%s contains %d objects (expected 1)", path, length(nm)))
  }
  get(nm, envir = e, inherits = FALSE)
}

problems  <- character(0)
flag      <- function(...) problems <<- c(problems, sprintf(...))
pairs     <- list()  # long_name -> short_code, for orphan/dup accounting

for (b in blocks) {
  ln <- b$long_name

  ## CHECK A -- doc-block internal consistency (copy/paste guard)
  if (!isTRUE(b$n_name == 1L))
    flag("[%s] expected exactly 1 @name, found %d", ln, b$n_name)
  if (!isTRUE(identical(b$name_tag, ln)))
    flag("[%s] @name (%s) does not match the sentinel", ln, b$name_tag)
  if (!isTRUE(b$n_usage == 1L))
    flag("[%s] expected exactly 1 @usage, found %d", ln, b$n_usage)
  if (!isTRUE(identical(b$usage_target, ln)))
    flag("[%s] @usage data(%s) does not match the sentinel", ln, b$usage_target)
  if (!isTRUE(b$n_aliases == 1L))
    flag("[%s] expected exactly 1 @aliases line, found %d", ln, b$n_aliases)
  if (!(ln %in% b$aliases))
    flag("[%s] sentinel is not listed among its own @aliases", ln)
  if (!isTRUE(b$has_doctype))
    flag("[%s] missing @docType", ln)

  ## CHECK B -- the long and short forms ship and are identical objects
  candidate <- unique(c(ln, b$aliases))
  with_rda  <- intersect(candidate, rda_names)
  if (!(ln %in% with_rda))
    flag("[%s] no data/%s.rda found", ln, ln)
  short <- setdiff(with_rda, ln)
  if (length(with_rda) != 2L || length(short) != 1L) {
    flag("[%s] expected exactly two shipped names (long + short), found {%s}",
         ln, paste(with_rda, collapse = ", "))
  } else {
    o_long  <- load_one(file.path("data", paste0(ln, ".rda")))
    o_short <- load_one(file.path("data", paste0(short, ".rda")))
    if (!identical(o_long, o_short))
      flag("[%s] data/%s.rda is NOT identical to data/%s.rda", ln, ln, short)
    if (is.null(nrow(o_long)) || nrow(o_long) < 1L)
      flag("[%s] loaded object has no rows", ln)
    pairs[[ln]] <- short
  }
}

## GLOBAL checks
if (length(blocks) != 139L)
  flag("expected 139 documentation blocks, found %d", length(blocks))
if (length(rda_files) != 278L)
  flag("expected 278 .rda files, found %d", length(rda_files))

linked <- unlist(lapply(names(pairs), function(ln) c(ln, pairs[[ln]])))
orphan <- setdiff(rda_names, linked)
if (length(orphan))
  flag("%d .rda not linked to any documentation block: %s",
       length(orphan), paste(orphan, collapse = ", "))
dup <- unique(linked[duplicated(linked)])
if (length(dup))
  flag("%d .rda linked to more than one block: %s",
       length(dup), paste(dup, collapse = ", "))

## REPORT
cat(sprintf("AMCP verify: %d documentation blocks, %d .rda files (%d data sets)\n",
            length(blocks), length(rda_files), length(pairs)))
if (length(problems)) {
  cat(sprintf("FAIL: %d problem(s):\n", length(problems)))
  cat(paste0("  - ", problems, collapse = "\n"), "\n", sep = "")
  quit(status = 1L, save = "no")
}
cat("PASS: documentation, aliases, and shipped .rda are mutually consistent.\n")
