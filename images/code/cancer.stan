
data {
  int r[2];
  int n[2];
  // param for beta prior on p
  vector[2] p_a;
  vector[2] p_b;
}
parameters {
  vector[2] p;
}
model {
  p ~ beta(p_a, p_b);
  r ~ binomial(n, p);
}

