# Value at Risk Framework
# Author: Kyle Loomis
# Updated: 10/31/17
# Desc: Framework for implementing 
#       Value at Risk methods


#' Parametric Value at Risk
#' @param mean Mean return of timeseries data
#' @param sd Standard deviation value of timeseries data
#' @param alpha Alpha value for confidence level
#' @param delta_t Number of days to forecast VaR
#' @return Vector of Adjusted close prices
#' @export
parametric <- function(mean, sd, alpha, delta_t) {
  # qnorm function used to calculate z-score
  return((mean - (qnorm(1-alpha,0,1)*sd))*sqrt(delta_t))
}

#' Monte Carlo Value at Risk
#' @param mean Sample mean return
#' @param sd Sample standard deviation return
#' @param epsilon Vector of random normal distribution values
#' @param delta_t Change in time (usually days)
#' @return Vector of simulated returns
#' @export
monteCarlo <- function(mean, sd, epsilon, delta_t) {
  return(mean*delta_t + sd*epsilon*sqrt(delta_t))
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
