
  data {
    int<lower=0> J; // # schools
    array[J] real y; // estimated treatment
    array[J] real<lower=0> sigma; // std err of effect
  }
  parameters {
    array[J] real theta; // school effect
    real mu; // mean for schools
    real<lower=0> tau; // variance between schools
  }
  model {
    mu ~ normal(0, 15);
    tau ~ cauchy(0, 30);
    theta ~ normal(mu, tau);
    y ~ normal(theta, sigma);
  }

