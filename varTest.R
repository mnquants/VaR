# Value at Risk Testing
# Author: Kyle Loomis
# Updated: 10/31/17
# Desc: Testing Value at Risk
#       techniques


# ----------------- TESTING ----------------- 

processData <- function() {
  tickers <- c("AMD","NVDA")
  
  # calibration - adjusted closing prices
  cPrices <- quandlList(tickers,start="2002-09-15",end="2015-09-14")
  cAdjCL <- idxList(cPrices)
  
  # test - adjusted closing prices
  tPrices <- quandlList(tickers,start="2007-09-15", "2009-09-15")
  tAdjCL <- idxList(tPrices)
  
  cLogRet <- logReturnsTTR(cAdjCL, list=TRUE)
  tLogRet <- logReturnsTTR(tAdjCL, list=TRUE)
}

assetMuSd(cAdjCL)
assetMuSd(tAdjCL)

cMean <- mean(cLogRet[["AMD"]])
cSD <- sd(cLogRet[["AMD"]])


alpha <- 0.05         # Alpha value
delta_t <- 1          # 1 period VaR forecast
n_trials <- 100000
set.seed(42)          # Set seed for RNG

sim_returns <- monteCarlo(mean=cMean, sd=cSD, 
                          n=n_trials, delta_t=delta_t)

hist(sim_returns, breaks = 100, col = "green") # Visualize distribution
quantile(sim_returns, alpha) # Calculate VaR using quantile function

pVaR <- parametric(mean=cMean, sd=cSD, 
                             alpha=alpha, delta_t=delta_t, ES=FALSE)

pVaR

# Find minimum value in test return time period
testMin <- min(testReturn)

# Print Calibrated VaR and Minimum return
# If abs(calibrationVaR) > abs(testMin), then
# VaR doesn't account for return during testing phase
# (lies outside predicted range)
print(varStats(pVaR, testMin))

# Performance Analytics package
ES(cLogRet[["AMD"]], p=0.95)

# from Ted Xu
n = 1000000 # number of simulations
montecarlo_alpha = runif(n, min = 0, max = alpha)
VaR <- parametric(mean=mean, sd=sigma, alpha=montecarlo_alpha, delta_t=delta_t)
CVaR = sum(VaR) / n

parametricCVaR(cMean,cSD, 0.05, 1)
parametric(cMean,cSD,0.05,1,ES=TRUE)


head(sort(c(cLogRet[["AMD"]])))
historicalSim(0.01,cLogRet[["AMD"]])

max(sort(cLogRet[["AMD"]]))

sort(head(cLogRet[["AMD"]]))
