data {
  int N;
  int DIM;
  vector[DIM] obs[N];
  vector[DIM] f[N];
}

parameters {
  ordered[2] mu;  // solve identifiability issue
  real mu_a2;
  real mu_b2;
  real<lower=0> sigma_a;
  real<lower=0> sigma_b;
  vector[DIM] w;
}

transformed parameters {
  real<lower=0, upper=1> lambda[N];
  for (n in 1:N)
    lambda[n] = inv_logit(dot_product(f[n], w));
}

model {
  for (n in 1:N)
    for (dim in 1:DIM)
      target += log_sum_exp( log(lambda[n]) + normal_lpdf(obs[n, dim] | mu[1], sigma_a), log(1 - lambda[n]) + normal_lpdf(obs[n, dim] | mu[2], sigma_b) );
  mu[1] ~ normal(mu_a2, 0.5);
  mu[2] ~ normal(mu_b2, 0.5);
  mu_a2 ~ normal(0, 10);
  mu_b2 ~ normal(0, 10);
  sigma_a ~ cauchy(0, 1);
  sigma_b ~ cauchy(0, 1);
  w ~ normal(0, 1);
}