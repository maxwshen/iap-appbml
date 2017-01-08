import sys, math
import numpy as np
import pystan
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def simulate():
  print '\tGenerating simulated data...'

  N = 20
  D = 10
  L = 2

  X = np.zeros((N, D))
  for i in range(N):
    for j in range(D):
      if j > D / 2:
        X[i][j] = 1
      else:
        X[i][j] = 0

  c_mean = -5
  w_mean = 5
  corr = 0.75
  c_std = 1
  w_std = 1
  means = np.array([c_mean, w_mean])
  sigmas = np.array([c_std, w_std
    ])
  covs = [[ c_std **2   ,   c_std * w_std * corr,  ],
          [c_std * w_std * corr,      w_std ** 2]]
  M = np.random.multivariate_normal(means, covs, N)

  sigma = 0.02
  Y = np.zeros((N, D))
  for i in range(N):
    for j in range(D):
      mean_ij = M[i][0] + M[i][1] * X[i][j]
      Y[i][j] = sigma * np.random.randn() + mean_ij

  dataset = {
    'N': N,
    'D': D,
    'L': L,
    'Y': Y,
    'X': X,
  }
  return dataset


def inference(dataset):
  print '\tPerforming inference...'
  NUM_ITER = 1000
  WARMUP = 500
  NUM_CHAINS = 4
  NUM_CORES = 4
  STAN_FN = 'model_3-4-regression.stan'

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