# ---------------------------------------------------------------------
# Canonical data-regeneration recipe for the AMCP package.
#
# This script rebuilds every .rda in data/ from the source CSVs that
# live on the book's companion website checkout
# (~/Dropbox/DE_and_AD_Website/Data/..., mirroring
# https://designingexperiments.com/data/). For each data set it reads
# the CSV under both the long and short names and calls
# usethis::use_data(long, SHORT, overwrite = TRUE), which writes the two
# .rda files the package ships.
#
# It is local-developer-only (absolute paths to Ken's website checkout)
# and never ships: data-raw/ is listed in .Rbuildignore. It was moved
# here verbatim from the former ~/Dropbox/R/AMCP_Preparation/ folder so
# the regeneration steps are version-controlled alongside the package.
#
# Companion verification scripts in this directory:
#   verify.R               doc/.rda consistency + copy-paste guard
#   build_catalog.R        regenerates datasets_catalog.csv
#   parse_documentation.R  parser used by the two scripts above
# ---------------------------------------------------------------------

# Load data from a location.

# install.packages("usethis")
library(usethis)

setwd("/Users/kkelley/Dropbox/R/AMCP/data")
# Data for in-chapter data sets, such as those used in numeric examples. The process followed here is to 
# read into R the raw data from the csv files. Then, the usethis::use_data() function saves the .rda file
# (needed for the package build) into the appropriate folder (see setwd()) where the package can then be built.
#######################################################################################################################################
# Chapter 1 Tables
chapter_1_table_1 <- C1T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter1/Tables/chapter_1_table_1.csv')
usethis::use_data(chapter_1_table_1, C1T1, overwrite=TRUE)

# Chapter 2
# None

# Chapter 3 Tables
chapter_3_table_1 <- C3T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Tables/chapter_3_table_1.csv')
chapter_3_table_3 <- C3T3 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Tables/chapter_3_table_3.csv')
chapter_3_table_7_raw <- C3T7R <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Tables/chapter_3_table_7_raw.csv')
chapter_3_table_9_raw <- C3T9R <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Tables/chapter_3_table_9_raw.csv')
usethis::use_data(chapter_3_table_1, C3T1, chapter_3_table_3, C3T3, chapter_3_table_7_raw, C3T7R, chapter_3_table_9_raw, C3T9R, overwrite=TRUE)

# Chapter 4 Tables
chapter_4_table_1 <- C4T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter4/Tables/chapter_4_table_1.csv')
chapter_4_table_7 <- C4T7 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter4/Tables/chapter_4_table_7.csv')
usethis::use_data(chapter_4_table_1, C4T1, chapter_4_table_7, C4T7, overwrite=TRUE)

# Chapter 5 Tables
chapter_5_table_4 <- C5T4 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter5/Tables/chapter_5_table_4.csv')
usethis::use_data(chapter_5_table_4, C5T4, overwrite=TRUE)

# Chapter 6 Tables
chapter_6_table_1 <- C6T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter6/Tables/chapter_6_table_1.csv')
usethis::use_data(chapter_6_table_1, C6T1, overwrite=TRUE)

# Chapter 7 Tables
chapter_7_table_1 <- C7T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Tables/chapter_7_table_1.csv')
chapter_7_table_5 <- C7T5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Tables/chapter_7_table_5.csv')
chapter_7_table_9 <- C7T9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Tables/chapter_7_table_9.csv')
chapter_7_table_11 <- C7T11 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Tables/chapter_7_table_11.csv')
chapter_7_table_15 <- C7T15 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Tables/chapter_7_table_15.csv')
chapter_7_table_23 <- C7T23 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Tables/chapter_7_table_23.csv')
usethis::use_data(chapter_7_table_1, C7T1, chapter_7_table_5, C7T5, chapter_7_table_9, C7T9, chapter_7_table_11, C7T11, chapter_7_table_15, C7T15, chapter_7_table_23, C7T23, overwrite=TRUE)

# Chapter 8 Tables
chapter_8_table_12 <- C8T12 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter8/Tables/chapter_8_table_12.csv')
usethis::use_data(chapter_8_table_12, C8T12, overwrite=TRUE)

