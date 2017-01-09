import sys, math
import numpy as np
import pystan
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def simulate():
  print '\tGenerating simulated data...'
  
  counts = np.array( [15, 20, 10, 30, 25, 35] )
  X_means = [-3, -2, -1, 0, 1, 2]
  X_std = 0.1
  N = sum(counts)
  NUM_CLASSES = len(counts)

  Y = []
  for i in range(len(counts)):
    Y += [i+1] * counts[i]

  X = []
  for i in range(len(counts)):
    for j in range(counts[i]):
      X.append( X_std * np.random.randn() + X_means[i] )

  # Construct dictionary to pass to Stan
  dataset = {
    'N': N,
    'NUM_CLASSES': NUM_CLASSES,
    'Y': Y,
    'X': X
  }
  return dataset


def inference(dataset):
  print '\tPerforming inference...'
  NUM_ITER = 1000
  WARMUP = 500
  NUM_CHAINS = 4
  NUM_CORES = 4
  STAN_FN = 'model_3-2.stan'

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