
data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real mu;
  real<lower=0> sigma;
  real<lower=0> nu;
}
model {
  mu ~ beta(2, 2);
  sigma ~ cauchy(0.0, 5.0);
  nu ~ gamma(2, 0.1);
  y ~ student_t(nu, mu, sigma);
}
generated quantities {
  vector[N] y_rep;
  for (i in 1 : N) {
    y_rep[i] = student_t_rng(nu, mu, sigma);
  }
}


