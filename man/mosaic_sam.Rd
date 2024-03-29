% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mosaic_sam.R
\name{mosaic_sam}
\alias{mosaic_sam}
\title{Mosaic SAM}
\usage{
mosaic_sam(
  info,
  sref,
  derivative = NULL,
  base_corr = TRUE,
  FUN = NULL,
  n_cores = NULL,
  temporal = FALSE
)
}
\arguments{
\item{info}{\code{\link[=SpectralInfo-class]{SpectralInfo}} object.}

\item{sref}{\code{\link[=SpectralReference-class]{SpectralReference}} object.}

\item{derivative}{whether to apply the first (1) or second (2) derivative before sam. Default NULL.}

\item{base_corr}{TRUE/FALSE should \code{\link{tile_base_corr}} be call before processing each chunk?}

\item{FUN}{A function to be passed to \code{\link{preprocess}}.It is always applied as if 'data' were a \code{\link[=SpectralPack-class]{SpectralPack}} object.}

\item{n_cores}{The number of cores to parallelize the task. NULL means all cores -1.}

\item{temporal}{Whether the file should be written in a temporal folder or in the folder where the main file lives.}
}
\value{
The folder path where the files where written
}
\description{
The function performs the spectral angle mapper algorithm chunk by chunk for the mosaics files. It uses the parallel package, and by default all cores -1.

The function uses \code{\link{mosaic_chunk}} to cast a mosaic tile as a \code{\link[=Tile-class]{Tile}} object. Then performs a \code{\link{tile_base_corr}}, \code{\link[=TileRead.wavealign]{wavealing}}, and \code{\link{tile_sam}} to finaly write binary files that hold the Spectral Angle Mapper results in the destination folder (path slot of the \code{\link[=SpectralInfo-class]{SpectralInfo}} object). The files can be loaded back to R using \code{link{mosaic_compose}}.

The function is using the parallel package, as each tile_sam takes a while to complete.
}
\examples{
x <- mosaic_info(base::system.file("extdata/mosaic.dmt", package = "uFTIR"))
mosaic_sam(x, primpke, n_cores = 1, temporal = TRUE)
}
\seealso{
For a single tile application see \code{\link{tile_sam}}.
}
