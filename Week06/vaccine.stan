// This Stan program draws from the posterior Pfizer should have used
data { // everything to the right of the | in Bayes' Rule
  real<upper = 1> m; // expectation for normal prior on VE
  real<lower = 0> s; // standard deviation for normal prior on VE
  int<lower = 0>  n; // number of people with Covid in the RCT
  int<lower = 0, upper = n> y; // number of them who were vaccinated
}
parameters { // everything to the left of the | in Bayes' Rule
  real<upper = 1> VE; // = 1 - Pr(covid | vax) / Pr(covid | placebo)
}
transformed parameters { // any function of parameters worth keeping
  real<lower = 0, upper = 1> theta = (VE - 1) / (VE - 2);
}
model { // target has been initialized to zero basically
  target += normal_lpdf(VE | m, s);      // prior log-kernel
  target += binomial_lpmf(y | n, theta); // log-likelihood
} // model block is like a function that returns target
