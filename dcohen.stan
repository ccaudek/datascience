
data {
  int<lower=0> N;
  vector[N] y;
  vector[N] x;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  // priors
  alpha ~ normal(-2.6, 5.3);
  beta ~ normal(0, 1.6);
  sigma ~ cauchy(0, 9.7);
  // likelihood
    y ~ normal(alpha + beta * x, sigma);
}
generated quantities {
  real cohen_d;
  cohen_d = beta / sigma;
}

