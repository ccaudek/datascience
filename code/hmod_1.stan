
  data {
    int<lower=0> J; // # schools
    array[J] real y; // estimated treatment
    array[J] real<lower=0> sigma; // std err of effect
  }
  parameters {
    array[J] real theta; // school effect
  }
  model {
    y ~ normal(theta, sigma);
  }

