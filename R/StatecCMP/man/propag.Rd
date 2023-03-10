% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ecm.R
\name{computePropag}
\alias{computePropag}
\alias{printContrib}
\title{Compute shock propagation and contributions with real data}
\usage{
computePropag(
  endog.lag,
  exog.lag,
  intercept = 0,
  data,
  dep.var.name = NULL,
  xnames = NULL,
  mult = 1,
  resid.name = "residual",
  francais = TRUE
)

printContrib(
  x,
  time.labels = NULL,
  var.labels = NULL,
  digits = 1,
  zero.replace = TRUE,
  sums = TRUE,
  rownames = TRUE,
  excel = TRUE,
  francais = TRUE,
  groups = NULL,
  type = c("byyear", "bytype", "twocolumn")
)
}
\arguments{
\item{endog.lag}{Passed to [genDynMult()].}

\item{exog.lag}{Passed to [genDynMult()].}

\item{intercept}{Passed to [genDynMult()].}

\item{data}{A data frame or matrix with with the regressors (`colnames(d)` must have all the names of the `exog.lag` vectors).}

\item{dep.var.name}{If not NULL, use this variable from `data` as the observed values to compute the residuals.
Corresponds to the *level* of the variable (i.e. the ARDL dependent variable), not the difference.}

\item{xnames}{Passed to [genDynMult()].}

\item{mult}{A numeric scalar or vector: multiplier(s) for the units of change; 100 yields percentages. Another useful option is apply(data, 2, sd).}

\item{resid.name}{A label how to denote the residuals.}

\item{francais}{Logical: if TRUE, the column names will be in French.

The argument `exog.lag` should be a list of named coefficient vectors. These names must
exist as variables in the data set.}

\item{x}{A list of matrices each of which was returned by computePropag}

\item{time.labels}{A character vector of time period names (e.g. years)}

\item{var.labels}{A character vector of variable names}

\item{digits}{Integer: how many decimal places to keep (more than 1 could be false precision)}

\item{zero.replace}{Logical: print a dash instead of a 0 if the variable is exactly equal to 0 (to distinguish: 0.0 could be 0.004, whilst '---' is really less than 0.00000001)?}

\item{sums}{Logical: append row sums at the end?}

\item{rownames}{Logical: prepend variable names at the beginning?}

\item{excel}{Logical: use tabs instead of '&' for copy-pasting into Excel? If FALSE, adds TeX symbols}

\item{groups}{A named list containing column names of `x` to be treated added up to and treated as one variable, e.g. `groups = list(time_dum = c("c1", "c2"), unemp = c("r_ubit", "nawru"))`}

\item{type}{A string: `"byyear"` to output tables by year, `"bytype"` by contemporaneous remaining effect, `"twocolumn"` to output two columns (short and long term)}
}
\value{
A numeric matrix containing the contribution by period type.

Prints the output to console. Returns an invisible list of short-term and long-term contributions.
}
\description{
Compute shock propagation and contributions with real data
}
\examples{
# Imagine an error-correction model:
# dY = 10 + 0.2*dY(-1) + 0.9*dX1 + 0.2*dX2 - 0.8(Y(-1) - 1.5*X1(-1) + 0.5*X3(-1)) + U
# Its ARDL equivalent is
# Y = 10 + 0.4*Y(-1) - 0.2*Y(-2) + 0.9*X1 + 0.2*X2 + 0.3*X1(-1) - 0.2*X2(-1) - 0.4*X3(-1) + U
b <- ECM2ARDL(c(X1=0.9, X2=0.2), 0.2, -0.8, c(X1=1.5, X3=-0.5), intercept = 10)
d <- simARDL(endog.lag = b$AR, exog.lag = b$DL, intercept = 10, n = 100)
lm(Y ~ myLag(Y) + myLag(Y, 2) + X1 + X2 + X3 +
       myLag(X1) + myLag(X2) + myLag(X3), data = d)
prpg <- computePropag(endog.lag = b$AR, exog.lag = b$DL, dep.var.name = "Y",
                      data = d, mult = 100)
prpg[[100]] # mult = 100 yields percentage points
all.equal(sum(prpg[[100]][3, ] / 100), diff(d$Y)[99]) # The decomposition adds up
contrib.matrices <- quiet(printContrib(prpg, sums = FALSE, type = "twocolumn"))
contrib.total <- t(contrib.matrices$ST + contrib.matrices$LT)
round(tail(contrib.total), 1)
ctotal <- rowSums(contrib.total / 100)
plot(myDiff(d$Y), bty = "n", main = "Growth rates", type = "l", ylab = "", lwd = 3)
lines(ctotal, col = 2)
logScale <- function(x) {x <- log(abs(x), 10); x[is.nan(x)] <- 0; x}
plot(logScale(myDiff(d$Y) - ctotal), bty = "n", main = "Discrepancy (log10)", type = "l")
}
\seealso{
[genDynMult()] is the workhorse used to compute the dynamic multipliers
based on the coefficients.
}
