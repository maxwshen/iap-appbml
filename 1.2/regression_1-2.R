library('rstan');


#########################################################
# Simulate data
#########################################################
###################################################
## Your code here


## Your code here
###################################################

#########################################################
# Run inference
#########################################################

dataset <- list(N = N, 
                D = D,
                observations = obs,
                features = features);

fit <- stan(file = 'regression_1-2.stan', 
            data = dataset, 
            iter = 1000, 
            chains = 4);
print(fit);

png(filename = 'fit_rstan.png')
plot(fit);
dev.off();
