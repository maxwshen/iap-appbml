data {
  int N;
  int D;
  vector[N] observations;
  matrix[N, D]features;
}

parameters {
  vector[D] weights;
  real<lower=0> sigma;
}

model {
  observations ~ normal(features * weights, sigma);
  weights ~ normal(0, 100);
  sigma ~ normal(0, 100);
}