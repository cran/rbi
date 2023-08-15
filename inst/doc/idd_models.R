## ----setup, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(
  cache = TRUE, fig.path = "figure/introduction/",
  cache.path = "cache/introduction/", fig.cap = "", fig.align = "center",
  message = FALSE, warning = FALSE
)
suppressPackageStartupMessages(library("rbi"))

## ----deter_prev---------------------------------------------------------------
model_str <- readLines("bi/SIR_deter_prev.bi")
cat(paste(model_str, "\n"))
sir_model <- bi_model(lines = model_str)

## ----deter_inc----------------------------------------------------------------
model_str <- readLines("bi/SIR_deter.bi")
cat(paste(model_str, "\n"))
sir_model <- bi_model(lines = model_str)

## ----stoch_sde----------------------------------------------------------------
model_str <- readLines("bi/SIR_stoch_SDE.bi")
cat(paste(model_str, "\n"))
sir_model <- bi_model(lines = model_str)

## ----stoch_jump---------------------------------------------------------------
model_str <- readLines("bi/SIR_stoch_jump.bi")
cat(paste(model_str, "\n"))
sir_model <- bi_model(lines = model_str)

