
data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real alpha;
  real<lower=0> sigma;
}
transformed parameters {
  vector[N] mu;
  mu = alpha;
}
model {
  // priors
  alpha ~ normal(25, 10);
  sigma ~ cauchy(0, 10);
  // likelihood
  for (n in 1:N)
    y[n] ~ normal(alpha, sigma);
}
generated quantities {
  vector[N] y_rep;
  for (n in 1:N) {
    y_rep[n] = normal_rng(mu[n], sigma);
  }
}

