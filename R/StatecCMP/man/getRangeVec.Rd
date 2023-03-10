% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generic.R
\name{getRangeVec}
\alias{getRangeVec}
\title{Get the first and last non-missing observation and the number of NAs}
\usage{
getRangeVec(x)
}
\arguments{
\item{x}{A vector of any type}
}
\value{
A vector: the index of the first non-NA observation,
the index of the last non-NA observation, total valid observations,
the number of middle NA sequences, and their total count (middle NAs only)
}
\description{
Get the first and last non-missing observation and the number of NAs
}
\examples{
getRangeVec(c(NA, NA, 1:3, NA, 1:3, NA, NA, 2, NA))
}
