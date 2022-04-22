
 data {
  vector<lower = 0>[2] r;
  vector<lower = 1>[2] n;
}
parameters {
  vector<lower = 0, upper=1>[2] p;
}
model {
  p ~ beta(1, 1);
  for(i in 1:2) {
    r[i] ~ binomial(n[i], p[i]);
  }
    
}

