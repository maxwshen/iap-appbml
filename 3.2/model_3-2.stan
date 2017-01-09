data {
  int N;
  int NUM_CLASSES;
  int Y[N];
  vector[N] X;
}

parameters {
  ordered[NUM_CLASSES - 1] intercepts;
  real w;
}

transformed parameters {
  vector[N] phi;
  phi = X * w;
}

model {
  intercepts ~ normal(0, 10);
  w ~ normal(0, 5);

  for (n in 1:N) {
    Y[n] ~ ordered_logistic(phi[n], intercepts);
  }
}