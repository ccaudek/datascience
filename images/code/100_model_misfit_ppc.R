# Script name: 100_model_misfit_ppc.R
# Project: psicometria
# Script purpose: illustrate posterior predictive checks
# @author: Corrado Caudek <corrado.caudek@unifi.it>
# Date Created: Wed Aug 18 09:06:54 2021
# Last Modified Date: Wed Aug 18 09:06:54 2021
#
# Notes: 
#   Recovered from:
#   http://avehtari.github.io/BDA_R_demos/demos_rstan/ppc/poisson-ppc.html#

library("rstan")
library("ggplot2")
library("bayesplot")
theme_set(bayesplot::theme_default(base_family = "sans"))
library(loo)

source("demos_rstan/ppc", "count-data.R")
print(N)

# 0 3 5 0 4 7 4 2 3 6 7 0 0 3 7 5 5 0 4 0 4 4 6 3 7 5 3 0 0 2 0 1 0 1 5 4 4 2 3 6 4 5 0 7 7 4 4 4 0 6 1 5 6 5 6 7 3 6 2 3 0 2 0 6 6 0 3 4 4 5 5 0 5 7 5 5 6 4 2 3 4 6 4 6 6 4 0 6 5 5 7 0 1 6 7 0 5 0 0 5 6 5 1 0 7 1 2 6 5 4 0 4 0 4 4 6 3 0 0 3 3 4 2 5 3 4 3 2 5 2 4 4 0 2 7 5 7 5 5 7 7 0 4 6 0 4 6 7 4 0 4 1 5 0 3 5 7 6 0 5 5 6 7 6 7 3 4 3 7 7 2 5 4 5 5 0 6 2 4 5 4 0 0 5 5 7 7 0 3 0 3 3 6 1 4 2 0 4 7 5 5 0 3 7 0 6 6 4 1 6 7 6 0 3 6 4 7 0 5 5 4 0 0 2 4 6 0 5 0 2 7 2 7 5 4 6 2 4 0 4 0 0 3 5 4 3 5 5 7 7 0 6 4 5 1 5 3 5 5 5 0 2 7 6 2 3 2 5 4 7 6 7 3 3 4 4 6 4 6 7 1 5 6 3 3 6 3 4 0 7 0 3 6 5 0 0 0 5 4 4 0 4 7 5 5 3 3 0 0 5 4 0 7 6 0 6 2 0 6 1 0 4 0 4 3 0 4 5 5 7 6 6 5 4 7 0 6 4 7 7 5 0 1 4 7 6 4 5 4 7 2 5 2 6 3 2 7 4 3 4 6 6 6 6 7 1 0 0 7 7 4 2 4 5 5 7 4 1 7 6 5 6 5 4 0 0 7 0 0 5 6 6 3 6 0 0 0 4 4 3 0 7 5 4 2 7 0 4 0 0 2 4 5 0 4 2 5 2 0 6 6 3 6 0 2 5 0 0 0 6 0 0 6 5 4 6 4 5 5 4 0 3 4 3 3 5 3 4 5 7 0 0 1 4 6 3 5 7 6 6 5 0 5 4 0 0 2 6 0 6 0 4 5 6 3 4 2 3 4 0 5 0 0 0 0 3 4 7 6 7 7 3 4 4 7 4 5 2 5 6
y <- c(0L, 3L, 5L, 0L, 4L, 7L, 4L, 2L, 3L, 6L, 7L, 0L, 0L, 3L, 7L, 5L, 5L, 0L, 4L, 0L, 4L, 4L, 6L, 3L, 7L, 5L, 3L, 0L, 0L, 2L, 0L, 1L, 0L, 1L, 5L, 4L, 4L, 2L, 3L, 6L, 4L, 5L, 0L, 7L, 7L, 4L, 4L, 4L, 0L, 6L, 1L, 5L, 6L, 5L, 6L, 7L, 3L, 6L, 2L, 3L, 0L, 2L, 0L, 6L, 6L, 0L, 3L, 4L, 4L, 5L, 5L, 0L, 5L, 7L, 5L, 5L, 6L, 4L, 2L, 3L, 4L, 6L, 4L, 6L, 6L, 4L, 0L, 6L, 5L, 5L, 7L, 0L, 1L, 6L, 7L, 0L, 5L, 0L, 0L, 5L, 6L, 5L, 1L, 0L, 7L, 1L, 2L, 6L, 5L, 4L, 0L, 4L, 0L, 4L, 4L, 6L, 3L, 0L, 0L, 3L, 3L, 4L, 2L, 5L, 3L, 4L, 3L, 2L, 5L, 2L, 4L, 4L, 0L, 2L, 7L, 5L, 7L, 5L, 5L, 7L, 7L, 0L, 4L, 6L, 0L, 4L, 6L, 7L, 4L, 0L, 4L, 1L, 5L, 0L, 3L, 5L, 7L, 6L, 0L, 5L, 5L, 6L, 7L, 6L, 7L, 3L, 4L, 3L, 7L, 7L, 2L, 5L, 4L, 5L, 5L, 0L, 6L, 2L, 4L, 5L, 4L, 0L, 0L, 5L, 5L, 7L, 7L, 0L, 3L, 0L, 3L, 3L, 6L, 1L, 4L, 2L, 0L, 4L, 7L, 5L, 5L, 0L, 3L, 7L, 0L, 6L, 6L, 4L, 1L, 6L, 7L, 6L, 0L, 3L, 6L, 4L, 7L, 0L, 5L, 5L, 4L, 0L, 0L, 2L, 4L, 6L, 0L, 5L, 0L, 2L, 7L, 2L, 7L, 5L, 4L, 6L, 2L, 4L, 0L, 4L, 0L, 0L, 3L, 5L, 4L, 3L, 5L, 5L, 7L, 7L, 0L, 6L, 4L, 5L, 1L, 5L, 3L, 5L, 5L, 5L, 0L, 2L, 7L, 6L, 2L, 3L, 2L, 5L, 4L, 7L, 6L, 7L, 3L, 3L, 4L, 4L, 6L, 4L, 6L, 7L, 1L, 5L, 6L, 3L, 3L, 6L, 3L, 4L, 0L, 7L, 0L, 3L, 6L, 5L, 0L, 0L, 0L, 5L, 4L, 4L, 0L, 4L, 7L, 5L, 5L, 3L, 3L, 0L, 0L, 5L, 4L, 0L, 7L, 6L, 0L, 6L, 2L, 0L, 6L, 1L, 0L, 4L, 0L, 4L, 3L, 0L, 4L, 5L, 5L, 7L, 6L, 6L, 5L, 4L, 7L, 0L, 6L, 4L, 7L, 7L, 5L, 0L, 1L, 4L, 7L, 6L, 4L, 5L, 4L, 7L, 2L, 5L, 2L, 6L, 3L, 2L, 7L, 4L, 3L, 4L, 6L, 6L, 6L, 6L, 7L, 1L, 0L, 0L, 7L, 7L, 4L, 2L, 4L, 5L, 5L, 7L, 4L, 1L, 7L, 6L, 5L, 6L, 5L, 4L, 0L, 0L, 7L, 0L, 0L, 5L, 6L, 6L, 3L, 6L, 0L, 0L, 0L, 4L, 4L, 3L, 0L, 7L, 5L, 4L, 2L, 7L, 0L, 4L, 0L, 0L, 2L, 4L, 5L, 0L, 4L, 2L, 5L, 2L, 0L, 6L, 6L, 3L, 6L, 0L, 2L, 5L, 0L, 0L, 0L, 6L, 0L, 0L, 6L, 5L, 4L, 6L, 4L, 5L, 5L, 4L, 0L, 3L, 4L, 3L, 3L, 5L, 3L, 4L, 5L, 7L, 0L, 0L, 1L, 4L, 6L, 3L, 5L, 7L, 6L, 6L, 5L, 0L, 5L, 4L, 0L, 0L, 2L, 6L, 0L, 6L, 0L, 4L, 5L, 6L, 3L, 4L, 2L, 3L, 4L, 0L, 5L, 0L, 0L, 0L, 0L, 3L, 4L, 7L, 6L, 7L, 7L, 3L, 4L, 4L, 7L, 4L, 5L, 2L, 5L, 6L)

