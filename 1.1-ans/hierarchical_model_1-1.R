library('rstan');

N <- 15;
D <- 30;
exp_rate <- 0.1;
normal_sigma <- 1;

#########################################################
# Simulate data
#########################################################

means <- rexp(N, rate = exp_rate);
obs <- matrix(, nrow = N, ncol = D);
for(row in 1:N) {
  obs[row, ] <- rnorm(D, mean = means[row], sd = normal_sigma); 
}


#########################################################
# Run inference
#########################################################

dataset <- list(N = N, 
                D = D,
                observations = obs);

fit <- stan(file = 'hierarchical_model_1-1.stan', 
            data = dataset, 
            iter = 1000, 
            chains = 4);
print(fit);

png(filename = 'fit_rstan.png')
plot(fit);
dev.off();

fe <- extract(fit);
print( tail(fe$normal_mus, n = 1) );