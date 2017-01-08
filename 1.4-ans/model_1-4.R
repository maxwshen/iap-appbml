library('rstan');


#########################################################
# Simulate data
#########################################################

N <- 20;
obs <- rnorm(N, mean = 0, sd = 1);

dataset <- list(N = N, 
                observations = obs);

#########################################################
# Run inference
#########################################################


fit <- stan(file = 'model_1-4.stan', 
            data = dataset, 
            iter = 1000, 
            chains = 4);
print(fit);

png(filename = 'fit_rstan.png')
plot(fit);
dev.off();
