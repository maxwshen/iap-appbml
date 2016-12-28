# Discrete Mixture model

import sys, math
import numpy as np
import pystan


def simulate():
  print '\tGenerating simulated data...'
  N = 20
  DIM = 30
  mu_a, sigma_a = 5, 1
  mu_b, sigma_b = 10, 1

  obs = np.zeros((N, DIM))
  for i in range(10):
    for j in range(DIM):
      obs[i][j] = sigma_a * np.random.randn() + mu_a
  for i in range(10, 20):
    for j in range(DIM):
      obs[i][j] = sigma_b * np.random.randn() + mu_b

  data_list = {
    'N': N,
    'DIM': DIM,
    'obs': obs,
  }
  return data_list


def inference(data):
  print '\tPerforming inference...'
  NUM_ITER = 1000
  WARMUP = 100
  NUM_CHAINS = 1
  NUM_CORES = 1
  STAN_FN = 'a_discretemixturemodel.stan'

  fit = pystan.stan(file = STAN_FN, 
                    data = data, 
                    iter = NUM_ITER, 
                    warmup = WARMUP, 
                    chains = NUM_CHAINS, 
                    n_jobs = NUM_CORES)

  print(fit)

  fit.plot()
  # plt.savefig('fig.png')

  return


def main():
  data = simulate()
  inference(data)
  return


if __name__ == '__main__':
  main()