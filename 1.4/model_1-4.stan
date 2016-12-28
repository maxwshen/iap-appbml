data {
  int N;
  vector[N] observations;
}

parameters {
  real mu_a;
  real mu_b;
  real<lower=0> sigma;
}

transformed parameters {
}

model {
  observations ~ normal(mu_a + mu_b, sigma); 
  mu_a ~ normal(0, 100);
  mu_b ~ normal(0, 100);
}