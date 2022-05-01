
  data {
    int<lower=1> N;
    vector[N] y;
  }
  parameters {
    real mu;
    real<lower=0> tau;
  }
  model {
    mu ~ normal(0, 5);
    tau ~ normal(0, 5);
    y ~ normal(mu, tau);
  }

