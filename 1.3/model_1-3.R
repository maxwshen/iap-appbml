library('rstan');


#########################################################
# Simulate data
#########################################################


#########################################################
# Run inference
#########################################################


fit <- stan(file = 'model_1-3.stan', 
            data = dataset, 
            iter = 1000, 
            chains = 4);
print(fit);

png(filename = 'fit_rstan.png')
plot(fit);
dev.off();
