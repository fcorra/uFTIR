# 0.1.2 Version comments

The package second version (0.1.1) had an issue when compiling in CRAN's macOS and OS X platforms because:

* I assumed the user installed GDAL using homebrew (and not KingChaos's GDAL).

I add a confingure file that fix the problem for all platforms I could test.

I've re-run the checks both locally and in remote machines. I present a summary of the outputs bellow.

# Test environments

* local Debian GNU/Linux 10 (buster), R 3.5.2, GCC 8.3.0
* Win-builder
	* R release (R version 4.0.0)
* rhub
	* Fedora Linux, R-devel, clang, gfortran
	* Windows Server 2008 R2 SP1, R-devel, 32/64 bit
	* Debian Linux, R-devel, GCC ASAN/UBSAN
	* macOS 10.13.6 High Sierra, R-release, CRAN's setup [Where it failed last time]

# R CMD check results

## local 

**NOTE:**

* checking installed package size ... NOTE
  installed size is 10.7Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs      6.1Mb

## win-builder.r

**NOTE:**

* checking installed package size ... NOTE
  installed size is 83.1Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    gdal      3.9Mb
    libs     69.6Mb
    proj      5.0Mb

## rhub

### Fedora Linux, R-devel, clang, gfortran

**NOTE:**

* checking installed package size ... NOTE
  installed size is  7.2Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs      2.5Mb

### Windows Server 2008 R2 SP1, R-devel, 32/64 bit

**NOTE:**

* checking installed package size ... NOTE
  installed size is 83.0Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    gdal      3.8Mb
    proj      5.0Mb
    libs     69.6Mb

### Debian Linux, R-devel, GCC ASAN/UBSAN

**OK**

### macOS 10.13.6 High Sierra, R-release, CRAN's setup [Where it failed last time]

**NOTE:**

* checking installed package size ... NOTE
  installed size is 26.1Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs     21.5Mb

