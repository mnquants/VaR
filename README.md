# Value at Risk (VaR)

## Resources
1. [Why Log Returns - Quantivity](https://quantivity.wordpress.com/2011/02/21/why-log-returns/)
2. [Value at Risk - Investopedia](http://www.investopedia.com/terms/v/var.asp)
3. [Approaches to VaR - Stanford](https://web.stanford.edu/class/msande444/2012/MS&E444_2012_Group2a.pdf)
4. [Uniform Distribution - R](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Uniform.html)
5. [Monte Carlo Method in R - alookanalytics blog](https://blog.alookanalytics.com/2017/04/26/monte-carlo-method-in-r/)
6. [Calculating VaR with R - R-Bloggers](https://www.r-bloggers.com/calculating-var-with-r/)
7. [Monte Carlo Package - R](https://cran.r-project.org/web/packages/MonteCarlo/MonteCarlo.pdf)

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

#### Historical Simulation
