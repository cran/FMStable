\name{stableParameters}
\alias{stableParameters}
\alias{stable}
\alias{setParam}
\alias{setMomentsFMstable}
\alias{fitGivenQuantile}
\alias{matchQuartiles}
\alias{print.stableParameters}
\title{Setting up Parameters to Describe both Extremal Stable Distributions
and Finite Moment Log Stable Distributions}
\description{
Functions which create stable distributions having specified
properties.  Each of these functions takes scalar arguments and produces
a description of a single stable distribution.
}
\usage{
setParam(alpha, oneminusalpha, twominusalpha, location, logscale, pm)
setMomentsFMstable(mean=1, sd=1, alpha, oneminusalpha, twominusalpha)
fitGivenQuantile(mean, sd, prob, value, tol=1.e-10)
matchQuartiles(quartiles, alpha, oneminusalpha, twominusalpha, tol=1.e-10)
}
\arguments{
  \item{alpha}{Stable distribution parameter which must be a single
value satisfying \eqn{0 < \alpha <= 2}.}
  \item{oneminusalpha}{Alternative specification of stable distribution
parameter: Specify 1-alpha.}
  \item{twominusalpha}{Alternative specification of stable distribution
parameter: Specify 2-alpha.}
  \item{location}{Location parameter of stable distribution.}
  \item{logscale}{Logarithm of scale parameter of stable distribution.}
  \item{pm}{Parametrization used in specifying stable distribution
which is maximally skewed to the right.  Allowable values are 0, "S0", "M",
1, "S1", "A", 2, "CMS" or "C" for some common parametrizations.}
  \item{mean}{Mean of logstable distribution.}
  \item{sd}{Standard deviation of logstable distribution.}
  \item{value, prob}{Required probability distribution function (> 0) for a
logstable distribution at a value (> 0).}
  \item{quartiles}{Vector of two quartiles to be matched by a
logstable distribution.}
  \item{tol}{Tolerance for matching of quantile or quartiles.}
}
\details{
  The parametrizations used internally by this package are Nolan's "S0"
(or Zolotarev's "M") parametrization when \code{alpha} >= 0.5, and
the Zolotarev's "C" parametrization (which was used by Chambers, Mallows
and Struck (1976) when \code{alpha} < 0.5.

By using objects of class \code{stableParameters} to store descriptions
of stable distributions, it will generally be possible to write code in a way
which is not affected by the internal representation.
Such usage is encouraged.
}
\value{
  Each of the functions described here produces an object of class
  \code{stableParameters} which describes a maximally skew stable
  distribution.  Its components include at least the shape parameter
  \code{alpha}, a location parameter referred to as \code{location} and
  the logarithm of a scale parameter referred to as \code{logscale}.  

    Currently objects of this class also store information about how they
were created, as well as storing the numbers 1-\code{alpha}
and 2-\code{alpha} in order to improve computational precision.}

\references{
Chambers, J.M.,  Mallows, C.L. and Stuck, B.W. (1976). A method for
simulating stable random variables. Journal of the American
Statistical Association, Vol. 71, 340--344.

Nolan, J.P. (2012). Stable Distributions. ISBN 9780817641597

Zolotarev, V.M. (1986). One-Dimensional Stable Distributions.
Amer. Math.  Soc. Transl. of Math. Monographs, Vol. 65.  Amer Math. Soc.,
Providence, RI. (Original Russian version was published in 1983.)

}

\seealso{Extremal stable distributions with parameters set up using
these procedures can be used by functions such as
\code{\link{dEstable}}.  The corresponding finite moment log stable
distributions can be dealt with using functions such as \code{\link{dFMstable}}.
}

\examples{
setParam(alpha=1.5, location=1, logscale=-.6, pm="M")
setParam(alpha=.4, location=1, logscale=-.6, pm="M")
setMomentsFMstable(alpha=1.7, mean=.5, sd=.2)
fitGivenQuantile(mean=5, sd=1, prob=.001, value=.01, tol=1.e-10)
fitGivenQuantile(mean=20, sd=1, prob=1.e-20, value=1, tol=1.e-24)
matchQuartiles(quartiles=c(9,11), alpha=1.8)
}
\keyword{distribution}
