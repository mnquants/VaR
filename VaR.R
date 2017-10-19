# Value at Risk
# Author: Kyle Loomis
# Date Updated: 10/17/17
# Desc: Framework for calculating 
#       historical simulation VaR. 


# Import Quandl to fetch data
library(Quandl)

# Why Log Returns? https://quantivity.wordpress.com/2011/02/21/why-log-returns/
logReturns <- function(priceTS) {
  return(na.omit(TTR::ROC(priceTS)))
}

# Fetch Adjusted Close price from 
# Quandl from start to end date
adjClose <- function(ticker, start, end) {
  Quandl(paste0("WIKI/",ticker), start_date=start, end_date=end)[,"Adj. Close"]
}

# calibration and testing price vectors
calibrationPrices <- adjClose("NVDA",start="2002-09-15", "2007-09-14")
testPrices <- adjClose("NVDA",start="2007-09-15", "2009-09-15")

# Apply log returns function to get
# calibration and testing return vectors
calibrationReturn <- logReturns(calibrationPrices)
testReturn <- logReturns(testPrices)

# historicalVaR: Historical Simulation Value at Risk
# z = z-score; a = 0.05 -> z = 1.65
historicalVaR <- function(mean, sigma, z) {
  (mean - (z*sigma))
}

calibrationMean <- mean(calibrationReturn)
calibrationSigma <- sd(calibrationReturn)

historicalVaR(calibrationMean, calibrationSigma, 1.65)

min(testRet)

hVaRStats <- function() {
  stats <- c(historicalVaR(calibrationMean, calibrationSigma, 1.65), min(testRet)) 
  names(stats) <- c("Calibrated VaR","Minumum Return")
  return(stats)
  }

print(hVaRStats())

logReturn <- function(prices) {
  n <-length(prices)
  i <- 1
  logged <- c(0)
  
  # Calculating logarithmic returns
  while(i < n) {
    logged[i] <- log(prices[i+1]/prices[i],exp(1))
    i = i + 1
  }
  return(logged)
}


quantile(logReturn(calibrationPrices),0.05)

qnorm(1-0.01,0,1)*calibrationSigma*sqrt(5)






