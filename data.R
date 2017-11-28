# Data handling
# Author: Kyle Loomis
# Updated: 11/9/17
# Desc: Data handling functions 


#' Log Returns with TTR package
#' @param x Time series to be converted
#' @param n Number of periods to calculate over Default is 1
#' @return Vector of log returns for x
#' @export
logReturnsTTR  <- function(x, n = 1, list=FALSE) {
  if (list) {
    lapply(x, function(x) { return(ROC(x, n = n, type = "continuous", na.pad = FALSE)) })
  }
  else { return(ROC(x, n = n, type = "continuous", na.pad = FALSE)) }
}

#' List of equity data from Quandl
#' @param tv Vector of stock tickers
#' @param start Start date - format: "YYYY-MM-DD"
#' @param end End date - format: "YYYY-MM-DD"
#' @param src Source of Database (e.g. "WIKI")
#' @return List of equity data (as xts) from Quandl
#' @export
quandlList <- function(tv, start, end, src="WIKI") {
  data <- lapply(tv, function(tv) {
    Quandl(paste0(src,"/",tv), start_date=start, end_date=end, type="xts")
  })
  names(data) <- tv
  return(data)
}

#' Index column(s) in quandlList object
#' @param quandlList quandlList object
#' @param idx Index/indexes for each equity in quandlList
#' @return List of indexed column(s) in quandList object
#' @export
idxList <- function(quandlList, idx = "Adj. Close") {
  lapply(quandlList, function(quandlList) {
    quandlList[,idx]
  })
}

# Portfolio Asset Mean and Standard Deviation
#' @param pricesList List of prices for each asset
#' @return Mean and SD for each asset in pricesList
#' @export
assetMuSd <- function(pricesList){
  data <- sapply(pricesList, function(pricesList) {
    logRet <- logReturnsTTR(pricesList)
    tmp <- c(mean(logRet), sd(logRet))
    names(tmp) <- c("Mean", "Sd")
    return(tmp)
  })
  return(t(data))
}




# ----------------- TO ADD ----------------- 

# function to generate mean and sd of the logReturn for the portfolio
logReturn.MuSd.Port <- function(dFm.MuSd, weight = 1, cor = NA) {
  if(weight == 1){ weight = (numeric(ncol(dFm.MuSd)) + 1 ) / ncol(dFm.MuSd) }
  tmp.mu <- dFm.MuSd[, "Mean"]*weight
  tmp.Sd <- sqrt(crossprod( t(dFm.Sd[, "Mean"]), cor) %*% dFm.Sd[, "Mean"])
  return(c(tmp.mu, tmp.Sd))
}