# Chapter 9 Tables
chapter_9_table_1 <- C9T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Tables/chapter_9_table_1.csv')
chapter_9_table_7 <- C9T7 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Tables/chapter_9_table_7.csv')
chapter_9_table_11 <- C9T11 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Tables/chapter_9_table_11.csv')
chapter_9_extension_table_1 <- C9ExtT1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Tables/chapter_9_extension_table_1.csv')
chapter_9_extension_figures_4_and_5 <- C9ExtFigs4and5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Figures/chapter_9_extension_figures_4_and_5.csv')
usethis::use_data(chapter_9_table_1, C9T1, chapter_9_table_7, C9T7, chapter_9_table_11, C9T11, chapter_9_extension_table_1, C9ExtT1, chapter_9_extension_figures_4_and_5, C9ExtFigs4and5, overwrite=TRUE)

# Chapter 10 Tables
chapter_10_table_5 <- C10T5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter10/Tables/chapter_10_table_5.csv')
chapter_10_table_9 <- C10T9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter10/Tables/chapter_10_table_9.csv')
usethis::use_data(chapter_10_table_5, C10T5, chapter_10_table_9, C10T9, overwrite=TRUE)

# Chapter 11 Tables
chapter_11_table_1 <- C11T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Tables/chapter_11_table_1.csv')
chapter_11_table_4 <- C11T4 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Tables/chapter_11_table_4.csv')
chapter_11_table_5 <- C11T5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Tables/chapter_11_table_5.csv')
chapter_11_table_19 <- C11T19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Tables/chapter_11_table_19.csv')
chapter_11_table_20 <- C11T20 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Tables/chapter_11_table_20.csv')
usethis::use_data(chapter_11_table_1, C11T1, chapter_11_table_4, C11T4, chapter_11_table_5, C11T5, chapter_11_table_19, C11T19, chapter_11_table_20, C11T20, overwrite=TRUE)

# Chapter 12 Tables
chapter_12_table_1 <- C12T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Tables/chapter_12_table_1.csv')
chapter_12_table_7 <- C12T7 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Tables/chapter_12_table_7.csv')
chapter_12_table_9 <- C12T9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Tables/chapter_12_table_9.csv')
chapter_12_table_11 <- C12T11 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Tables/chapter_12_table_11.csv')
chapter_12_table_15 <- C12T15 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Tables/chapter_12_table_15.csv')
chapter_12_table_21 <- C12T21 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Tables/chapter_12_table_21.csv')
usethis::use_data(chapter_12_table_1, C12T1, chapter_12_table_7, C12T7, chapter_12_table_9, C12T9, chapter_12_table_11, C12T11, chapter_12_table_15, C12T15, chapter_12_table_21, C12T21, overwrite=TRUE)

# Chapter 13 Tables
chapter_13_table_1 <- C13T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Tables/chapter_13_table_1.csv')
chapter_13_table_2 <- C13T2 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Tables/chapter_13_table_2.csv')
chapter_13_table_6 <- C13T6 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Tables/chapter_13_table_6.csv')
chapter_13_table_12 <- C13T12 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Tables/chapter_13_table_12.csv')
chapter_13_table_14 <- C13T14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Tables/chapter_13_table_14.csv')
usethis::use_data(chapter_13_table_1, C13T1, chapter_13_table_2, C13T2, chapter_13_table_6, C13T6, chapter_13_table_12, C13T12, chapter_13_table_14, C13T14, overwrite=TRUE) 

# Chapter 14 Tables
chapter_14_table_1 <- C14T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Tables/chapter_14_table_1.csv')
chapter_14_table_3 <- C14T3 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Tables/chapter_14_table_3.csv')
chapter_14_table_4 <- C14T4 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Tables/chapter_14_table_4.csv')
chapter_14_table_5 <- C14T5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Tables/chapter_14_table_5.csv')
chapter_14_table_8 <- C14T8 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Tables/chapter_14_table_8.csv')
chapter_14_table_10 <- C14T10 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Tables/chapter_14_table_10.csv')
usethis::use_data(chapter_14_table_1, C14T1, chapter_14_table_3, C14T3, chapter_14_table_4, C14T4, chapter_14_table_5, C14T5, chapter_14_table_8, C14T8, chapter_14_table_10, C14T10, overwrite=TRUE) 

# Chapter 15 Tables
chapter_15_table_1 <- C15T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Tables/chapter_15_table_1.csv')
usethis::use_data(chapter_15_table_1, C15T1, overwrite=TRUE) 

# Chapter 16 Tables
chapter_16_table_1 <- C16T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter16/Tables/chapter_16_table_1.csv')
chapter_16_table_4 <- C16T4 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter16/Tables/chapter_16_table_4.csv')
usethis::use_data(chapter_16_table_1, C16T1, chapter_16_table_4, C16T4, overwrite=TRUE) 
#######################################################################################################################################