N <- length(y)

qplot(y)

x <- rpois(N, mean(y))
qplot(x)

plotdata <- data.frame(
  value = c(y, x), 
  variable = rep(c("Our data", "Poisson data"), each = N)
)
ggplot(plotdata, aes(x = value, color = variable)) + 
  geom_freqpoly(binwidth = 0.5) +
  scale_x_continuous(name = "", breaks = 0:max(x,y)) +
  scale_color_manual(name = "", values = c("gray30", "purple"))

code_poisson <- '
data {
  int<lower=1> N;
  int<lower=0> y[N];
}
parameters {
  real<lower=0> lambda;
}
model {
  lambda ~ exponential(0.2);
  y ~ poisson(lambda);
}
generated quantities {
  real log_lik[N];
  int y_rep[N];
  for (n in 1:N) {
    y_rep[n] = poisson_rng(lambda);
    log_lik[n] = poisson_lpmf(y[n] | lambda);
    }
}
'

mod <- stan_model(model_code = code_poisson, verbose = TRUE)
fit <- sampling(mod, data = c("y", "N"))

print(fit, pars = "lambda")
mean(y)

y_rep <- as.matrix(fit, pars = "y_rep")
dim(y_rep) 

color_scheme_set("brightblue") # check out ?bayesplot::color_scheme_set
lambda_draws <- as.matrix(fit, pars = "lambda")
mcmc_areas(lambda_draws, prob = 0.8) # color 80% interval

