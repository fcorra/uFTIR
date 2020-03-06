## Since the output of the uFTIR is invariably a large file
## I needed toy examples. To make them, I copy the .bsp and .dmt files of a 
## tile and a mosaic, and made up the .dat and .dmd files (the ones that hold the cube)

## Here I want to show that by doing so, I get a test file that can be trusted.

# source("data-raw/checking_references.R")
load("data-raw/references/dump_refs.Rdata")

out <- array(dim = c(20,20,length(wn)))

for(i in 1:20){
  for(j in 1:20){
    out[i, j, ] <- bg
  }
}

for(i in 7:13){
  for(j in 8:15){
    out[i,j,] <- ps
  }
}

out <- c(rep(0, times = 255), as.vector(out))
rm(list = ls()[-grep("out|ps|bg|wn", ls())])
writeBin(out, "inst/extdata/tile.dat", size=4, endian = 'little')
out <- out[256:length(out)]
x <- tile_read("inst/extdata/tile.bsp")

stopifnot(
  isTRUE(sum(x@Spectra == out) == length(out))
  #[1] TRUE
)

# When plotting, all things are shifted by -1 and row / cols are inverted.
# side effect of mimic the output of the uFTIR
# the behaviour can be modified by match_uFTIR = FALSE [now default]
plot(x, match_uFTIR = TRUE)
abline(h=c(7,13), v=c(8,15), col = "blue") # it should be here
abline(h=c(7,15), v=c(6,13), col = "red", lty = 2) # but is here

plot(x, match_uFTIR = FALSE)
abline(h=c(7,13), v=c(8,15), col = "blue") # still shifted because of raster::plot

# However, it is not incorrect/changed when retrieving point info
out <- array(out, dim = c(20, 20, length(x@wavenumbers)))
plot(out[7,15,]~wn, type = "l")
lines(x@Spectra[7,15,]~x@wavenumbers, col = "red", lty = 2)

stopifnot(
  isTRUE(sum(out[7,15,] == x@Spectra[7,15,]) == dim(out)[3] & 
           sum(x@Spectra[7,15,] == ps) == dim(x@Spectra)[3])
  # [1] TRUE
)

# or when we analyze the tile
y <- tile_base_corr(x)
y <- wavealign(y, primpke)
y <- tile_sam(y)

psprof <- get_profile_tile(y, x, 5, FALSE, FALSE)
rtest <- apply(psprof, 1, function(tmp){
  sum(tmp == ps) == length(wn)
})

stopifnot(
  isTRUE(sum(rtest) == nrow(psprof))
  #[1] TRUE
)

###
##
# File for testing MOSAIC functions ----
##
###
rm(list = ls())
load("data-raw/references/dump_refs.Rdata")

out <- array(dim = c(10,20,length(wn)))
for(i in 1:10){
  for(j in 1:20){
    out[i, j, ] <- bg
  }
}

for(i in 3:7){
  for(j in 8:15){
    out[i,j,] <- ps
  }
}

mosaic_0 <- out[1:10,1:10,]
mosaic_1 <- out[1:10,11:20,]

## There are some t() and rev() calls when calling a mosaic_read_chunk
## to counteract the problem, we should do the same here
flip_forward <- function(out){
  for(i in 1:dim(out)[3]){out[ , ,i] <- out[nrow(out):1, ,i]}
  out <- aperm(out, c(2,1,3))
  out
}

flip_back <- function(out){
  out <- aperm(out, c(2,1,3))
  for(i in 1:dim(out)[3]){out[,,i] <- out[nrow(out):1,,i]}
  out
}

mosaic_0 <- flip_forward(mosaic_0)
mosaic_1 <- flip_forward(mosaic_1)

# Now we save the files
mosaic_0 <- c(rep(0, times = 255), as.vector(mosaic_0))
mosaic_1 <- c(rep(0, times = 255), as.vector(mosaic_1))
# rm(list = ls()[-grep("out|ps|bg|mosaic_.|wn", ls())])
writeBin(mosaic_0, "inst/extdata/mosaic_0000_0000.dmd", size=4, endian = 'little')
writeBin(mosaic_1, "inst/extdata/mosaic_0001_0000.dmd", size=4, endian = 'little')

## THE SAME TESTS
# rm(list = ls()[-grep("mosaic_.|ps", ls())])
x <- mosaic_info("inst/extdata/mosaic.dmt")
y <- mosaic_chunk(x, "mosaic_0000_0000.dmd")
z <- mosaic_chunk(x, "mosaic_0001_0000.dmd")

# Same length
mosaic_0 <- mosaic_0[256:length(mosaic_0)]
mosaic_1 <- mosaic_1[256:length(mosaic_1)]
# Reverse flip
m0 <- array(mosaic_0, dim = dim(y@Spectra))
m1 <- array(mosaic_1, dim = dim(z@Spectra))
m0 <- flip_back(m0)
m1 <- flip_back(m1)

stopifnot(
  isTRUE(sum(y@Spectra == m0) == length(mosaic_0))
)
stopifnot(
  isTRUE(sum(z@Spectra == m1) == length(mosaic_1))
)

# The ps is where it should be
mosaic_sam(x, primpke)
y <- mosaic_compose(x@path, primpke@clusterlist)
plot(y)
abline(h=c(3,7), v=c(8,15))

# The mosaic_sam and get returns the correct info
psprof <- get_profile_sinfo(y, where = list("info" = x, "dmdfile" = "mosaic_0000_0000.dmd"), 5, FALSE, FALSE)

rtest <- apply(psprof, 1, function(tmp){
  sum(tmp == ps) == length(wn)
})

stopifnot(
  isTRUE(sum(rtest) == nrow(psprof))
  #[1] TRUE
)
