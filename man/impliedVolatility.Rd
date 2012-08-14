\name{impliedVolatility}
\alias{BSOptionValue}
\alias{ImpliedVol}
\alias{lnorm.param}
\title{Computations Regarding Value of Options for Log Normal Distributions}
\description{Computes values of European-style call and put options over
assets whose future price is expected to follow a log normal distribution.
}
\usage{
BSOptionValue(spot, strike, expiry, volatility,
  intRate=0, carryCost=0, Call=TRUE)
ImpliedVol(spot, strike, expiry, price, intRate=0, carryCost=0,
  Call=TRUE, ImpliedVolLowerBound=.01, ImpliedVolUpperBound=1, tol=1.e-9)
lnorm.param(mean, sd) 
}
\arguments{
  \item{spot}{The current price of a security.}
  \item{strike}{The strike price for an option.}
  \item{expiry}{The time when an option may be exercised.  (We are only
dealing with European options which have a single date on which they may
be exercised.)}
  \item{volatility}{The volatility of the price of a security per unit
time.  This is the standard deviation of the logarithm of price.}
  \item{price}{The price for an option.  This is used as an input
parameter when computing the implied volatility.} 
  \item{intRate}{The interest rate.}
  \item{carryCost}{The carrying cost for a security. This may be
negative when a security is expected to pay a dividend.}
  \item{Call}{Logical: Whether the option for which a \code{price} is
given is a call option.}
  \item{ImpliedVolLowerBound}{Lower bound used when searching for the
inplied volatility.}
  \item{ImpliedVolUpperBound}{Upper bound used when searching for the
inplied volatility.}
  \item{tol}{Tolerance specifying accuracy of search for implied
volatility.}
  \item{mean}{The mean of a quantity which has a lognormal distribution.}
  \item{sd}{The standard deviation of a quantity which has a
lognormal distribution.}
}

\details{
The lognormal distribution is
the limit of finite moment log stable distributions as \code{alpha} tends to
2.  The function \code{lnorm.param} finds the mean and standard
deviation of a lognormal distribution on the log scale given the mean
and standard deviation on the raw scale.  The function
\code{BSOptionValue} finds the value of a European call or put option.
The function \code{ImpliedVol} allows computation of the implied
volatility, which is the volatility on the logarithmic scale which
matches the value of an option to a specified price.
}

\value{
\code{impVol} returns the implied volatility when the value of options
is computed using a finite moment log stable distribution.
\code{approx.impVol} returns an approximation to the implied volatility.
\code{lnorm.param} returns the mean and standard deviation of the
underlying normal distribution.
}

\seealso{Option prices computed using the log normal model can be
compared to those computed for the finite moment log stable model
using \code{\link{putFMstable}} and \code{\link{callFMstable}}.
}

\examples{
lnorm.param(mean=5, sd=.8) 
BSOptionValue(spot=4, strike=c(4, 4.5), expiry=.5, volatility=.15)
ImpliedVol(spot=4, strike=c(4, 4.5), expiry=.5, price=c(.18,.025))
}

\keyword{distribution}
