library('rstan');


#########################################################
# Simulate data
#########################################################

# Exercise 3

N <- 20;
D <- 15;
L <- 10;


features <- matrix(, nrow = N, ncol = L);
for (row in 1:N) {
  features[row, ] <- rnorm(L, mean = 0, sd = 1);
}

weights <- c(-5, -4, -3, -2, -1, 0, 1, 2, 3, 4);

means <- features %*% weights;

sigma_mu <- 5;
sigma_sigma <- 1;

stds <- rnorm(N, mean = sigma_mu, sd = sigma_sigma);
stds <- abs(stds);  # ensure positive

obs <- matrix(, nrow = N, ncol = D);
for (row in 1:N) {
  obs[row, ] <- rnorm(D, mean = means[row], sd = stds[row]);
}

dataset <- list(N = N, 
                D = D,
                L = L,
                observations = obs,
                features = features);

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
