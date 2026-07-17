## Submission summary

AMCP 2.0.0 is a major-version update of this data-only package. It
retargets the bundled data sets to the 4th edition (2027) of the
accompanying textbook (Maxwell, Delaney, and Kelley, *Designing
Experiments and Analyzing Data: A Model Comparison Perspective*,
Routledge). The previous CRAN release, 1.0.2, corresponds to the 3rd
edition and remains available from the archive for readers of that
edition.

There are no exported functions; the package ships data only.

## Test environments

* local macOS, R 4.5.2 (2025-10-31), `R CMD check --as-cran`
* (planned before submission) win-builder (devel and release),
  mac-builder, and R-hub

## R CMD check results

0 errors | 0 warnings | 1 note

The single NOTE is environment-specific and concerns HTML manual
validation:

    checking HTML version of manual ... NOTE
    Skipping checking HTML validation: 'tidy' doesn't look like recent
    enough HTML Tidy.

This is caused by an outdated 'HTML Tidy' on the local machine and does
not occur on CRAN's check infrastructure. No other NOTEs, WARNINGs, or
ERRORs are produced. The package's `testthat` suite and the single
vignette build cleanly.

## Reverse dependencies

This is a data-only package with no exported functions and, to our
knowledge, no reverse dependencies to check.
