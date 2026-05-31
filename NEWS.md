# AMCP 2.0.0

A major release that tailors the package to the **4th edition** of
Maxwell, Delaney, and Kelley, *Designing Experiments and Analyzing Data:
A Model Comparison Perspective* (2026, Routledge).

## Data

* The data sets now correspond to the 4th edition of the book: the
  chapter tables, the end-of-chapter exercises, and the tutorials. Each
  data set continues to ship under both its long name (e.g.,
  `chapter_1_table_1`) and its short alias (e.g., `C1T1`), and the
  numeric coding of variables is preserved so the book's model-comparison
  and contrast examples reproduce exactly.
* For the data exactly as distributed with the 3rd edition (2018),
  install the archived CRAN release 1.0.2:
  `remotes::install_version("AMCP", "1.0.2")`.

## Documentation

* Corrected the `Variables` lists in several help pages that had been
  copied from the wrong data set, so the documented variables now match
  the shipped columns: `chapter_3_table_3`, `chapter_7_table_11`,
  `chapter_10_table_9`, `chapter_11_table_20`, and `chapter_13_table_12`.
* Fixed assorted spelling and typographical errors in the help text and
  added an `inst/WORDLIST` for the package's domain vocabulary.

## Infrastructure

* Added a `testthat` (edition 3) test suite that loads every data set,
  checks that the long and short aliases agree, and reproduces several
  numeric results reported in the book (the Chapter 3 one-sample
  *t* test, the Chapter 13 trend-contrast omnibus *F*, and the Chapter 9
  Pygmalion heterogeneity-of-regression slopes).
* Added a vignette, `factors-and-coding`, with recipes for attaching
  factor labels to the numerically coded variables without changing the
  canonical data, including a worked example confirming that relabeling
  reproduces the book's results.
* Added a package `CITATION` file.
* Added developer-only `data-raw/` scripts (not shipped) that regenerate
  the `.rda` files from the companion-website CSVs and verify
  documentation/data consistency.
