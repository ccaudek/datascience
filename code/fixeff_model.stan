
  data {
    int<lower=1> N; //number of data points
    array[N] real rt; //reading time
    array[N] real<lower=-0.5, upper=0.5> so; //predictor
  }
  parameters {
    vector[2] beta; //fixed intercept and slope
    real<lower=0> sigma_e; //error sd
  }
  model {
    real mu;
    // likelihood
    beta[1] ~ normal(6, 1.5);
    beta[2] ~ normal(0, 1);
    sigma_e ~ cauchy(0, 1);
    for (i in 1 : N) {
      mu = beta[1] + beta[2] * so[i];
      rt[i] ~ lognormal(mu, sigma_e);
    }
  }

