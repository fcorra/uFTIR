#' Mosaic chunk
#' 
#' The function read a single mosaic tile (.dmd file extension) using a \code{\link[=SpectralInfo-class]{SpectralInfo}} object as a guide to find the file. It returns an object of class \code{\link[=Tile-class]{Tile}}, which can be (pre/post)processed as if it were a single tile.
#'
#' @param info \code{\link[=SpectralInfo-class]{SpectralInfo}} object.
#' @param dmdfile tarjet .dmd file to read.
#'
#' @return
#' A \code{\link[=Tile-class]{Tile}} object.
#' 
#' @export
#' @examples
#' x <- mosaic_info(base::system.file("extdata/mosaic.dmt", package = "uFTIR"))
#' y <- mosaic_chunk(x, "mosaic_0000_0000.dmd")
#' class(y)
mosaic_chunk <- function(info, dmdfile){
  
  dmdfile <-  paste(info@path, dmdfile, sep = .Platform$file.sep)
  chunk <- mosaic_read_chunk(dmdfile, info@fpasize, length(info@wavenumbers))
  
  new("Tile",
      file = info@file,
      date = info@date,
      fpasize = info@fpasize,
      Spectra = chunk,
      wavenumbers = info@wavenumbers,
      path = info@path
  )
}