
data {
  int<lower=0> N;
  int<lower=0, upper=1> y[N];
}
parameters {
  real<lower=0, upper=1> theta;
}
model {
  theta ~ beta(2, 2);
  y ~ bernoulli(theta);
  // the notation using ~ is syntactic sugar for
  //  target += beta_lpdf(theta | 1, 1);   // lpdf for continuous theta
  //  target += bernoulli_lpmf(y | theta); // lpmf for discrete y
  // target is the log density to be sampled
  //
  // y is an array of integers and
  //  y ~ bernoulli(theta);
  // is equivalent to
  //  for (i in 1:N) {
  //    y[i] ~ bernoulli(theta);
  //  }
  // which is equivalent to
  //  for (i in 1:N) {
  //    target += bernoulli_lpmf(y[i] | theta);
  //  }
}
generated quantities {
  int y_rep[N];
  real log_lik[N];
  for (n in 1:N) {
    y_rep[n] = bernoulli_rng(theta);
    log_lik[n] = bernoulli_lpmf(y[n] | theta);
  }
}

