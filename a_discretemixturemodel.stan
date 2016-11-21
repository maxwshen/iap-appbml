data {
  int N;
  int DIM;
  vector[DIM] obs[N];
}

parameters {
  real<lower=0> mu_a; 
  real<lower=0> mu_b; 
  real<lower=0> sigma_a;
  real<lower=0> sigma_b;
  real<lower=0, upper=1> lambda[N];
}

transformed parameters {
}

model {
  for (n in 1:N)
    for (dim in 1:DIM)
      target += log_sum_exp( log(lambda[n]) + normal_lpdf(obs[n, dim] | mu_a, sigma_a), log(1 - lambda[n]) + normal_lpdf(obs[n, dim] | mu_b, sigma_b) );
  mu_a ~ normal(0, 10);
  mu_b ~ normal(0, 10);
  sigma_a ~ cauchy(0, 1);
  sigma_b ~ cauchy(0, 1);
}