
  data {
     int<lower=0> J;          // # schools
     real y[J];               // estimated treatment
     real<lower=0> sigma[J];  // std err of effect
     real<lower=0> tau;       // variance between schools
  }
  parameters {
    real theta[J]; // school effect
    real mu;       // mean for schools
  } 
  model {
    mu ~ normal(0, 15);
    theta ~ normal(mu, tau);
    y ~ normal(theta, sigma);
  }

