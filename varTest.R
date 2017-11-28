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
# calibration & testing - adjusted closing prices
cPrices <- quandlList(tickers,start="2002-09-15",end="2015-09-14")
cAdjCL <- idxList(cPrices)
tPrices <- quandlList(tickers,start="2007-09-15", "2009-09-15")
tAdjCL <- idxList(tPrices)
# apply log return
cLogRet <- logReturnsTTR(cAdjCL, list=TRUE)
tLogRet <- logReturnsTTR(tAdjCL, list=TRUE)


a <- 0.01             # Alpha value
t <- 1                # 1 period VaR forecast
n_trials <- 100000
set.seed(42)          # Set seed for RNG

#sim_returns <- monteCarlo(mean=cMean, sd=cSD, n=n_trials, delta_t=delta_t)
#hist(sim_returns, breaks = 100, col = "green") # Visualize distribution


ValueatRisk(cLogRet[["AMD"]],alpha=a,n=n_trials,
            delta_t=t,method="parametric",ES=TRUE)


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
