
  data {
    int<lower=0> J; // # schools
    array[J] real y; // estimated treatment
    array[J] real<lower=0> sigma; // std err of effect
    real<lower=0> tau; // variance between schools
  }
  parameters {
    array[J] real theta; // school effect
    real mu; // mean for schools
  }
  model {
    mu ~ normal(0, 15);
    theta ~ normal(mu, tau);
    y ~ normal(theta, sigma);
  }

