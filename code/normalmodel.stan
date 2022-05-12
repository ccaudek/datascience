
data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  mu ~ normal(0.0, 2.0);
  sigma ~ cauchy(0, 5.0);
  y ~ normal(mu, sigma);
}

