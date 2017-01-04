library('rstan');

#########################################################
# Simulate data
#########################################################
## Your code here




## Your code here

#########################################################
# Run inference
#########################################################

# Construct dataset to pass to Stan  
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