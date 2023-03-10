% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ecm.R
\name{ECM2ARDL}
\alias{ECM2ARDL}
\title{Convert ECM coefficients to an equivalent ARDL}
\usage{
ECM2ARDL(
  dx.coef.list = NULL,
  dy.coef.vec = NULL,
  ECT,
  long.run,
  intercept = 0,
  varnames = NULL,
  minus = TRUE
)
}
\arguments{
\item{dx.coef.list}{A list of named numeric vectors of coefficients on contemporaneous and lagged regressor differences (\code{Dx[t-0]}, \code{Dx[t-1]}, ...).}

\item{dy.coef.vec}{A numeric vector of coefficients on lagged dep. var. differences (\code{Dy[t-1]}, \code{Dy[t-2]}, ...).}

\item{ECT}{A numeric scalar: coefficient on the ECT (adjustment strength). For stable models, must be between -2 and 0 (0 means that there is no error correction).}

\item{long.run}{A named numeric vector of coefficients on the lagged regressor levels (\code{x[t-1]}).}

\item{intercept}{A numeric scalar corresponding to the constant in the equation. Is returned in the final list without any changes.}

\item{varnames}{A character vector for human-readable variable names.}

\item{minus}{If `TRUE`, treats `long.run` as the long-run coefficient estimates `alpha` from the regression
`Y[t] = X[t]'alpha + U`, and the error-correction equation has those terms with the minus sign:
`dY[t] = ... + gamma*(Y[t-1] - X[t-1]'alpha)`. If `FALSE`, treats them with the opposite sign, e.g. assuming that
user implied the OLS-estimable form `dY[t] = ... + gamma*Y[t-1] + X[t-1]'(gamma*alpha)`.

In many applications, a simple error-correction model is estimated that is specified as follows:

\deqn{\Delta Y_{t} = \mu + \sum_{i=1}^p \rho_i \Delta Y_{t-i} + \sum_{j=0}^q \Delta X_{t-j} + \gamma(Y_{t-1} - X_{t-1}'\alpha) + \varepsilon}

Its terms can be rearranged into an equivalent ARDL model:

\deqn{Y_t = \mu + (1 + \rho_1 + \gamma)Y_{t-1} + \sum_{i=2}^p (-\rho_{i-1} + \rho_i)Y_{t-i} + (-\rho_p)Y_{t-p-1} +}

\deqn{\beta_0 X_t + (-\beta_0 + \beta_1 - \gamma \alpha) X_{t-1} + \sum_{j=2}^q (-\beta_{j-1} + \beta_j) X_{t-j} + (-\beta_q) X_{t-q-1} + \varepsilon}

For example, a very common ECM(1) model

\deqn{\Delta y_t =  \mu  + \rho \Delta y_{t-1}  + \Delta x_t ' \beta  + \gamma (y_{t-1} - x_{t-1}'\alpha)  + \varepsilon_t}

can be represented as

\deqn{y_t =  \mu + \rho_1 y_{t-1}  + \rho_2 y_{t-2}  + x_t' \beta_0  + x_{t-1}' \beta_1  + \varepsilon_t}

If some elements of the DL structure, there is no need to include zeros (i.e. `exog.lag = list(c(x1 = .3, x2 = .4), c(x1 = .5, x3 = .6))`).}
}
\value{
A list of AR coefficient vector and DL coefficient list.
}
\description{
Convert ECM coefficients to an equivalent ARDL
}
\examples{
# Imagine an error-correction model:
# dY = 0.2*dY(-1) + 0.9*dX1 + 0.2*dX2 - 0.8(Y(-1) - 1.5*X1(-1) + 0.5*X3(-1)) + U
# Its ARDL equivalent is
# Y = 0.4*Y(-1) - 0.2*Y(-2) + 0.9*X1 + 0.2*X2 + 0.3*X1(-1) - 0.2*X2(-1) - 0.4*X3(-1) + U
rho <- 0.2
dx <- c(x1 = 0.9, x2 = 0.2)
ECT <- -0.8
lx <- c(x1 = 1.5, x3 = -0.5)
ARDL.coef <- ECM2ARDL(dx.coef.list = dx, dy.coef.vec = rho, ECT = ECT, long.run = lx)
ARDL.coef
}
