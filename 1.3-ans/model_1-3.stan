data {
  int N;
  int D;
  int L;
  matrix[N, D] observations;
  matrix[N, L] features;
}

parameters {
  vector[L] weights;
  vector<lower=0>[N] sigma;
  real sigma_mu;
  real sigma_sigma;
}

transformed parameters {
  vector[N] mu;
  mu = features * weights;
}

model {
  for (n in 1:N) {
    observations[n] ~ normal(mu[n], sigma[n]);
  }
  weights ~ normal(0, 100);
  sigma ~ normal(sigma_mu, sigma_sigma);
  sigma_mu ~ normal(0, 100);
  sigma_sigma ~ normal(0, 100);
}