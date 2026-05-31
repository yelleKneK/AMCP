# data-raw/parse_documentation.R
#
# Parse R/documentation.R into one record per data set. Each data set's
# roxygen block ends with a trailing string-literal "sentinel" line, e.g.
#
#     "chapter_1_table_1"
#
# This file is PURE parsing: it has no side effects and writes nothing.
# It is sourced by data-raw/build_catalog.R and data-raw/verify.R so that
# both share a single, tested view of how the documentation is structured.
#
# Returns a list of records, one per data set, each a named list with:
#   long_name     the sentinel (authoritative long data-set name)
#   name_tag      the value of @name (should equal long_name)
#   n_name        number of @name tags found in the block (should be 1)
#   usage_raw     the raw @usage text
#   usage_target  the X inside @usage data(X) (should equal long_name)
#   n_usage       number of @usage tags found (should be 1)
#   aliases       character vector of @aliases tokens
#   n_aliases     number of @aliases LINES found (should be 1)
#   has_doctype   TRUE if @docType is present
#   title         first non-tag, non-empty roxygen line (human title)
#   block_start   first source line of the block
#   block_end     source line of the sentinel

parse_amcp_docs <- function(doc_path = "R/documentation.R") {
  lines <- readLines(doc_path, warn = FALSE)

  # A sentinel is a quoted bare name alone on its line: "chapter_1_table_1"
  sentinel_re <- '^"([A-Za-z][A-Za-z0-9_]*)"[[:space:]]*$'
  sentinel_idx <- which(grepl(sentinel_re, lines))
  if (length(sentinel_idx) == 0L) {
    stop("parse_amcp_docs(): no dataset sentinels found in ", doc_path)
  }

  # Block k runs from just after the previous sentinel through sentinel k.
  starts <- c(1L, utils::head(sentinel_idx, -1L) + 1L)
  ends   <- sentinel_idx

  extract_one <- function(s, e) {
    blk      <- lines[s:e]
    sentinel <- sub(sentinel_re, "\\1", blk[length(blk)])

    # Roxygen body lines (strip the leading "#'" and one optional space).
    rox     <- blk[grepl("^[[:space:]]*#'", blk)]
    rox_txt <- sub("^[[:space:]]*#'[[:space:]]?", "", rox)

    tag_val <- function(tag) {
      hit <- grep(paste0("^@", tag, "\\b"), rox_txt)
      if (length(hit) == 0L) return(character(0))
      trimws(sub(paste0("^@", tag, "[[:space:]]*"), "", rox_txt[hit]))
    }

    name_tag <- tag_val("name")
    usage    <- tag_val("usage")
    aliases  <- tag_val("aliases")
    doctype  <- tag_val("docType")

    # Title: first roxygen line that is neither a tag nor blank.
    body  <- rox_txt[!grepl("^@", rox_txt) & nzchar(trimws(rox_txt))]
    title <- if (length(body)) trimws(body[[1]]) else NA_character_

    # @usage data(X) -> X
    usage_target <- NA_character_
    if (length(usage) == 1L) {
      m <- regmatches(usage, regexpr("data\\(([^)]*)\\)", usage))
      if (length(m) == 1L && nzchar(m)) {
        usage_target <- sub("data\\(([^)]*)\\)", "\\1", m)
        usage_target <- gsub('[[:space:]"]', "", usage_target)
      }
    }

    alias_tokens <- if (length(aliases) == 1L) {
      strsplit(aliases, "[[:space:]]+")[[1]]
    } else {
      character(0)
    }

    list(
      long_name    = sentinel,
      name_tag     = if (length(name_tag) == 1L) name_tag else NA_character_,
      n_name       = length(name_tag),
      usage_raw    = if (length(usage) == 1L) usage else NA_character_,
      usage_target = usage_target,
      n_usage      = length(usage),
      aliases      = alias_tokens,
      n_aliases    = length(aliases),
      has_doctype  = length(doctype) >= 1L,
      title        = title,
      block_start  = s,
      block_end    = e
    )
  }

  Map(extract_one, starts, ends)
}
