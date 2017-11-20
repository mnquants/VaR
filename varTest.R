# Value at Risk Testing
# Author: Kyle Loomis
# Updated: 10/31/17
# Desc: Testing Value at Risk
#       techniques

# imports
library(Quandl)
library(TTR)
library(PerformanceAnalytics)

# ----------------- TESTING ----------------- 

tickers <- c("AMD","NVDA")

# calibration - adjusted closing prices
cPrices <- quandlList(tickers,start="2002-09-15",end="2015-09-14")
cAdjCL <- idxList(cPrices)

# test - adjusted closing prices
tPrices <- quandlList(tickers,start="2007-09-15", "2009-09-15")
tAdjCL <- idxList(tPrices)

cLogRet <- logReturnsTTR(cAdjCL, list=TRUE)
tLogRet <- logReturnsTTR(tAdjCL, list=TRUE)


assetMuSd(cAdjCL)
assetMuSd(tAdjCL)

cAMDMean <- mean(cLogRet[["AMD"]])
cAMDSD <- sd(cLogRet[["AMD"]])


alpha <- 0.05         # Alpha value
delta_t <- 1          # 1 period VaR forecast
n_trials <- 100000
set.seed(42)          # Set seed for RNG

sim_returns <- monteCarlo(mean=cMean, sd=cSD, 
                          n=n_trials, delta_t=delta_t)

hist(sim_returns, breaks = 100, col = "green") # Visualize distribution
quantile(sim_returns, alpha) # Calculate VaR using quantile function

# When ES = TRUE, give CVaR or Expected Shortfall
parametric(mean=cAMDMean, sd=cAMDSD, alpha=alpha, 
           delta_t=delta_t, ES=TRUE)

# Compare to Performance Analytics package
ES(cLogRet[["AMD"]], p=0.95,method="gaussian")

# historical simulation method
historicalSim(alpha,cLogRet[["AMD"]])

# Find minimum value in test return time period
testMin <- min(testReturn)

# Print Calibrated VaR and Minimum return
# If abs(calibrationVaR) > abs(testMin), then
# VaR doesn't account for return during testing phase
# (lies outside predicted range)
print(varStats(pVaR, testMin))



# ----------------- ALTERNATIVE PARAMETRIC CVAR ----------------- 

# By Ted Xu 
montecarlo_alpha = runif(n_trials, min = 0, max = alpha)
VaR <- parametric(mean=cAMDMean, sd=cAMDSD, alpha=montecarlo_alpha, delta_t=delta_t)
CVaR <- sum(VaR) / n_trials
