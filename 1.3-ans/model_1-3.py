import sys, math
import numpy as np
import pystan
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def simulate():
  print '\tGenerating simulated data...'

  # Exercise 3

  N = 20
  D = 15
  L = 10

  features = np.zeros((N, L))
  for i in range(N):
    for j in range(L):
      features[i][j] = np.random.randn()

  weights = [x - (L/2.0) for x in range(L)]
  weights = np.array(weights)

  means = np.dot(features, weights)

  stds = []
  sigma_mu = 5
  sigma_sigma = 1
  for i in range(N):
    stds.append(abs(sigma_sigma * np.random.randn() + sigma_mu))

  observations = np.zeros((N, D))
  for i in range(N):
    mu = means[i]
    std = stds[i]
    for j in range(D):
      observations[i][j] = std * np.random.randn() + mu


  dataset = {
    'N': N,
    'D': D,
    'L': L,
    'observations': observations,
    'features': features,
  }
  return dataset


def inference(dataset):
  print '\tPerforming inference...'
  NUM_ITER = 1000
  WARMUP = 500
  NUM_CHAINS = 4
  NUM_CORES = 4
  STAN_FN = 'model_1-3.stan'

  # import pdb; pdb.set_trace()
  fit = pystan.stan(file = STAN_FN, 
                    data = dataset, 
                    iter = NUM_ITER, 
                    warmup = WARMUP, 
                    chains = NUM_CHAINS, 
                    n_jobs = NUM_CORES)
  print(fit)

  fit.plot()
  plt.tight_layout()
  plt.savefig('fit_pystan.png')
  return


def main():
  dataset = simulate()
  inference(dataset)
  return


if __name__ == '__main__':
  main()