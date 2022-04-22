
data {
 int <lower = 1> N; // Total number of trials
 vector[N] y; // Score in each trial
 real mean_y;
 real <lower = 0> sd_y;
}

parameters {
 real mu; 
 real <lower = 0> sigma;  
}

transformed parameters {
}

model {
  mu ~ normal(30, 15);
  sigma ~ cauchy(7, 5);
  // Likelihood:
  y ~ normal(mu, sigma); 
}

generated quantities { // The posterior predictive distribution
  real y_rep[N];
  for (n in 1:N) {
    y_rep[n] = normal_rng(mu, sigma);
  }
}

