% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geneSLOPE.R
\docType{package}
\name{geneSLOPE}
\alias{geneSLOPE}
\title{Genome-Wide Association Study with SLOPE}
\description{
Package geneSLOPE performes genome-wide association study (GWAS) with \pkg{\link{SLOPE}},
short for Sorted L-One Penalized Estimation. SLOPE is a
method for estimating the vector of coefficients in linear model. For details
about it see references.
}
\details{
GWAS is split into three steps:
\itemize{
\item In the first step data is read using \pkg{\link{bigmemory}} package and immediatly
screened using marginal tests for each Single Nucleotide Polymorphism (\emph{SNP})
\item SNPs are clumped based on their correlations
\item SLOPE is performed on data where each clump has
one representative (therefore we ensure that variables in linear model
are not strongly correlated)
}
Version: 0.38.2
}
\examples{
\donttest{
famFile <- system.file("extdata", "plinkPhenotypeExample.fam", package = "geneSLOPE")
mapFile <- system.file("extdata", "plinkMapExample.map", package = "geneSLOPE")
snpsFile <- system.file("extdata", "plinkDataExample.raw", package = "geneSLOPE")
phe <- read_phenotype(filename = famFile)
screening.result <- screen_snps(snpsFile, mapFile, phe, pValMax = 0.05, chunkSize = 1e2)
clumping.result <- clump_snps(screening.result, rho = 0.3, verbose = TRUE)
slope.result <- select_snps(clumping.result, fdr=0.1)

}

if(interactive()) { gui_geneSLOPE() }
}
\references{
\emph{SLOPE -- Adaptive Variable Selection via Convex Optimization},
Malgorzata Bogdan, Ewout van den Berg, Chiara Sabatti,
Weijie Su and Emmanuel Candes
}
\author{
{
Malgorzata Bogdan, Damian Brzyski, Emmanuel J. Candes, Christine Peterson, Chiara Sabatti, Piotr Sobczyk

Maintainer: Piotr Sobczyk \email{pj.sobczyk@gmail.com}
}
}
