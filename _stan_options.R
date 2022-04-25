# Stan options

suppressPackageStartupMessages({
  library("cmdstanr")
  library("rstan")
  library("posterior")
  library("loo")
})

rstan_options(auto_write = TRUE) # avoid recompilation of models
# Sys.setenv(LOCAL_CPPFLAGS = "-march=native") # improve execution time
