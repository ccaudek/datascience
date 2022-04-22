
data {
 int <lower = 1> N; // Total number of trials
 vector[N] y; // Score in each trial
 real mean_y;
 real <lower = 0> sd_y;
}

parameters {
 real mu_raw;
 real <lower = 0> sigma_raw;
}

transformed parameters {
  real mu;
  real <lower = 0> sigma;

  mu = mean_y + sd_y * mu_raw;
  sigma  = sd_y * sigma_raw;
 }

model {
  mu_raw ~ normal(0, 2.5);
  sigma_raw ~ cauchy(0, 2.5);
  // Likelihood:
  y ~ normal(mu, sigma);
}

generated quantities { // The posterior predictive distribution
  real y_rep[N];
  for (n in 1:N) {
    y_rep[n] = normal_rng(mu, sigma);
  }
}