# End-of-chapter Exercises
#######################################################################################################################################
# Chapter 1
chapter_1_exercise_18 <- C1E18 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter1/Exercises/chapter_1_exercise_18.csv')
chapter_1_exercise_19 <- C1E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter1/Exercises/chapter_1_exercise_19.csv')
chapter_1_exercise_21 <- C1E21 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter1/Exercises/chapter_1_exercise_21.csv')
chapter_1_exercise_22 <- C1E22 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter1/Exercises/chapter_1_exercise_22.csv')
chapter_1_exercise_23 <- C1E23 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter1/Exercises/chapter_1_exercise_23.csv')
usethis::use_data(chapter_1_exercise_18, C1E18, chapter_1_exercise_19, C1E19, chapter_1_exercise_21, C1E21, chapter_1_exercise_22, C1E22, chapter_1_exercise_23, C1E23, overwrite=TRUE)

# Chapter 2
# None

# Chapter 3
chapter_3_exercise_9 <- C3E9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_9.csv')
chapter_3_exercise_10 <- C3E10 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_10.csv')
chapter_3_exercise_11 <- C3E11 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_11.csv')
chapter_3_exercise_19 <- C3E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_19.csv')
chapter_3_exercise_20 <- C3E20 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_20.csv')
chapter_3_exercise_21 <- C3E21 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_21.csv')
chapter_3_exercise_22 <- C3E22 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter3/Exercises/chapter_3_exercise_22.csv')
usethis::use_data(chapter_3_exercise_9, C3E9, chapter_3_exercise_10, C3E10, chapter_3_exercise_11, C3E11, chapter_3_exercise_19, C3E19, chapter_3_exercise_20, C3E20, chapter_3_exercise_21, C3E21, chapter_3_exercise_22, C3E22, overwrite=TRUE)

# Chapter 4
chapter_4_exercise_11 <- C4E11 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter4/Exercises/chapter_4_exercise_11.csv')
chapter_4_exercise_12 <- C4E12 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter4/Exercises/chapter_4_exercise_12.csv')
chapter_4_exercise_13 <- C4E13 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter4/Exercises/chapter_4_exercise_13.csv')
usethis::use_data(chapter_4_exercise_11, C4E11, chapter_4_exercise_12, C4E12, chapter_4_exercise_13, C4E13, overwrite=TRUE)

# Chapter 5
chapter_5_exercise_5 <- C5E5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter5/Exercises/chapter_5_exercise_5.csv')
chapter_5_exercise_10 <- C5E10 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter5/Exercises/chapter_5_exercise_10.csv')
chapter_5_exercise_16 <- C5E16 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter5/Exercises/chapter_5_exercise_16.csv')
usethis::use_data(chapter_5_exercise_5, C5E5, chapter_5_exercise_10, C5E10, chapter_5_exercise_16, C5E16, overwrite=TRUE)

# Chapter 6
chapter_6_exercise_10 <- C6E10 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter6/Exercises/chapter_6_exercise_10.csv')
chapter_6_exercise_14 <- C6E14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter6/Exercises/chapter_6_exercise_14.csv')
chapter_6_exercise_16 <- C6E16 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter6/Exercises/chapter_6_exercise_16.csv')
usethis::use_data(chapter_6_exercise_10, C6E10, chapter_6_exercise_14, C6E14, chapter_6_exercise_16, C6E16, overwrite=TRUE)

# Chapter 7
chapter_7_exercise_6 <- C7E6 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_6.csv')
chapter_7_exercise_9 <- C7E9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_9.csv')
chapter_7_exercise_12 <- C7E12 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_12.csv')
chapter_7_exercise_13 <- C7E13 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_13.csv')
chapter_7_exercise_14 <- C7E14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_14.csv')
chapter_7_exercise_15 <- C7E15 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_15.csv')
chapter_7_exercise_18 <- C7E18 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_18.csv')
chapter_7_exercise_19 <- C7E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_19.csv')
chapter_7_exercise_22 <- C7E22 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_22.csv')
chapter_7_exercise_23 <- C7E23 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_23.csv')
chapter_7_exercise_24 <- C7E24 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_24.csv')
chapter_7_exercise_25 <- C7E25 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter7/Exercises/chapter_7_exercise_25.csv')
usethis::use_data(chapter_7_exercise_6, C7E6, chapter_7_exercise_9, C7E9, chapter_7_exercise_12, C7E12, chapter_7_exercise_13, C7E13, chapter_7_exercise_14, C7E14, chapter_7_exercise_15, C7E15, chapter_7_exercise_18, C7E18, chapter_7_exercise_19, C7E19, chapter_7_exercise_22, C7E22, chapter_7_exercise_23, C7E23, chapter_7_exercise_24, C7E24, chapter_7_exercise_25, C7E25, overwrite=TRUE)

