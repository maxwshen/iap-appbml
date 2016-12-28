import sys, math
import numpy as np
import pystan
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def simulate():
  print '\tGenerating simulated data...'

  ###################################################
  ## Your code here


  ## Your code here
  ###################################################

  # Construct dictionary to pass to Stan
  dataset = {
    'N': N,
    'D': D,
    'observations': observations,
  }
  return dataset


def inference(dataset):
  print '\tPerforming inference...'
  NUM_ITER = 2000
  WARMUP = 200
  NUM_CHAINS = 4
  NUM_CORES = 4
  STAN_FN = 'hierarchical_model_1-1.stan'

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