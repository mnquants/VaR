# Value at Risk Testing
# Author: Kyle Loomis
# Updated: 10/31/17
# Desc: Testing Value at Risk
#       techniques


# ----------------- TESTING ----------------- 

calibrationPrices <- adjClose("NVDA",start="2002-09-15", "2007-09-14")
testPrices <- adjClose("NVDA",start="2007-09-15", "2009-09-15")

calibrationReturn <- logReturns(calibrationPrices)
testReturn <- logReturns(testPrices)

calibrationMean <- mean(calibrationReturn)
calibrationSD <- sd(calibrationReturn)


alpha <- 0.05         # Alpha value
delta_t <- 1          # 1 period VaR forecast 
set.seed(42)          # Set seed for RNG
n <- 10000            # Number of periods to simulate
epsilon <- rnorm(n)   # Vector of random standard normal distribution values

sim_returns <- monteCarlo(mean=calibrationMean, sd=calibrationSD, 
                          epsilon=epsilon, delta_t=delta_t)

hist(sim_returns, breaks = 100, col = "green") # Visualize distribution


pVaR <- parametric(mean=calibrationMean, sd=calibrationSD, 
                             alpha=alpha, delta_t=delta_t)


# Find minimum value in test return time period
testMin <- min(testReturn)

# Print Calibrated VaR and Minimum return
# If abs(calibrationVaR) > abs(testMin), then
# VaR doesn't account for return during testing phase
# (lies outside predicted range)
print(varStats(pVaR, testMin))

