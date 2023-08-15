## ---- include = FALSE---------------------------------------------------------
NOT_CRAN <- interactive() || identical(tolower(Sys.getenv("NOT_CRAN")), "true") # nolint
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval = FALSE------------------------------------------------------------
#  install.packages("rbi")

## ---- eval = FALSE------------------------------------------------------------
#  remotes::install_github("sbfnk/rbi")

## ---- eval = FALSE------------------------------------------------------------
#  library("rbi")

## ---- echo = FALSE------------------------------------------------------------
suppressPackageStartupMessages(library("rbi"))

## -----------------------------------------------------------------------------
model_file <- system.file(package = "rbi", "SIR.bi")
sir_model <- bi_model(model_file) # load model

## -----------------------------------------------------------------------------
sir_model

## -----------------------------------------------------------------------------
sir_model[35:38]

## -----------------------------------------------------------------------------
get_block(sir_model, "parameter")

## -----------------------------------------------------------------------------
var_names(sir_model, type = "state")

## -----------------------------------------------------------------------------
det_sir_model <- fix(sir_model, n_transmission = 0, n_recovery = 0)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  set.seed(1001912)
#  sir_data <- generate_dataset(sir_model, end_time = 16 * 7, noutputs = 16)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  sir_data

## ---- eval = NOT_CRAN---------------------------------------------------------
#  dataset <- bi_read(sir_data)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  names(dataset)
#  dataset$p_R0
#  dataset$Incidence

## ---- eval = NOT_CRAN---------------------------------------------------------
#  plot(dataset$Incidence$time, dataset$Incidence$value)
#  lines(dataset$Incidence$time, dataset$Incidence$value)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  class(sir_data)

## -----------------------------------------------------------------------------
bi <- libbi(sir_model)

## -----------------------------------------------------------------------------
class(bi)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_prior <- sample(
#    bi, target = "prior", nsamples = 1000, end_time = 16 * 7, noutputs = 16
#  )

## ---- eval = FALSE------------------------------------------------------------
#  bi_prior <- sample(bi_prior)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_prior

## ---- eval = NOT_CRAN---------------------------------------------------------
#  str(bi_prior)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_prior$options

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_prior$output_file_name

## ---- eval = NOT_CRAN---------------------------------------------------------
#  prior <- bi_read(bi_prior$output_file_name)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  prior <- bi_read(bi_prior)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  str(prior)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi <- sample(bi_prior, target = "posterior", nparticles = 32, obs = sir_data)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  df <- data.frame(
#    time = c(0, 7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 112),
#    value = c(1, 6, 2, 26, 99, 57, 78, 57, 15, 9, 4, 1, 1, 1, 0, 2, 0)
#  )
#  bi_df <- sample(
#    bi_prior, target = "posterior", nparticles = 32, obs = list(Incidence = df)
#  )

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_contents(bi)
#  posterior <- bi_read(bi)
#  str(posterior)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  summary(bi)

## ---- eval = NOT_CRAN, results = "hide"---------------------------------------
#  summary(bi, type = "state")

## ---- eval = NOT_CRAN, results = "hide"---------------------------------------
#  extract_sample(bi, 314)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  library("coda")
#  traces <- mcmc(get_traces(bi))

## ---- eval = NOT_CRAN, fig.width = 8, fig.height = 8--------------------------
#  plot(traces)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_read(sir_data, type = "param")

## ---- eval = NOT_CRAN---------------------------------------------------------
#  pred_bi <- predict(
#    bi, start_time = 0, end_time = 20 * 7, output_every = 7,
#    with = c("transform-obs-to-state")
#  )

## ---- eval = NOT_CRAN---------------------------------------------------------
#  obs_bi <- sample_obs(bi)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  summary(obs_bi, type = "obs")
#  dataset$Incidence

## ---- eval = NOT_CRAN---------------------------------------------------------
#  bi_filtered <- filter(bi)

## ---- eval = NOT_CRAN---------------------------------------------------------
#  ps <- summary(pred_bi, type = "obs")
#  
#  library("ggplot2")
#  ggplot(ps, aes(x = time)) +
#    geom_line(aes(y = Median)) +
#    geom_ribbon(aes(ymin = `1st Qu.`, ymax = `3rd Qu.`), alpha = 0.5) +
#    geom_point(aes(y = value), dataset$Incidence, color = "darkred") +
#    ylab("cases")

## ---- eval = NOT_CRAN---------------------------------------------------------
#  os <- summary(obs_bi, type = "obs")
#  
#  ggplot(os, aes(x = time)) +
#    geom_line(aes(y = Median)) +
#    geom_ribbon(aes(ymin = `1st Qu.`, ymax = `3rd Qu.`), alpha = 0.5) +
#    geom_point(aes(y = value), dataset$Incidence, color = "darkred") +
#    ylab("cases")

## ---- eval = NOT_CRAN---------------------------------------------------------
#  save_libbi(bi, "bi.rds")
#  bi <- read_libbi("bi.rds")
#  bi

## ---- eval =  NOT_CRAN--------------------------------------------------------
#  pz_run_output <- bi_read(system.file(package = "rbi", "example_output.nc"))
#  pz_model_file <- system.file(package = "rbi", "PZ.bi")
#  pz_posterior <- attach_data(libbi(pz_model_file), "output", pz_run_output)
#  traces <- mcmc(get_traces(pz_posterior))
#  a <- 1 - rejectionRate(traces)
#  a

## ---- eval = FALSE------------------------------------------------------------
#  rewrite(sir_model)