# Chapter 8
chapter_8_exercise_15 <- C8E15 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter8/Exercises/chapter_8_exercise_15.csv')
chapter_8_exercise_16 <- C8E16 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter8/Exercises/chapter_8_exercise_16.csv')
chapter_8_exercise_17 <- C8E17 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter8/Exercises/chapter_8_exercise_17.csv')
chapter_8_exercise_18 <- C8E18 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter8/Exercises/chapter_8_exercise_18.csv')
chapter_8_exercise_19 <- C8E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter8/Exercises/chapter_8_exercise_19.csv')
usethis::use_data(chapter_8_exercise_15, C8E15, chapter_8_exercise_16, C8E16, chapter_8_exercise_17, C8E17, chapter_8_exercise_18, C8E18, chapter_8_exercise_19, C8E19, overwrite=TRUE)

# Chapter 9
chapter_9_exercise_4 <- C9E4 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_exercise_4.csv')
chapter_9_exercise_14 <- C9E14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_exercise_14.csv')
chapter_9_exercise_15 <- C9E15 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_exercise_15.csv')
chapter_9_exercise_16 <- C9E16 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_exercise_16.csv')
chapter_9_extension_exercise_1 <- C9ExtE1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_extension_exercise_1.csv')
chapter_9_extension_exercise_2 <- C9ExtE2 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_extension_exercise_2.csv')
chapter_9_extension_exercise_3 <- C9ExtE3 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter9/Exercises/chapter_9_extension_exercise_3.csv')
usethis::use_data(chapter_9_exercise_4, C9E4, chapter_9_exercise_14, C9E14, chapter_9_exercise_15, C9E15, chapter_9_exercise_16, C9E16, chapter_9_extension_exercise_1, C9ExtE1, chapter_9_extension_exercise_2, C9ExtE2, chapter_9_extension_exercise_3, C9ExtE3, overwrite=TRUE)

# Chapter 10
chapter_10_exercise_7 <- C10E7 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter10/Exercises/chapter_10_exercise_7.csv')
chapter_10_exercise_9 <- C10E9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter10/Exercises/chapter_10_exercise_9.csv')
chapter_10_exercise_14 <- C10E14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter10/Exercises/chapter_10_exercise_14.csv')
usethis::use_data(chapter_10_exercise_7, C10E7, chapter_10_exercise_9, C10E9, chapter_10_exercise_14, C10E14, overwrite=TRUE)

# Chapter 11
chapter_11_exercise_3 <- C11E3 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_3.csv')
chapter_11_exercise_5 <- C11E5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_5.csv')
chapter_11_exercise_17 <- C11E17 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_17.csv')
chapter_11_exercise_18 <- C11E18 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_18.csv')
chapter_11_exercise_19 <- C11E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_19.csv')
chapter_11_exercise_21 <- C11E21 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_21.csv')
chapter_11_exercise_22 <- C11E22 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_22.csv')
chapter_11_exercise_23 <- C11E23 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_23.csv')
chapter_11_exercise_24 <- C11E24 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter11/Exercises/chapter_11_exercise_24.csv')
usethis::use_data(chapter_11_exercise_3, C11E3, chapter_11_exercise_5, C11E5, chapter_11_exercise_17, C11E17, chapter_11_exercise_18, C11E18, chapter_11_exercise_19, C11E19, chapter_11_exercise_21, C11E21, chapter_11_exercise_22, C11E22, chapter_11_exercise_23, C11E23, chapter_11_exercise_24, C11E24, overwrite=TRUE)

# Chapter 12
chapter_12_exercise_9 <- C12E9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Exercises/chapter_12_exercise_9.csv')
chapter_12_exercise_17 <- C12E17 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Exercises/chapter_12_exercise_17.csv')
chapter_12_exercise_18 <- C12E18 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Exercises/chapter_12_exercise_18.csv')
chapter_12_exercise_19 <- C12E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Exercises/chapter_12_exercise_19.csv')
chapter_12_exercise_21 <- C12E21 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter12/Exercises/chapter_12_exercise_21.csv')
usethis::use_data(chapter_12_exercise_9, C12E9, chapter_12_exercise_17, C12E17, chapter_12_exercise_18, C12E18, chapter_12_exercise_19, C12E19, chapter_12_exercise_21, C12E21, overwrite=TRUE)

