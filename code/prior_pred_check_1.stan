
data {
  int<lower=0> N;
  vector[N] x;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(0, 1);
  beta ~ normal(0, 1);
  sigma ~ normal(0, 1);
}
generated quantities {
  vector[N] y_rep;
  for (i in 1 : N) {
    y_rep[i] = normal_rng(alpha + beta * x[i], sigma);
  }
}

