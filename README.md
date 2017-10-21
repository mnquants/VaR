# Value at Risk (VaR)

## Resources
1. [Why Log Returns](https://quantivity.wordpress.com/2011/02/21/why-log-returns/)
2. [R Resources (Free Courses, Books, Tutorials, & Cheatsheets)](https://paulvanderlaken.com/2017/08/10/r-resources-cheatsheets-tutorials-books/)

## Formula
VaR = [mean - (Z * sigma)] * pi
- mean = Expected portfolio return
- sigma = Expected portfolio standard deviation
- Z = Z-Score of (1 - a), where a is the confidence level
- pi = Portfolio value

## Application
Assume an initial portfolio value of $1000.00. Assume we have a 95% confidence level (a = 0.05). 
Assume the following:
- mean = 0.04
- sigma = 0.05
- Z = 1.65
- pi = $1000.00
VaR = [0.04 - (1.65 * 0.05)] * $1000.00 = - $42.5 or - 4.25%
This means we have 95% confidence that over the next year the portfolio will not lose more than $42.5.
