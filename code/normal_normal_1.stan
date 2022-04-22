
data {
  int<lower=0> N;
  real<lower=0> sigma;
  vector[N] y;
}
parameters {
  real mu;
}
model {
  mu ~ normal(25, 2);
  y ~ normal(mu, sigma);
}

