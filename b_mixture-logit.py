# Discrete Mixture model

import sys, math
import numpy as np, pandas as pd
import pystan
import matplotlib.pyplot as plt


def simulate():
  print '\tGenerating simulated data...'
  N = 20
  DIM = 30
  mu_a, sigma_a = 5, 1
  mu_b, sigma_b = 10, 1
  mu_af, sigma_af = 3, 1
  mu_bf, sigma_bf = 7, 1

  obs = np.zeros((N, DIM))
  for i in range(N/2):
    for j in range(DIM):
      obs[i][j] = sigma_a * np.random.randn() + mu_a
  for i in range(N/2, N):
    for j in range(DIM):
      obs[i][j] = sigma_b * np.random.randn() + mu_b

  f = np.zeros((N, DIM))
  for i in range(N/2):
    for j in range(DIM):
      f[i][j] = sigma_af * np.random.randn() + mu_af
  for i in range(N/2, N):
    for j in range(DIM):
      f[i][j] = sigma_bf * np.random.randn() + mu_bf

  data_list = {
    'N': N,
    'DIM': DIM,
    'obs': obs,
    'f': f
  }

  return data_list

def inference(data):
  print '\tPerforming inference...'
  NUM_ITER = 2000
  WARMUP = 100
  NUM_CHAINS = 1
  NUM_CORES = 1
  # Unidentifiability is ok with 1 chain
  # Multiple chains causes them to be averaged together
  STAN_FN = 'b_mixture-logit.stan'

  fit = pystan.stan(file = STAN_FN, data = data, iter = NUM_ITER, warmup = WARMUP, chains = NUM_CHAINS, n_jobs = NUM_CORES)
  print(fit)

  fit.plot()
  plt.savefig('fig.png')

  return


def main():
  data = simulate()
  inference(data)
  return


if __name__ == '__main__':
  main()