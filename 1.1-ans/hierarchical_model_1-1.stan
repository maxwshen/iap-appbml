data {
  int N;
  int D;
  matrix[N, D] observations;
}

parameters {
  real<lower=0> exponential_scale;
  real<lower=0> normal_mus[N];
  real<lower=0> normal_sigma;
}

model {
  for (n in 1:N) {
    observations[n] ~ normal(normal_mus[n], normal_sigma);
  }
  normal_mus ~ exponential(exponential_scale);
  exponential_scale ~ normal(0, 100);
  normal_sigma ~ normal(0, 100);
}