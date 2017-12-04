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


# ----------------- PARAMETRIC PORTFOLIO ----------------- 
# incorporates asset correlation in a portfolio to calculate 
# mean return and standard deviation
# Task: 
# 1. separate portfolio correlation functionality from function
#    with a goal of making it generalizable for other applications
# 2. document function to incorporate into package


#' Parametric_Portfolio 
#' @param mean Mean return of timeseries data
#' @param sd Standard deviation value of timeseries data
#' @param alpha Alpha value for confidence level
#' @param delta_t Number of days to forecast VaR
#' @param to calculate VaR when ES is set to FALSE (defalut); otherwise, to calculate CVaR
#' @param the function calculates VaR for one assest when Port is set to FALSE(default); otherwise, it will return VaR for a portfolio of more than one assest
#' @param the weights (vector) of assests in the portfolio should sum up to 1, with equal weights as default
#' @param corMat is correlation matrix of assets in the portfolio, with identity matrix as default
#' @return Vector of Adjusted close prices
parametric <- function(mean, sd, alpha, delta_t, ES=FALSE, Port = FALSE, weights = NULL, corMat = NULL) {
  
  if(!Port){
    numAssets <- length(mean)
    if (weights == NULL) weights = rep(1, numAssets)/ numAssets
    if (corMat == NULL) corMat = diag(rep(1, numAssets))
    mean <- sum(mean*weights)
    sd <- sqrt(weights)*sd
    sd <- sum(sd*crossprod(corMat, sd))
  }
  
  # qnorm function used to calculate z-score
  parametric2 <- function(alpha) {
    
    # Modification 1: in the Github, pi should not be involved when calculating VaR in % but not $
    return (mean*delta_t - qnorm(1-alpha,0,1)*sd*sqrt(delta_t))
    # return((mean - (qnorm(1-alpha,0,1)*sd))*sqrt(delta_t))
  }
  if (ES) { return(integrate(parametric2, 0, alpha)$value / alpha) }
  else { return(parametric2(alpha)) }
  
  
}
