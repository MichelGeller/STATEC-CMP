% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generic.R
\name{myTime}
\alias{myTime}
\alias{myYear}
\title{Return the decimal date with a safeguard against floating-point .9999}
\usage{
myTime(x, adjust = getOption("ts.eps"), numeric = FALSE)

myYear(x, adjust = getOption("ts.eps"), numeric = TRUE)
}
\arguments{
\item{x}{A numeric vector, matrix or data frame}

\item{adjust}{A small numeric that will be added to the decimal time (should be less than 1 / 366 / 2)}

\item{numeric}{If TRUE, convert to a real numeric vector instead of a ts.}
}
\value{
An object of the same dimensions as the input.
}
\description{
Return the decimal date with a safeguard against floating-point .9999
}
\section{Functions}{
\itemize{
\item \code{myYear()}: Safely convert a ts into integer year

}}
\examples{
x <- ts(2:252, start = c(2002, 2), freq = 12)
problem.date <- seq.Date(as.Date("2002-02-01"), to = as.Date("2022-12-01"), by = "month")
true.year <- rep(2002:2022, each = 12)[-1]
wrong.year <- floor(as.numeric(time(x)))
corrected.year <- myYear(x)
tail(data.frame(Date = as.character(problem.date), True = true.year,
                Wrong = wrong.year, Adjusted = corrected.year,
                HasDiscrepancy = abs(corrected.year - wrong.year)), 15)
}
