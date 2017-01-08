library('rstan');

N <- 30;
D <- 10;
weights <- c(-5, -4, -3, -2, -1, -0, 1, 2, 3, 4);
normal_sigma <- 1;

feature_mean <- 0;
feature_sigma <- 1;

#########################################################
# Simulate data
#########################################################

features <- matrix(, nrow = N, ncol = D);
for (row in 1:N) {
  features[row, ] <- rnorm(D, 
                           mean = feature_mean, 
                           sd = feature_sigma);
}

obs <- features %*% weights;    # matrix multiply
noise <- rnorm(N, mean = 0, sd = normal_sigma);
obs <- obs + noise;
obs <- as.vector(obs);   # convert to vector

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
