\name{FMstable}
\alias{FMstable}
\alias{dFMstable}
\alias{pFMstable}
\alias{pFMstable.alpha0}
\alias{qFMstable}
\alias{tailsFMstable}
\title{Finite Moment Log Stable Distributions}
\description{
  Density function, distribution function, and quantile function
  for a log stable distribution with
  location, scale and shape parameters.  For such families of
  distributions all moments are finite.  Carr and Wu (2003) refer to
such distributions as ``finite moment log stable processes''.

  The finite moment log stable distribution is well-defined for
\eqn{\alpha=0}{alpha=0},
when the distribution is discrete with probability concentrated at x=0
and at one other point.  The distribution function may be
computed by \code{pFMstable.alpha0}.
}
\usage{
  dFMstable(x, stableParamObj, log=FALSE) 
  pFMstable(x, stableParamObj, log=FALSE, lower.tail=TRUE)
  pFMstable.alpha0(x, mean=1, sd=1, lower.tail=TRUE)
  qFMstable(p, stableParamObj, lower.tail=TRUE)
  tailsFMstable(x, stableParamObj)
}
\arguments{
  \item{x}{Vector of quantiles.}
  \item{stableParamObj}{An object of class \code{stableParameters} which
    describes a maximally skew stable distribution.   It may, for
    instance, have been created by \code{\link{setMomentsFMstable}} or
    \code{\link{fitGivenQuantile}}.}
  \item{mean}{Mean of logstable distribution.}
  \item{sd}{Standard deviation of logstable distribution.}
  \item{p}{Vector of tail probabilities.}
  \item{log}{Logical; if \code{TRUE}, the log density or log tail
    probability is returned by functions \code{dFMstable} and
\code{pFMstable}; and logarithms of probabilities are input to function
\code{qFMstable}. }
  \item{lower.tail}{Logical; if \code{TRUE}, the lower tail probability
    is returned.  Otherwise, the upper tail probability.}
}
\details{
  The values are worked out by interpolation, with several different
  interpolation formulae in various regions.
}
\value{
  \code{dFMstable}{ gives the density function;}
  \code{pFMstable}{ gives the distribution function or its complement;}
  \code{qFMstable}{ gives quantiles;}
  \code{tailsFMstable}{  returns a list with the following components
    which are all the same length as \code{x}:
    \describe{
    \item{density}{The probability density function.}
    \item{F}{The probability distribution function.  i.e. the
      probability of being less than or equal to \code{x}.}
    \item{righttail}{The probability of being larger than \code{x}.}
    \item{logdensity}{The probability density function.}
    \item{logF}{The logarithm of the probability of being less than
      or equal to \code{x}.}
    \item{logrighttail}{The logarithm of the probability of being
      larger than \code{x}.}
    }
  }
}

\references{
  Carr, P. and Wu, L. (2003). The Finite Moment Log Stable Process and
  Option Pricing. Journal of Finance, American Finance Association, vol. 58(2), pages 753-778
}

\seealso{If a random variable \eqn{X} has a finite moment stable
distribution then \eqn{\log(X)}{log(X)} has the corresponding extremal stable
distribution.  The density of \eqn{\log(X)}{log(X)} can be found using
\code{\link{dEstable}}.
Option prices can be found using \code{\link{callFMstable}} and
\code{\link{putFMstable}}.
}

\examples{
tailsFMstable(1:10, setMomentsFMstable(3, 1.5, alpha=1.7))

x <- c(0, 1.e-5, .001, .01, .03, seq(from=.1, to=4.5, length=100))
plot(x, pFMstable(x, setMomentsFMstable(1, 1.5, 2)), type="l",
  ylim=c(0,1), ylab="Distribution function")
for (alpha in c(.03, 1:19/10)) lines(x, pFMstable(x,
  setMomentsFMstable(1, 1.5, alpha)), col=2)
lines(x, pFMstable.alpha0(x, mean=1, sd=1.5), col=3)

p <- c(1.e-10, .01, .1, .2, .5, .99, 1-1.e-10)
obj <- setMomentsFMstable(alpha=1.95)
result <- qFMstable(p, obj)
OK <- result > 0
pFMstable(result[OK], obj) - p[OK]
}

\keyword{distribution}
