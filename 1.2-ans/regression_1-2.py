import sys, math
import numpy as np
import pystan
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def simulate():
  print '\tGenerating simulated data...'

  N = 30
  D = 10

  weights = [x - (D/2.0) for x in range(D)]
  weights = np.array(weights)
  print 'True Weights:', weights

  fmean, fstd = 0, 1
  features = np.zeros((N, D))
  for i in range(N):
    for j in range(D):
      features[i][j] = fstd * np.random.randn() + fmean

  observations = np.dot(features, weights)

  sigma = 1
  noise = np.zeros((observations.shape))
  for i in range(len(noise)):
    noise[i] = sigma * np.random.randn() + 0

  observations += noise

  # Construct dictionary to pass to Stan
  dataset = {
    'N': N,
    'D': D,
    'observations': observations,
    'features': features
  }
  return dataset


def inference(dataset):
  print '\tPerforming inference...'
  NUM_ITER = 2000
  WARMUP = 200
  NUM_CHAINS = 4
  NUM_CORES = 4
  STAN_FN = 'regression_1-2.stan'

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
  plt.savefig('fit.png')
  return


def main():
  dataset = simulate()
  inference(dataset)
  return


if __name__ == '__main__':
  main()