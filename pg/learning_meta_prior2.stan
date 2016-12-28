data {
  int N;
  int D;
  int L;
  int observations[N];
  matrix[N, D] features;
  # vector[L] metafeatures[N, D];
  matrix[D, L] metafeatures;
}

parameters {
  vector[D] weights;
  vector<lower=0, upper=5>[L] hyperweights;
}

transformed parameters{
  vector[D] vari;
  vari = metafeatures * hyperweights;
}

model {
  observations ~ bernoulli_logit(features * weights);
  # weights ~ normal(0, 1);
  weights ~ normal(0, vari);
  # weights ~ gamma(1, vari);
  vari ~ gamma(1, 5);
}