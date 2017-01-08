
data {
  int N;
  int D;
  int L;
  matrix[N, D] Y;
  matrix[N, D] X;
}

parameters {
  vector[N] c;
  vector[N] w;
  vector[L] cw_mus;
  vector<lower=0>[L] cw_sigmas;
  real<lower=0> sigma;
  corr_matrix[L] R;
}

transformed parameters {
  vector[L] cws[N];     # N-by-L matrix
  cov_matrix[L] S;

  # Change data type for multi_normal in model block
  for (n in 1:N) {
    cws[n,1] = c[n];
    cws[n,2] = w[n];
  }

  # Create covariance matrix, S
  # performs: diagonalize sigmas_cw * R * diagonalize sigmas_cw
  S = quad_form_diag(R, cw_sigmas);
}

model {
  matrix[N, D] mu;

  # priors
  R ~ lkj_corr(1);
  mus ~ normal(0, 10);
  cw_sigmas ~ cauchy(0, 1);
  sigma ~ cauchy(0, 1);

  # Each draw is a vector of size L
  # cws is N draws because it's N by L
  cws ~ multi_normal(cw_mus, S);

  # Regression
  for (n in 1:N) {
    mu[n] = c[n] + w[n] * X[n];
    Y[n] ~ normal(mu[n], sigma);
  }
}