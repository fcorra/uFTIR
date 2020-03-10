# Resubmission comments
The package first version scored some errors in its way to CRAN because:
* I did not include the call to requireNamespace when loading suggested packages, and;
* One of the suggested packages was archived the day after the package was sent.

I've changed the package dependencies, and I call now requireNamespace before loading each of the suggested packages.

I've re-run the checks both locally and in the remote machines. I present a summary of the outputs bellow.

# Test environments
* local Debian GNU/Linux 10 (buster), R 3.5.2, GCC 8.3.0
* win-builder.r
	* R-devel, R Under development (unstable) (2020-01-28 r77738)
* rhub
	* Fedora Linux, R-devel, GCC 
	* Windows Server 2008 R2 SP1, R-release, 32/64 bit

# R CMD check results
## local 

**2 NOTEs**

* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Fabio Corradini <fabio.corradini@inia.cl>’

Days since last update: 4

* checking installed package size ... NOTE
  installed size is 10.0Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs      5.4Mb

## win-builder.r

**2 NOTEs**

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Fabio Corradini <fabio.corradini@inia.cl>'

Days since last update: 4

* checking installed package size ... NOTE
  installed size is 82.4Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    gdal      3.9Mb
    libs     69.0Mb
    proj      5.0Mb

## rhub

### Fedora

**NOTE:**

* checking installed package size ... NOTE
  installed size is 10.1Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs      5.5Mb

### Windows Server

**NOTE:**

* checking installed package size ... NOTE
  installed size is 38.0Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    gdal      3.8Mb
    libs     24.6Mb
    proj      5.0Mb

