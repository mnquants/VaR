# Value at Risk
# Author: Kyle Loomis
# Updated: 10/20/17
# Desc: Monte Carlo 
#       Value at Risk 

# Resources:
# 1. http://blog.revolutionanalytics.com/2014/04/quantitative-finance-applications-in-r-5.html


#' Monte Carlo Value at Risk (VaR)
#' @param mean Sample mean return
#' @param sd Sample standard deviation return
#' @param epsilon Vector of random normal distribution values
#' @param delta_t Change in time (usually days)
#' @return Vector of simulated returns
#' @export
mcVaR <- function(mean, sd, epsilon, delta_t) {
  return(mean*delta_t + sd*epsilon*sqrt(delta_t))
}

# ----------------- TESTING ----------------- 

# set seed for the random number generator
# to get consistent production of random numbers
# in rnorm function
set.seed(42)

# creates vector of random numbers 
# using the normal distribution with n trials
# assumes mean = 0, sd = 1
epsilon <- rnorm(n)

# mean <-
# sd <- 
# delta_t <- 

# calculate VaR
# sim_returns <- mcVaR()

# plot histogram of returns
hist(sim_returns, breaks = 100, col = "green")

# plug the vector of simulated returns into Parametric VaR...