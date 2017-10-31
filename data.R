# Data handling
# Author: Kyle Loomis
# Updated: 10/31/17
# Desc: Data handling functions 


library(Quandl)
library(TTR)

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
#' @return Vector of adjusted close prices
#' @export
adjClose <- function(ticker, start, end) {
  Quandl(paste0("WIKI/",ticker), start_date=start, end_date=end)[,"Adj. Close"]
}


# ----------------- TO ADD ----------------- 

# function to generate mean and sd of the logReturn for each asset
logReturn.MuSd.Asset <- function(priceDataframe){
  # row for observations
  tmp <- t( apply( apply(priceDataframe, 2, logReturns),
                   2,
                   function(x) return( c(mean(x), sd(x)) ) 
  )
  colnames(tmp) <- c("Mean", "Sd")
  return(tmp)
}

# function to generate mean and sd of the logReturn for the portfolio
logReturn.MuSd.Port <- function(dFm.MuSd, weight = 1, cor = NA) {
  if(weight == 1){ weight = (numeric(ncol(dFm.MuSd)) + 1 ) / ncol(dFm.MuSd) }
  tmp.mu <- dFm.MuSd[, "Mean"]*weight
  tmp.Sd <- sqrt(crossprod( t(dFm.Sd[, "Mean"]), cor) %*% dFm.Sd[, "Mean"])
  return(c(tmp.mu, tmp.Sd))
}