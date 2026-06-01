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
* Several data sets were renamed so their numbers match the 4th edition's
  table numbering, which shifted relative to earlier printings:
  `chapter_7_table_15` becomes `chapter_7_table_16`, `chapter_7_table_23`
  becomes `chapter_7_table_24`, `chapter_9_table_11` becomes
  `chapter_9_table_12`, `chapter_12_table_21` becomes `chapter_12_table_29`,
  `chapter_13_table_12` becomes `chapter_13_table_10`, and the split-plot
  reaction-time tables `chapter_14_table_8` and `chapter_14_table_10`
  become `chapter_14_table_7` and `chapter_14_table_9`. Only the names
  changed; the data values are identical. The short aliases were renamed to
  match (for example, `C7T15` becomes `C7T16`).
* Added the transformed-score data sets the 4th edition reports alongside
  the split-plot example: `chapter_14_table_8` (the *M* and *D* scores for
  the data in Table 14.7) and `chapter_14_table_10` (the *M*, *D1*, and
  *D2* scores for the data in Table 14.9), each also under its short alias
  (`C14T8`, `C14T10`).
* Removed `chapter_13_table_14` (and its alias `C13T14`). Its slope and
  linear-trend scores correspond to a 3rd-edition table that is not part of the
  4th edition; the linear-trend values it tabulated remain available as the
  `Linear` column of `chapter_13_table_10`.
* For the data exactly as distributed with the 3rd edition (2018),
  install the archived CRAN release 1.0.2:
  `remotes::install_version("AMCP", "1.0.2")`.

## Documentation

* Corrected the `Variables` lists in several help pages that had been
  copied from the wrong data set, so the documented variables now match
  the shipped columns: `chapter_3_table_3`, `chapter_7_table_11`,
  `chapter_10_table_9`, `chapter_11_table_20`, and `chapter_13_table_10`.
* Fixed assorted spelling and typographical errors in the help text and
  added an `inst/WORDLIST` for the package's domain vocabulary.
* The `chapter_13_table_10` examples now show how its linear and quadratic D
  variables are formed from the raw three-level data of `chapter_13_table_2`
  using the orthogonal-polynomial coefficients of Appendix Table A.10.

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
