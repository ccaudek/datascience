
data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
  real tau;
}
model {
  alpha ~ normal(0, 2);
  beta ~ normal(0, 2);
  sigma ~ normal(0, 2);
  tau ~ normal(0, 10);
  y ~ skew_normal(alpha + beta * x, sigma, tau);
}
generated quantities {
  vector[N] y_rep;
  for (i in 1 : N) {
    y_rep[i] = skew_normal_rng(alpha + beta * x[i], sigma, tau);
  }
}

