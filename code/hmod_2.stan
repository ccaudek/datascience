
  data {
    int<lower=0> J; // # schools
    array[J] real y; // estimated treatment
    array[J] real<lower=0> sigma; // std err of effect
  }
  parameters {
    real theta; // pooled school effect
  }
  model {
    y ~ normal(theta, sigma);
  }

