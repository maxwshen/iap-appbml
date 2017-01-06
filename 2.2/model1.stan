data {
  int N;
  int density[N];
  int surv[N];
}

parameters {
  vector[N] alpha;
}

transformed parameters {
  vector[N] p;
  for (n in 1:N) {
    p[n] = inv_logit(alpha[n]);
  }
}

model {
  surv ~ binomial(density, p);
  alpha ~ cauchy(0, 1);
}

generated quantities {
  vector[N] log_lik;
  for (n in 1:N)
    log_lik[n] = binomial_lpmf(surv[n] | density[n], p[n]);
}