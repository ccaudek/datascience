
  // Comparison of k groups with common variance (ANOVA)
  data {
    int<lower=0> N; // number of observations
    int<lower=0> K; // number of groups
    array[N] int<lower=1, upper=K> x; // discrete group indicators
    vector[N] y; // real valued observations
  }
  parameters {
    vector[K] mu; // group means
    real<lower=0> sigma; // common standard deviation 
    real<lower=1> nu;
  }
  model {
    mu ~ normal(0, 2); // weakly informative prior
    sigma ~ normal(0, 1); // weakly informative prior
    nu ~ gamma(2, 0.1); // Juárez and Steel(2010)
    y ~ student_t(nu, mu[x], sigma); // likelihood
  }

