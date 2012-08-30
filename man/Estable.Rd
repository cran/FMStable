\name{Estable}
\alias{Estable}
\alias{dEstable}
\alias{pEstable}
\alias{qEstable}
\alias{tailsEstable}
\title{Extremal or Maximally Skew Stable Distributions}
\description{
  Density function, distribution function, quantile function
  and random generation for stable distributions which are maximally
skewed to the right.  These distributions are called Extremal by
Zolotarev (1986).
}
\usage{
  dEstable(x, stableParamObj, log=FALSE) 
  pEstable(x, stableParamObj, log=FALSE, lower.tail=TRUE)
  qEstable(p, stableParamObj, log=FALSE, lower.tail=TRUE)
  tailsEstable(x, stableParamObj)
}
\arguments{
  \item{x}{Vector of quantiles.}
  \item{stableParamObj}{An object of class \code{\link{stableParameters}} which
    describes a maximally skew stable distribution. It may, for
    instance, have been created by \code{\link{setParam}} or
    \code{\link{setMomentsFMstable}}.}
  \item{p}{Vector of tail probabilities.}
  \item{log}{Logical; if \code{TRUE}, the log density or log tail
    probability is returned by functions \code{dEstable} and
\code{pEstable}; and logarithms of probabilities are input to function
\code{qEstable}. }
  \item{lower.tail}{Logical; if \code{TRUE}, the lower tail probability
    is returned.  Otherwise, the upper tail probability.}
}
\details{
  The values are worked out by interpolation, with several different
  interpolation formulae in various regions.
}

\value{
  \code{dEstable}{ gives the density function;}
  \code{pEstable}{ gives the distribution function or its complement;}
  \code{qEstable}{ gives quantiles;}
  \code{tailsEstable}{ returns a list with the following components
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
  Chambers, J.M., Mallows, C.L. and Stuck, B.W. (1976).  A method for
simulating stable random variables. Journal of the American
Statistical Association, 71, 340--344.
}

\seealso{
If \eqn{x} has an extremal stable distribution then
\eqn{\exp(-x)}{exp(-x)} has a finite moment log stable distribution.
The left hand tail probability computed using \code{pEstable} should be
the same as the coresponding right hand tail probability computed using
\code{\link{pFMstable}}.

Aspects of extremal stable distributions may also be computed (though
more slowly) using \code{\link{tailsGstable}} with \code{beta}=1.

Functions for generation of random variables having stable distributions
are available in package \code{stabledist}.
}

\examples{
tailsEstable(-2:3, setMomentsFMstable(mean=1, sd=1.5, alpha=1.7))

# Compare Estable and FMstable
obj <- setMomentsFMstable(1.7, mean=.5, sd=.2)
x <- c(.001, 1, 10)
pFMstable(x,  obj, lower.tail=TRUE, log=TRUE)
pEstable(-log(x), obj, lower.tail=FALSE, log=TRUE)

x <- seq(from=-5, to=10, length=30)
plot(x, dEstable(x, setMomentsFMstable(alpha=1.5)), type="l", log="y",
  ylab="Log(density) for stable distribution",
  main="log stable distribution with alpha=1.5, mean=1, sd=1" )

x <- seq(from=-2, to=5, length=30)
plot(x, x, ylim=c(0,1), type="n", ylab="Distribution function")
for (i in 0:2)lines(x, pEstable(x,
  setParam(location=0, logscale=-.5, alpha=1.5, pm=i)), col=i+1)
legend("bottomright", legend=paste("S", 0:2, sep=""), lty=rep(1,3), col=1:3)

p <- c(1.e-10, .01, .1, .2, .5, .99, 1-1.e-10)
obj <- setMomentsFMstable(alpha=1.95)
result <- qEstable(p, obj)
pEstable(result, obj) - p

# Plot to illustrate continuity near alpha=1
y <- seq(from=-36, to=0, length=30)
logprob <- -exp(-y)
plot(0, 0, type="n", xlim=c(-25,0), ylim=c(-35, -1),
  xlab="x (M parametrization)", ylab="-log(-log(distribution function))")
for (oneminusalpha in seq(from=-.2, to=0.2, by=.02)){
  obj <- setParam(oneminusalpha=oneminusalpha, location=0, logscale=0, pm=0)
  type <- if(oneminusalpha==0) 2 else 1
  lines(qEstable(logprob, obj, log=TRUE), y, lty=type, lwd=type)
}
}

\keyword{distribution}
