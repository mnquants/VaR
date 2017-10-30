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
10.[Risk Management for Fixed Income Portfolios - Credit Suisse](https://www.credit-suisse.com/media/am/docs/asset_management/events/2014/fits2014-program/3-5-2-traband-risk-management.pdf)

## Formula(s)
#### Parametric
VaR = [mean - (Z * sigma)] * pi
- mean = Expected portfolio return
- sigma = Expected portfolio standard deviation
- Z = Z-Score of (1 - a), where a is the confidence level
- pi = Portfolio value

Assume an initial portfolio value of $1000.00. Assume we have a 95% confidence level (a = 0.05). 
Assume the following:
- mean = 0.04
- sigma = 0.05
- Z = 1.65
- pi = $1000.00

Thus, VaR = [0.04 - (1.65 * 0.05)] * $1000.00 = - $42.5 or - 4.25%. This means we have 95% confidence that over the next year the portfolio will not lose more than $42.5.

#### Monte Carlo
Ri = [mean * (delta_t) + sigma * (epsilon) * (sqrt (delta_t))]
- mean = Expected portfolio return
- sigma = Expected portfolio standard deviation
- delta_t = time (days) to forecast VaR into the future
- epsilon = vector of random numbers generated from a normal distribution 

```
n <- 10000            # number of trials
epsilon <- rnorm(n)   # vector of random standard normal distribution values
mean <- 0.1           # Expected portfolio return
sigma <- 0.25         # Expected portfolio standard deviation
delta_t <- 1          # 1 day forecast

sim_returns <- mean*delta_t + sigma*epsilon*sqrt(delta_t)
```

As the number of simulated returns increases (n in rnorm(n)), the distribution forecast more closely matches a normal distribution. In order to get the expected VaR given some confidence interval, 1 - a, apply the following function in R:

```
a <- c(0.01,0.05)
quantile(sim_returns, a)
```

#### Historical Simulation
