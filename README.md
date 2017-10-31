# Value at Risk (VaR)

## Resources
1. [Why Log Returns - Quantivity](https://quantivity.wordpress.com/2011/02/21/why-log-returns/)
2. [Value at Risk - Investopedia](http://www.investopedia.com/terms/v/var.asp)
3. [Approaches to VaR - Stanford](https://web.stanford.edu/class/msande444/2012/MS&E444_2012_Group2a.pdf)
4. [Uniform Distribution - R](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Uniform.html)
5. [Monte Carlo Method in R - alookanalytics blog](https://blog.alookanalytics.com/2017/04/26/monte-carlo-method-in-r/)
6. [Calculating VaR with R - R-Bloggers](https://www.r-bloggers.com/calculating-var-with-r/)
7. [Monte Carlo Package - R](https://cran.r-project.org/web/packages/MonteCarlo/MonteCarlo.pdf)
8. [Fixed Income Risk: Calculating Value at Risk (VaR) for Bonds](https://financetrainingcourse.com/education/2013/05/bond-risk-calculating-value-at-risk-var-for-bonds/)
9. [Portfolio & Risk Analytics - Bloomberg Terminal](https://www.bloomberg.com/professional/product/portfolio-risk-analytics/)
10. [Risk Management for Fixed Income Portfolios - Credit Suisse](https://www.credit-suisse.com/media/am/docs/asset_management/events/2014/fits2014-program/3-5-2-traband-risk-management.pdf)

## Formula(s)
#### Parametric
VaR = mean * delta_t - Z * sigma * sqrt(delta_t) * pi
- mean = Expected portfolio return
- sigma = Expected portfolio standard deviation
- delta_t = periods (typically days) to forecast VaR into the future
- Z = Z-Score of (1 - a), where a is the confidence level
- pi = Portfolio value (optional)


Assume an initial portfolio value of $1000.00. Assume we have a 95% confidence level (a = 0.05). 
Assume the following:
```
mean <- 0.04          # Expected portfolio return
sigma <- 0.05         # Expected portfolio standard deviation
delta_t <- 1          # 1 day forecast
alpha <- 0.05         # 95% confidence interval
pi <- 1000.00         # Portflio value = $1,000.00 

# qnorm function used to calculate z-score
VaR <- parametricVaR(mean=mean, sd=sigma, alpha=alpha, delta_t=delta_t)

# Portfolio VaR
piVaR <- VaR*pi
```

Thus, VaR = -$42.5 or -4.25%. This means we have 95% confidence that over the next day the portfolio will not lose more than $42.5.

#### Monte Carlo
Ri = mean * delta_t + sigma * epsilon * sqrt(delta_t)
- Ri = Simulated return on the ith trial
- mean = Expected portfolio return
- sigma = Expected portfolio standard deviation
- delta_t = periods (typically days) to forecast VaR into the future
- epsilon = vector of random numbers generated from a normal distribution 

```
# Set seed for the rng (random number generator)
# to get consistent sequence of random numbers
set.seed(42)

n <- 10000            # number of periods to simulate
epsilon <- rnorm(n)   # vector of random standard normal distribution values
mean <- 0.1           # Expected portfolio return
sigma <- 0.25         # Expected portfolio standard deviation
delta_t <- 1          # 1 period VaR forecast

# Call mcVaR function
sim_returns <- mcVaR(mean=mean, sd=sigma, epsilon=epsilon, delta_t=delta_t)

# Visualize the distribution
hist(sim_returns, breaks = 100, col = "green")
```

As the number of simulated returns increases (n in rnorm(n)), the distribution forecast more closely matches a normal distribution. In order to get the expected VaR given some confidence interval, 1 - a, apply the following function in R:

```
a_vals <- c(0.01,0.05)  
quantile(sim_returns, a_vals)
```

#### Historical Simulation
Steps: 
1. Sort vector of log returns for past n days
2. Index bottom alpha percent of returns
3. Take maximum value in former indexed vector

Assume a sorted log return vector, v, with the following attributes:
- n = 100
- a = 0.05
- lowest_5 = (-0.50, -0.18, -0.10, -0.08, -0.07)

Thus, the VaR = max(lowest_5) = -0.07. This means we have 95% confidence that over the next period the portfolio will not lose more than 7%.

## To Do
1. Rename and document portfolio dataframe
2. Program function for Historical Simulation technique
3. Program Conditional VaR (CVaR) function
4. Add portfolio weights into VaR calculation
5. Document VaR functions
6. Write Bloomberg API data import functions
7. Research techniques to apply VaR to Fixed-Income Portfolio
8. Test VaR for CFE Portfolios
9. Analyze and document results of VaR test in (8.)
