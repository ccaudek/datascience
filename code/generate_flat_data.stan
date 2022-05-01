
  data {
    int<lower=1> N;
    real mu; 
    real<lower=0> tau; 
  }
  generated quantities {
    vector[N] y;
    
    for (n in 1 : N) {
      y[n] = normal_rng(mu, tau);
    }
  }

