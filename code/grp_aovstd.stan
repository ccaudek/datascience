
// Comparison of k groups with common variance (ANOVA)
data {
  int<lower=0> N; // number of observations
  int<lower=0> K; // number of groups
  array[N] int<lower=1, upper=K> x; // discrete group indicators
  vector[N] y; // real valued observations
}
transformed data {
  vector[N] y_std;
  y_std = (y - mean(y)) / sd(y);
}
parameters {
  vector[K] mu_std; // group means
  real<lower=0> sigma_std; // common standard deviation 
  real<lower=1> nu;
}
model {
  mu_std ~ normal(0, 2);
  sigma_std ~ normal(0, 2);
  nu ~ gamma(2, 0.1); // Juárez and Steel(2010)
  y_std ~ student_t(nu, mu_std[x], sigma_std);
}
generated quantities {
  vector[K] mu;
  real<lower=0> sigma;
  for (i in 1 : K) {
    mu[i] = mu_std[i] * sd(y) + mean(y);
  }
  sigma = sd(y) * sigma_std;
}

