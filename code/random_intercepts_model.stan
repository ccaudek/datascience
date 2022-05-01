
  data {
    int<lower=1> N; //number of data points
    array[N] real rt; //reading time
    array[N] real<lower=-0.5, upper=0.5> so; //predictor
    int<lower=1> J; //number of subjects
    int<lower=1> K; //number of items
    array[N] int<lower=1, upper=J> subj; //subject id
    array[N] int<lower=1, upper=K> item; //item id
  }
  parameters {
    vector[2] beta; //fixed intercept and slope
    vector[J] u; //subject intercepts
    vector[K] w; //item intercepts
    real<lower=0> sigma_e; //error sd
    real<lower=0> sigma_u; //subj sd
    real<lower=0> sigma_w; //item sd
  }
  model {
    real mu;
    //priors
    u ~ normal(0, sigma_u); //subj random effects
    w ~ normal(0, sigma_w); //item random effects
    // likelihood
    for (i in 1 : N) {
      mu = beta[1] + u[subj[i]] + w[item[i]] + beta[2] * so[i];
      rt[i] ~ lognormal(mu, sigma_e);
    }
  }

