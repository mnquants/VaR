# Value at Risk
# Author: Kyle Loomis
# Updated: 10/20/17
# Desc: Framework for calculating 
#       Value at Risk 


# Import Quandl library to fetch data
library(Quandl)

#' Calculate Log Returns
#' @param priceTS Price Timeseries
#' @return Log Returns
#' @export
logReturnsTTR <- function(priceTS) {
  return(na.omit(TTR::ROC(priceTS)))
}

#' Calculate Log Returns - w/o external package
#' @param priceTS Price Timeseries
#' @return Log Returns  
#' @export
logReturns <- function(priceTS) {
  n <-length(priceTS)
  i <- 1
  logged <- c(0)
  
  # Calculating logarithmic returns
  while(i < n) {
    logged[i] <- log(priceTS[i+1]/priceTS[i],exp(1))
    i = i + 1
  }
  return(logged)
}

#' Adjusted close prices from WIKI database
#' @param ticker Stocker ticker
#' @param start Start date - format: "YYYY-MM-DD"
#' @param end End date - format: "YYYY-MM-DD"
#' @return Vector of Adjusted close prices
#' @export
adjClose <- function(ticker, start, end) {
  Quandl(paste0("WIKI/",ticker), start_date=start, end_date=end)[,"Adj. Close"]
}

#' Parametric Value at Risk (VaR)
#' @param mean Mean return of timeseries data
#' @param sigma Standard deviation value of timeseries data
#' @param alpha Alpha value for confidence level
#' @param days Number of days to forecast VaR
#' @return Vector of Adjusted close prices
#' @export
parametricVaR <- function(mean, sigma, alpha, days) {
  # qnorm function used to calculate z-score
  return((mean - (qnorm(1-alpha,0,1)*sigma))*sqrt(days))
}

#' Value at Risk Statistics
#' @param calibrationVaR Calibrated VaR 
#' @param testMin Minimum return
#' @return Vector of Calibrated VaR and Minimum Return
#' @export
VaRStats <- function(calibrationVaR, testMin) {
  stats <- c(calibrationVaR, testMin) 
  names(stats) <- c("Calibrated VaR","Minumum Return")
  return(stats)
}


# ----------------- TESTING ----------------- 

# Calibration and testing adjusted closing price vectors 
calibrationPrices <- adjClose("NVDA",start="2002-09-15", "2007-09-14")
testPrices <- adjClose("NVDA",start="2007-09-15", "2009-09-15")

# Apply log returns function to get
# calibration and testing return vectors
calibrationReturn <- logReturns(calibrationPrices)
testReturn <- logReturns(testPrices)

# Calculate mean and standard deviation with return vector
calibrationMean <- mean(calibrationReturn)
calibrationSigma <- sd(calibrationReturn)

# Calculate VaR with a = 0.05 and time period = 1 day
calibrationVaR <- parametricVaR(calibrationMean, calibrationSigma, 0.05, 1)

# Find minimum value in test return time period
testMin <- min(testReturn)


# Print Calibrated VaR and Minimum return
# If abs(calibrationVaR) > abs(testMin), then
# VaR doesn't account for return during testing phase
# (lies outside predicted range)
print(VaRStats(calibrationVaR, testMin))
