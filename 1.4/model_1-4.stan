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
}