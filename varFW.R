# Value at Risk Framework
# Author: Kyle Loomis
# Updated: 10/31/17
# Desc: Framework for implementing 
#       Value at Risk methods


#' Parametric
#' @param mean Mean return of timeseries data
#' @param sd Standard deviation value of timeseries data
#' @param alpha Alpha value for confidence level
#' @param delta_t Number of days to forecast VaR
#' @return Vector of Adjusted close prices
#' @export
parametric <- function(mean, sd, alpha, delta_t, ES=FALSE) {
  # qnorm function used to calculate z-score
  parametric2 <- function(alpha) {
    return((mean - (qnorm(1-alpha,0,1)*sd))*sqrt(delta_t))
  }
  if (ES) { return(integrate(parametric2, 0, alpha)$value / alpha) }
  else { return(parametric2(alpha)) }
}

#' Monte Carlo
#' @param mean Sample mean return
#' @param sd Sample standard deviation return
#' @param n Number of iterations
#' @param delta_t Change in time (usually days)
#' @return Vector of simulated returns
#' @export
monteCarlo <- function(mean, sd, n, delta_t) {
  return(mean*delta_t + sd*rnorm(n)*sqrt(delta_t))
}

#' Historical Simulation
#' @param alpha Alpha value for confidence level
#' @param histRet Vector of historical returns
#' @return Max of lowest alpha*100 of histP
#' @export
historicalSim <- function(alpha, histRet) {
  max((sort(coredata(histRet)))[1:(alpha*length(histRet))])
}

#' Value at Risk Statistics
#' @param calibrationVaR Calibrated VaR 
#' @param testMin Minimum return
#' @return Vector of Calibrated VaR and Minimum Return
#' @export
varStats <- function(calibrationVaR, testMin) {
  stats <- c(calibrationVaR, testMin) 
  names(stats) <- c("Calibrated VaR","Minumum Return")
  return(stats)
}