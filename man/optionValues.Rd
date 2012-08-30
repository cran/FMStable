\name{optionValues}
\alias{putFMstable}
\alias{callFMstable}
\alias{optionsFMstable}
\title{Values of Options over Finite Moment Log Stable Distributions}
\description{Computes values of European-style call and put options over
assets whose future price is expected to follow a finite moment log
stable distribution.
}
\usage{
putFMstable(strike, paramObj, rel.tol=1.e-10)
callFMstable(strike, paramObj, rel.tol=1.e-10)
optionsFMstable(strike, paramObj, rel.tol=1.e-10)
}
\arguments{
  \item{strike}{The strike price for an option.}
  \item{paramObj}{An object of class \code{stableParameters} which
    describes a maximally skew stable distribution.  This is the
distribution which describes possible prices for the underlying security
at the time of expiry.}
  \item{rel.tol}{The relative tolerance used for numerical integration
for finding option values.}
}

\note{
When comparing option values based on finite moment log stable
distributions with ones based on log normal distributions, remember that
the interest rate and holding cost have been ignored here.

Rather than using functions \code{putFMstable} and \code{callFMstable}
for options that are extremely in-the-money (i.e. the options are almost
certain to be exercised), the values of such options can be computed
more accurately by first computing the value of the out-of-the-money
option and then using the relationship \code{spot} + \code{put} =
\code{call} + \code{strike}.  This is done by function
\code{optionsFMstable}.
}

\value{
\code{optionsFMstable} returns a list containing the values of put
options and the values of call options.
}

\seealso{An example of how an object of class \code{stableParameters}
may be created is by \code{\link{setParam}}.  Procedures for dealing with
the log normal model for options pricing include \code{\link{BSOptionValue}}.
}

\examples{
paramObj <- setMomentsFMstable(mean=10, sd=1.5, alpha=1.8)
putFMstable(c(10,7), paramObj)
callFMstable(c(10,7), paramObj)
optionsFMstable(8:12, paramObj)
# Note that call - put = mean - strike

# Values of some extreme put options
paramObj <- setMomentsFMstable(mean=1, sd=1.5, alpha=0.02)
putFMstable(1.e-200, paramObj)
putFMstable(1.e-100, paramObj)
pFMstable(1.e-100, paramObj)
putFMstable(1.e-50, paramObj)

# Asymptotic behaviour
logmlogx <- seq(from=2, to=6, length=30)
logx <- -exp(logmlogx)
x <- exp(logx)
plot(logmlogx , putFMstable(x, paramObj)/(x*pFMstable(x, paramObj)), type="l")

# Work out the values of some options using FMstable model
spot <- 20
strikes <- c(15,18:20, 20:24, 18:20, 20:23)
isCall <- rep(c(FALSE,TRUE,FALSE,TRUE), c(4,5,3,4))
expiry <- rep(c(.2, .5), c(9,7))
# Distributions for 0.2 and 0.5 of a year given distribution describing
#   multiplicative change in price over a year:
annual <- fitGivenQuantile(mean=1, sd=.2, prob=2.e-4, value=.01)
timep2 <- iidcombine(.2, annual)
timep5 <- iidcombine(.5, annual)
imp.vols <- prices <- rep(NA, length(strikes))
use <- isCall & expiry==.2
prices[use] <- callFMstable(strikes[use]/spot, timep2) * spot
use <- !isCall & expiry==.2
prices[use] <- putFMstable(strikes[use]/spot, timep2) * spot
use <- isCall & expiry==.5
prices[use] <- callFMstable(strikes[use]/spot, timep5) * spot
use <- !isCall & expiry==.5
prices[use] <- putFMstable(strikes[use]/spot, timep5) * spot
# Compute implied volatilities.
imp.vols[isCall] <- ImpliedVol(spot=spot, strike=strikes[isCall],
  expiry=expiry[isCall], price=prices[isCall], Call=TRUE)
imp.vols[!isCall] <- ImpliedVol(spot=spot, strike=strikes[!isCall],
  expiry=expiry[!isCall], price=prices[!isCall], Call=FALSE)

# List values of options
cbind(strikes, expiry, isCall, prices, imp.vols)

# Can the distribution be recovered from the values of the options?
discrepancy <- function(alpha, cv){
  annual.fit <- setMomentsFMstable(mean=1, sd=cv, alpha=alpha)
  timep2.fit <- iidcombine(.2, annual.fit)
  timep5.fit <- iidcombine(.5, annual.fit)
  prices.fit <- rep(NA, length(strikes))
  use <- isCall & expiry==.2
  prices.fit[use] <- callFMstable(strikes[use]/spot, timep2.fit) * spot
  use <- !isCall & expiry==.2
  prices.fit[use] <- putFMstable(strikes[use]/spot, timep2.fit) * spot
  use <- isCall & expiry==.5
  prices.fit[use] <- callFMstable(strikes[use]/spot, timep5.fit) * spot
  use <- !isCall & expiry==.5
  prices.fit[use] <- putFMstable(strikes[use]/spot, timep5.fit) * spot
  return(sum((prices.fit - prices)^2))
}
# Search on scales of log(2-alpha) and log(cv)
d <- function(param) discrepancy(2-exp(param[1]), exp(param[2]))
system.time(result <- nlm(d, p=c(-2,-1.5)))
# Estimated alpha
2-exp(result$estimate[1])
# Estimated cv
exp(result$estimate[2])

# Searching just for best alpha
d <- function(param) discrepancy(param, .2)
system.time(result <- optimize(d, lower=1.6, upper=1.98))
# Estimated alpha
result$minimum
}

\keyword{distribution}
