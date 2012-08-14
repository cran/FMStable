\name{Gstable}
\alias{Gstable}
\alias{tailsGstable}
\title{General Stable Distributions}
\description{
A procedure based on the \R function \code{integrate} for computing the
distribution function for stable distributions
which may be skew but have standard location and scale parameters.
This computation is not fast.

It is not designed to work for \code{alpha} near to 1.
}

\usage{
tailsGstable(x, logabsx, alpha, oneminusalpha, twominusalpha, 
  beta, betaplus1, betaminus1, parametrization, lower.tail=TRUE)
}

\arguments{
  \item{x}{Value (scalar).}
  \item{logabsx}{Logarithm of absolute value of x.  Must be used when x
is outside the range over which numbers can be stored. (e.g. 1.e-5000)}
  \item{alpha}{Value of parameter of stable distribution.}
  \item{oneminusalpha}{Value of alpha.  This should be specified when
alpha is near to 1 so that the difference from 1 is specified
accurately.}
  \item{twominusalpha}{Value of 2 - alpha.  This should be specified when
alpha is near to 2 so that the difference from 2 is specified
accurately.}
  \item{beta}{Value of parameter of stable distribution.}
  \item{betaplus1}{Value of beta + 1.  This should be specified when
beta is near to -1 so that the difference from -1 is specified accurately.}
  \item{betaminus1}{Value of beta - 1.  This should be specified when
beta is near to 1 so that the difference from 1 is specified accurately.}
  \item{parametrization}{Parametrization: 0 for Zolotarev's M = Nolan
S0, 1 for Zolotarev's A = Nolan S1 and 2 for
Zolotarev's C = Chambers, Mallows and Stuck.}
  \item{lower.tail}{Logical: Whether the lower tail of the distribution is of
primary interest.  This parameter affects whether numerical integration
is used for the lower or upper tail.  The other tail is computed by
subtraction.}
}

\note{
This code is included mainly as an illustration of a way to deal with
the problem that different parametrizations are useful in different
regions.
It is also of some value for checking other code, particularly since it
was not used as the basis for the interpolation tables.

For the C parametrization for \code{alpha} greater than 1, the parameter
\code{beta} needs to be set to -1 for the distribution to be skewed to
the right.
}

\value{
  Returns a list with the following components:
  \describe{
    \item{left.tail.prob}{The probability distribution function.  I.e. the
      probability of being less than or equal to \code{x}.}
    \item{right.tail.prob}{The probability of being larger than \code{x}.}
    \item{est.error}{An estimate of the computational error in the
previous two numbers.}
    \item{message}{A message produced by R's standard
\code{\link{integrate}} routine.}
  }
}

\references{
  Chambers, J.M., Mallows, C.L. and Stuck, B.W. (1976) A method for
simulating stable random variables. Journal of the American
Statistical Association 71, 340--344.
}

\examples{
# Check relationship between maximally skew and other stable distributions
# in paper by J.M. Chambers, C.L. Mallows and B.W. Stuck
alpha <- 1.9
beta <- -.5
k <- 1- abs(1-alpha)
denom <- sin(pi*k)
p <- (sin(.5*pi*k * (1+beta))/denom)^(1/alpha)
q <- (sin(.5*pi*k * (1-beta))/denom)^(1/alpha)
# Probability that p S1 - q S2 < x
S1 <- setParam(alpha=1.9, location=0, logscale =log(p), pm="C")
S2 <- setParam(alpha=1.9, location=0, logscale =log(q), pm="C")
S3 <- setParam(alpha=1.9, location=0, logscale =0, pm="C")
xgiven <- 1
f <- function(x) dEstable(x, S1) * pEstable(xgiven + x, S2)
print(integrate(f, lower=-Inf, upper=Inf, rel.tol=1.e-12)$value, digits=16)
f <- function(x) dEstable(x, S3) * pEstable((xgiven + p*x)/q, S3)
print(integrate(f, lower=-Inf, upper=Inf, rel.tol=1.e-8)$value, digits=16)
direct <- tailsGstable(x=xgiven, logabsx=log(xgiven),alpha=alpha,
  beta=beta, parametrization=2)
print(direct$left.tail.prob, digits=16)

# Compare Estable and Gstable
# List fractional discrepancies
disc <- function(tol){
  for(pm in pms) for (a in alphas) for(x in xs) {
    lx <- log(abs(x))
    beta <- if(pm==2 && a > 1) -1 else 1
    if(x > 0 || a > 1){
      a1 <- pEstable(x, setParam(alpha=a, location=0, logscale=0, pm=pm))
      a2 <- tailsGstable(x=x, logabsx=lx, alpha=a, beta=beta,
        parametrization=pm)$left.tail.prob
      print(paste("parametrization=", pm, "alpha=", a,"x=", x,
        "Frac disc=", a1/a2-1), quote=FALSE)
    }
  }
}

alphas <- c(.3, .8, 1.1, 1.5, 1.9)
pms <- 0:2
xs <- c(-2, .01, 4.3)
disc()
}

\keyword{distribution}

