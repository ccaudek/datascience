# You  must run first 38_modello_binomiale.Rmd!
# Once the object mod has been created, the following
# instructions can be run.

fit$summary(c("theta"))

stanfit <- rstan::read_stan_csv(fit$output_files())

theta_draws <- as.matrix(stanfit, pars = "theta")

mcmc_areas(theta_draws, prob = 0.95) # color 95% interval

y_rep <- as.matrix(stanfit, pars = "y_rep")
dim(y_rep)

ppc_hist(data_list$y, y_rep[1:8, ], binwidth = 1)

ppc_dens_overlay(data_list$y, y_rep[1:50, ])

ppc_stat(data_list$y, y_rep, stat = "mean")

ppc_stat_2d(data_list$y, y_rep, stat = c("mean", "sd"))

ppc_error_hist(data_list$y, y_rep[1:4, ], binwidth = 1) + 
  xlim(-2.5, 2.5)


(loo1 <- loo(stanfit))

