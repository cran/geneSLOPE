% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clump_snps.R
\name{clump_snps}
\alias{clump_snps}
\title{Clumping procedure for SLOPE}
\usage{
clump_snps(screenResult, rho = 0.5, pValues = NULL, verbose = TRUE)
}
\arguments{
\item{screenResult}{object of class \code{\link{screeningResult}}.}

\item{rho}{numeric, minimal correlation between two SNPs to be assigned to one clump.}

\item{pValues}{numeric vector, p-values for SNPs computed outside geneSLOPE,
eg. with EMMAX.}

\item{verbose}{logical, if TRUE (default) progress bar is shown.}
}
\value{
object of class \code{\link{clumpingResult}}. 
See the class documentation for details.
}
\description{
Clumping procedure performed on SNPs, columns of matrix \code{X}, from
object of class \code{\link{screeningResult}},
which is an output of function \code{\link{screen_snps}}.
SNPs are clustered based on their correlations. For details see package vignette.
}
