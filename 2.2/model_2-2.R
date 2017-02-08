library('rstan');
library('loo');

#########################################################
# Get data
#########################################################

d <- read.csv(file = 'data_tadpole.csv', sep = ',');

dataset <- list(N = nrow(d),
                density = d$density,
                surv = d$surv );

#########################################################
# Run inference for Model 1
#########################################################

fit1 <- stan(file = 'model1.stan',
            data = dataset,
            iter = 2000,
            chains = 4);
print(fit1);

png(filename = 'fit1_rstan.png')
plot(fit1);
dev.off();

#########################################################
# Run inference for Model 2
#########################################################

fit2 <- stan(file = 'model2.stan',
            data = dataset,
            iter = 8000,
            chains = 4);
print(fit2);

png(filename = 'fit2_rstan.png')
plot(fit2);
dev.off();

#########################################################
# Compare WAIC and LOO-CV
#########################################################

fe1 <- extract(fit1);
log_lik1 <- fe1$log_lik

fe2 <- extract(fit2);
log_lik2 <- fe2$log_lik

library('loo');
waic(log_lik1);
waic(log_lik2);

loo(log_lik1);
loo(log_lik2);