ppc_hist(y, y_rep[1:8, ], binwidth = 1)

ppc_dens_overlay(y, y_rep[1:50, ])

prop_zero <- function(x) mean(x == 0)
print(prop_zero(y))

ppc_stat(y, y_rep, stat = "prop_zero")

ppc_stat_2d(y, y_rep, stat = c("mean", "sd"))

ppc_error_hist(y, y_rep[1:4, ], binwidth = 1) + xlim(-15, 15)


code_poisson_hurdle <- '
/* Poisson "hurdle" model (also with upper truncation)
 * 
 * Note: In this example, y is zero with probability theta and
 * y is modeled as a truncated poisson if greater than zero.
 */
 
data {
  int<lower=1> N;
  int<lower=0> y[N];
}
transformed data {
  int U = max(y);  // upper truncation point
}
parameters {
  real<lower=0,upper=1> theta; // Pr(y = 0)
  real<lower=0> lambda; // Poisson rate parameter (if y > 0)
}
model {
  lambda ~ exponential(0.2);
  
  for (n in 1:N) {
    if (y[n] == 0) {
      target += log(theta);  // log(Pr(y = 0))
    } else {
      target += log1m(theta);  // log(Pr(y > 0))
      y[n] ~ poisson(lambda) T[1,U];  // truncated poisson
    }
  }
}
generated quantities {
  real log_lik[N];
  int y_rep[N];
  for (n in 1:N) {
    if (bernoulli_rng(theta)) {
      y_rep[n] = 0;
    } else {
      int w;  // temporary variable
      w = poisson_rng(lambda); 
      while (w == 0 || w > U)
        w = poisson_rng(lambda);
        
      y_rep[n] = w;
    }
    if (y[n] == 0) {
      log_lik[n] = log(theta);
    } else {
      log_lik[n] = log1m(theta)
    + poisson_lpmf(y[n] | lambda)
    - log_diff_exp(poisson_lcdf(U | lambda),
                       poisson_lcdf(0 | lambda));
    }
  }
}
'

mod2 <- stan_model(model_code = code_poisson_hurdle, verbose = TRUE)
fit2 <- sampling(mod, data = c("y", "N"))

print(fit2, pars = c("lambda", "theta"))


lambda_draws2 <- as.matrix(fit2, pars = "lambda")
lambdas <- cbind(lambda_fit1 = lambda_draws[, 1],
                 lambda_fit2 = lambda_draws2[, 1])
mcmc_areas(lambdas, prob = 0.8) # color 80% interval

y_rep2 <- as.matrix(fit2, pars = "y_rep")
ppc_hist(y, y_rep2[1:8, ], binwidth = 1)

ppc_dens_overlay(y, y_rep2[1:50, ])

ppc_stat(y, y_rep2, stat = "prop_zero")

ppc_stat_2d(y, y_rep2, stat = c("mean", "sd"))

ppc_error_hist(y, y_rep2[sample(nrow(y_rep2), 4), ], binwidth = 1)

(loo1 <- loo(fit))
(loo2 <- loo(fit2))
loo_compare(loo1, loo2)
