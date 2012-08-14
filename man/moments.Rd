\name{moments}
\alias{iidcombine}
\alias{moments}
\title{Convolutions of Finite Moment Log Stable Distributions and the
Moments of such Distributions}
\description{
If \eqn{X_1, \dots , X_n} are independent random variables with the same stable
distribution then \eqn{X_1+ \dots +X_n} has a stable distribution with the same
alpha.  The function \code{iidcombine} allows the parameters of the
resulting stable distribution to be computed.
Because stable distributions are infinitely divisible, it is also easy
to find the parameters describing the distribution of \eqn{X_1} from the
parameters describing the distribution of \eqn{X_1+ \dots +X_n}.

Convolutions of maximally skew stable distributions correspond to
products of logstable distributions.  The raw moments of these distributions
(i.e. moments about zero, not moments about the mean)
can be readily computed using the function \code{moments}.
Note that the raw moments of the convolution of two independent
distributions are the products of the corresponding moments of the
component distributions, so the accuracy of \code{iidcombine} can be
checked by using \code{moments}.
}
\usage{
iidcombine(n, stableParamObj)
moments(powers, stableParamObj, log=FALSE)
}
\arguments{
  \item{n}{Number of random variables to be convoluted.  May be any
positive number.}
  \item{powers}{Raw moments of logstable distributions to be computed.}
  \item{stableParamObj}{An object of class \code{stableParameters} which
    describes a maximally skew stable distribution.}
  \item{log}{Logical; if \code{TRUE}, the logarithms of moments are returned.}
}
\value{
  The value returned by \code{iidcombine}
is another object of class \code{stableParameters}.
  The value returned by \code{moments} is a numeric vector
giving the values of the specified raw moments.
}

\seealso{Objects of class \code{stableParameters} can be created using
functions such as \code{\link{setParam}}.
The taking of convolutions is sometimes associated with the computing of
values of options using functions such as \code{\link{callFMstable}}.}

\examples{
yearDsn <- fitGivenQuantile(mean=1, sd=2, prob=.7, value=.1)
upper <- exp(-yearDsn$location)	# Only sensible for alpha<.5
x <- exp(seq(from=log(.0001), to=log(upper), length=50))
plot(x, pFMstable(x, yearDsn), type="l", ylim=c(.2,1), lwd=2, xlab="Price",
  ylab="Distribution function of future price")
half <- iidcombine(.5, yearDsn)
lines(x, pFMstable(x, half), lty=2, lwd=2)
quarter <- iidcombine(.25, yearDsn)
lines(x, pFMstable(x, quarter), lty=3, lwd=2)
legend("bottomright", legend=paste(c("1","1/2","1/4"),"year"), lty=c(1,2,3),
  lwd=c(2,2,2))
moments(1:2, yearDsn)
moments(1:2, half)
moments(1:2, quarter)

# Check logstable against lognormal
iidcombine(2, setMomentsFMstable(.5, .2, alpha=2))
p <- lnorm.param(.5, .2)
2*p$meanlog		# Gives the mean
log(p$sdlog)	# Gives the logscale
}

\keyword{distribution}
