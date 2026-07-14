#' A Model Comparison Perspective (AMCP)
#'
#' AMCP contains all of the data sets used in Maxwell, Delaney, & Kelley's (2026) \emph{Designing experiments and analyzing data: A model comparison perspective} (4th edition). Information about the book is available at its companion website, \url{https://designingexperiments.com}.
#'
#' Beginning with AMCP version 2.0, the package is tailored to the \strong{4th edition} of the book. If you want the data as distributed with the \strong{3rd edition} (Maxwell, Delaney, & Kelley, 2018), install the archived version (1.0.2) from CRAN, for example with \code{remotes::install_version("AMCP", version = "1.0.2")}.
#'
#' The general strategy is to have chapter data (e.g., from numeric examples) denoted by the chapter and table number,
#' such as \code{chapter_1_table_1} (for Table 1 from Chapter 1). Alternatively, a chapter and table can be accessed by capital "C"
#' followed by the chapter number and capital "T" followed by the table number, as in \code{C1T1} (for Table 1 from Chapter 1).
#'
#' For the exercises at the end of the chapter, the general strategy is to denote the data sets as \code{chapter_1_exercise_18} (for Exercise 18 from Chapter 1).
#' Also, an uppercase "C" and "E" can be used, as in \code{Chapter_1_Exercise_18}. Alternatively, the data from an exercise can be accessed by capital "C"
#' followed by the chapter number and capital "E" followed by the exercise number, as in \code{C1E18} (for Exercise 18 from Chapter 1).
#'
#' For a data set of interest to be loaded into the workspace, it must be loaded using the \code{data()} function as: \code{data(chapter_1_table_1)}.
#'
#' There are a few "one-off" naming conventions for non-standard data, such as raw data to produce the output shown in the book (e.g., \code{data(chapter_3_table_7_raw)}),
#' for the data from the Chapter 9 extension used in Exercise 1 (e.g., \code{data("chapter_9_extension_exercise_1")} or \code{data("C9ExtE1")}), data for the tutorial (e.g., \code{data(tutorial_1_table_1)} or \code{data(T1T1)}),
#' or the Chapter 15 Exercise 18 data in the "univariate" format (long, not wide; e.g., \code{data("chapter_15_exercise_18_univariate")} or \code{data(C15E18U)}).
#'
#' A list of the available data sets from AMCP can be obtained with the following code: \code{data(package="AMCP")}
#'
#' Note that, for many data sets the coding for factors is numeric. Correspondingly, those variables may need to be identified as factors (e.g., \code{C16E9$Room <- as.factor(C16E9$Room)}). Further,
#' the data sets are not always in the most convenient form for analysis, as they are generally entered to match the style in the book. Thus, for some analyses the data may benefit from being parsed, wrangled, or tidied.
#' See \code{vignette("factors-and-coding", package = "AMCP")} for recipes that add factor labels without changing the canonical data, and a worked example showing that relabeling reproduces the book's results.
#'
#' We recommend the \strong{DMAR} package as the companion for carrying out the book's analyses; install it with \code{install.packages("DMAR")}. The book itself illustrates these analyses using the \strong{MBESS} package, which may be used as well.
#'
#' Note that \url{https://designingexperiments.com/computing/} shows R code (via R Markdown) for implementing many of the analyses in the book, by chapter.
#'
#' @references Maxwell, S. E., Delaney, H. D., & Kelley, K. (2026). \emph{Designing experiments and analyzing data:
#' {A} model comparison perspective} (4th ed.). New York, NY: Routledge.
#'
#' See the web page that accompanies the book here: \url{https://designingexperiments.com}.
#'
#' For suggested updates, please email Ken Kelley (\email{kkelley@nd.edu}); see also \url{https://kenkelley.org}.
#' @author Ken Kelley \email{kkelley@nd.edu}
#'
"_PACKAGE"


# Startup message: flag the edition mapping so readers of the 3rd edition are
# not misled by a table number that changed for the 4th. Short and suppressible
# (packageStartupMessage); the per-table Notes and NEWS carry the detail.
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "AMCP ", utils::packageVersion(pkgname),
    " maps to the 4th edition (2026) of Maxwell, Delaney, &\n",
    "Kelley, \"Designing Experiments and Analyzing Data\" (Routledge). Some\n",
    "tables were renumbered or removed from the 3rd edition (2018); see the\n",
    "help-page Notes and news(package = \"AMCP\").\n",
    "\n",
    "If you are using the 3rd edition (2018), install the last 1.x release:\n",
    "    remotes::install_version(\"AMCP\", \"1.0.2\")"
  )
}
