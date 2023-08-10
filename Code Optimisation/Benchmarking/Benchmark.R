# Author: Gareth Burns
# Date: 09/08/2023
# Description: Benchmarking of 7 files which carry out the same Monte-Carlo
#   simulation but each contain sequentially added optimization.
# See also: CodeOptimisation.qmd describes each of the "sins".

# Load Libraries ----------------------------------------------------------
library(microbenchmark)


# User-Defined Variables --------------------------------------------------
# This variable is the number of simulations to carry out and passed
# into source functions below
sims <- seq_len(10)

results <-
  microbenchmark(
    "Benchmark" = source(file = "Code Optimisation/Benchmarking/BadCode.R"),
    "Sloth" = source(file = "Code Optimisation/Benchmarking/Sloth.R"),
    "Gluttony" = source("Code Optimisation/Benchmarking/Gluttony.R"),
    "Greed" = source("Code Optimisation/Benchmarking/Greed.R"),
    "Wrath" = source("Code Optimisation/Benchmarking/Wrath.R"),
    "Lust" = source("Code Optimisation/Benchmarking/Lust.R"),
    "Envy" = source("Code Optimisation/Benchmarking/Envy.R"),
    times = 25,
    setup = file.remove("results.csv")
  )


# This is a useful function to view the distribution of results
# ggplot2::autoplot(results)