# Chapter 13
chapter_13_exercise_7 <- C13E7 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_7.csv')
chapter_13_exercise_10 <- C13E10 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_10.csv')
chapter_13_exercise_13 <- C13E13 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_13.csv')
chapter_13_exercise_14 <- C13E14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_14.csv')
chapter_13_exercise_22 <- C13E22 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_22.csv')
chapter_13_exercise_23 <- C13E23 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_23.csv')
chapter_13_exercise_24 <- C13E24 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_24.csv')
chapter_13_exercise_25 <- C13E25 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter13/Exercises/chapter_13_exercise_25.csv')
usethis::use_data(chapter_13_exercise_7, C13E7, chapter_13_exercise_10, C13E10, chapter_13_exercise_13, C13E13, chapter_13_exercise_14, C13E14, chapter_13_exercise_22, C13E22, chapter_13_exercise_23, C13E23, chapter_13_exercise_24, C13E24, chapter_13_exercise_25, C13E25, overwrite=TRUE)

# Chapter 14
chapter_14_exercise_10 <- C14E10 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Exercises/chapter_14_exercise_10.csv')
chapter_14_exercise_14 <- C14E14 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Exercises/chapter_14_exercise_14.csv')
chapter_14_exercise_15 <- C14E15 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Exercises/chapter_14_exercise_15.csv')
chapter_14_exercise_21 <- C14E21 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Exercises/chapter_14_exercise_21.csv')
chapter_14_exercise_22 <- C14E22 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter14/Exercises/chapter_14_exercise_22.csv')
usethis::use_data(chapter_14_exercise_10, C14E10, chapter_14_exercise_14, C14E14, chapter_14_exercise_15, C14E15, chapter_14_exercise_21, C14E21, chapter_14_exercise_22, C14E22, overwrite=TRUE)

# Chapter 15
chapter_15_exercise_16 <- C15E16 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Exercises/chapter_15_exercise_16.csv')
chapter_15_exercise_17 <- C15E17 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Exercises/chapter_15_exercise_17.csv')
chapter_15_exercise_18 <- C15E18 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Exercises/chapter_15_exercise_18.csv')
chapter_15_exercise_19 <- C15E19 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Exercises/chapter_15_exercise_19.csv')
chapter_15_exercise_18_univariate <- C15E18U <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Exercises/chapter_15_exercise_18_univariate.csv')
chapter_15_exercise_19_univariate <- C15E19U <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter15/Exercises/chapter_15_exercise_19_univariate.csv')
usethis::use_data(chapter_15_exercise_16, C15E16, chapter_15_exercise_17, C15E17, chapter_15_exercise_18, C15E18, chapter_15_exercise_19, C15E19, chapter_15_exercise_18_univariate, C15E18U, chapter_15_exercise_19_univariate, C15E19U, overwrite=TRUE)

# Chapter 16
chapter_16_exercise_5 <- C16E5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter16/Exercises/chapter_16_exercise_5.csv')
chapter_16_exercise_7 <- C16E7 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter16/Exercises/chapter_16_exercise_7.csv')
chapter_16_exercise_9 <- C16E9 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Chapter16/Exercises/chapter_16_exercise_9.csv')
usethis::use_data(chapter_16_exercise_5, C16E5, chapter_16_exercise_7, C16E7, chapter_16_exercise_9, C16E9, overwrite=TRUE)
#######################################################################################################################################


# Tutorials
#######################################################################################################################################
tutorial_1_table_1 <- T1T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_1_table_1.csv')
tutorial_2_table_1 <- T2T1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_2_table_1.csv')
tutorial_2_table_2 <- T2T2 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_2_table_2.csv')
tutorial_3a_table_1 <- T3AT1 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_3a_table_1.csv')
tutorial_3a_table_2 <- T3AT2 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_3a_table_2.csv')
tutorial_3a_table_4 <- T3AT4 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_3a_table_4.csv')
tutorial_3a_table_5 <- T3AT5 <- read.csv('~/Dropbox/DE_and_AD_Website/Data/Tutorial/Tables/tutorial_3a_table_5.csv')
usethis::use_data(tutorial_1_table_1, T1T1, tutorial_2_table_1, T2T1, tutorial_2_table_2, T2T2, tutorial_3a_table_1, T3AT1, tutorial_3a_table_2, T3AT2, tutorial_3a_table_4, T3AT4, tutorial_3a_table_5, T3AT5, overwrite=TRUE)

#######################################################################################################################################