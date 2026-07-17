# AMCP 2.0.0

A major release that tailors the package to the **4th edition** of
Maxwell, Delaney, and Kelley, *Designing Experiments and Analyzing Data:
A Model Comparison Perspective* (2027, Routledge).

## Data

* Added the three Chapter 12 exercise data sets that the book directs readers to
  the companion website for, each under a long name and short alias:
  `chapter_12_exercise_24` (`C12E24`), the Carnes, Lickel, and Janoff-Bulman
  (2015) study in which 118 participants rated six moral principles in each of
  four social contexts; `chapter_12_exercise_26` (`C12E26`), the Gibson,
  Radvansky, Johnson, and McNerney (2012) grapheme-color synesthesia study (48
  nonsynesthetes and 10 synesthetes, with input-output correspondence and recall
  accuracy for high- and low-frequency words); and `chapter_12_exercise_27`
  (`C12E27`), the Bray and Maxwell (1995) reports of negative life events from
  the mother, father, and child of 95 nuclear families and 98 stepfamilies. Each
  reproduces the results reported for its exercise.
* New data set `chapter_14_table_13` (alias `C14T13`): the longitudinal
  randomized design introduced in Chapter 14 (100 participants, 44
  treatment and 56 control, measured at baseline and two post-intervention
  occasions). These data underlie Tables 14.13 and 14.14 and are analyzed
  again with mixed-effects models in Chapter 15 (Tables 15.15 and 15.16).
  Stored in the long format expected by the Chapter 15 code.
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
  `chapter_13_table_5` becomes `chapter_13_table_6`, `chapter_13_table_12`
  becomes `chapter_13_table_10`, and the split-plot
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
* Removed `chapter_4_table_7` (and its alias `C4T7`). It held data for a
  3rd-edition demonstration that the sums of squares of orthogonal contrasts are
  additive while those of nonorthogonal contrasts are not; in the 4th edition
  that demonstration moved to the online supplement
  (designingexperiments.com/supplements), so the data set no longer corresponds
  to a printed table. The 4th edition's printed Table 4.7 is the Exercise 11
  data, which is already shipped as `chapter_4_exercise_11`.
* Corrected the content of `chapter_7_table_9` (and its alias `C7T9`). It had
  held a 36-row combined data set (the Table 7.5 blood-pressure data with a
  sixth observation appended to each cell). The 4th edition's Table 7.9 is
  instead the six *additional* observations themselves (one per cell), so the
  data set now holds those six rows. Stacking them onto `chapter_7_table_5`
  with `rbind()` recreates the six-per-cell data whose cell and marginal means
  are reported in Table 7.10.
* Added five data sets that appear in the 4th edition but had not shipped
  previously, each under a long name and short alias:
  `chapter_4_exercise_18` (`C4E18`, four-therapy agoraphobia fear scores),
  `chapter_4_exercise_21` (`C4E21`, the Kroes et al. (2014) three-group ECT
  memory data), `chapter_6_exercise_11` (`C6E11`, drug-dosage maze errors),
  `chapter_7_exercise_21` (`C7E21`, the oxytocin-by-gender trust study), and
  `chapter_13_table_5` (`C13T5`). `chapter_13_table_5` is Table 13.5 of the 4th
  edition ("Two Sets of Hypothetical Data to Illustrate How a Determinant
  Reflects Generalized Variance"); it holds only the two D (difference) variables
  for each of the two data sets, because the book gives only those derived scores
  and not the raw data they were computed from. (In the 4th edition the
  3rd-edition Table 13.5 was renumbered to Table 13.6, shipped as
  `chapter_13_table_6`.)
* Corrected the salaries in `chapter_7_exercise_18` (and its alias `C7E18`).
  Every value had been 40 (thousand) too low relative to the 4th edition's
  Exercise 18 table; the salaries now match the book exactly (Assistant-rank
  females 73, 76, 75, 78, 82, 77; and so on). The `level` and `gender` codes
  are unchanged.
* Corrected the column names of `chapter_14_exercise_10` (and its alias
  `C14E10`). The data are the Kosslyn grids-versus-brackets by left-versus-right
  hemisphere reaction times (the same data as `chapter_12_exercise_9`), but the
  columns had been mislabeled `Angle0`, `Angle4`, `Angle8`, `Group` (copied from
  the split-plot angle example); they are now `GridLeft`, `GridRight`,
  `BraceLeft`, `BraceRight`. The values are unchanged.
* Renamed the second cognitive-measure column of `chapter_15_exercise_19`
  (and its alias `C15E19`) from `Cognitive73` to `Cognitive72`. The three
  columns record ability at ages 70, 72, and 74 (as the companion
  `chapter_15_exercise_19_univariate` records with `Age` = 70/72/74), so the
  middle column's name was corrected to match; the data values are unchanged.
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
* The `chapter_7_table_9` examples now show how its six additional observations
  combine with `chapter_7_table_5` to reproduce the cell and marginal means of
  Table 7.10.
* Gave the `Feedback` and `Drug` variables of `chapter_7_table_5` and
  `chapter_7_table_9` informative level labels (Feedback: 1 = biofeedback
  present, 2 = absent; Drug: 1 = X, 2 = Y, 3 = Z), matching the labels used in
  the book's Table 7.10.
* Every table that was renumbered, corrected, removed, or added for the 4th
  edition now carries a `Note` on its help page identifying the change (and,
  for a renumbered or reused name, the corresponding 3rd-edition name), so
  readers coming from the 3rd edition are not misled by a shifted or reused
  table number.
* Made the help text self-contained by removing references to specific
  statistical software (for example, notes that an analysis had been carried
  out in a particular package, or that a procedure was unavailable in one);
  the surviving prose describes the analyses in tool-neutral, model-comparison
  terms so the documentation stands on its own.

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
* On attach, the package prints a short startup message noting that version 2.x
  maps to the 4th edition (2027), pointing to `news(package = "AMCP")` for the
  list of changed tables, and directing 3rd-edition (2018) users to the archived
  `remotes::install_version("AMCP", "1.0.2")`.
* Added the maintainer's web site (<https://kenkelley.org/>) and the book
  companion site to the package `URL` field.
