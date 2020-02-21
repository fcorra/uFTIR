## Test environments
* local Debian GNU/Linux 10 (buster), R 3.5.2
* local Linux Mint 18.3 (Sylvia), R 3.4.4
* rhub
    * Debian Linux, R-devel, GCC ASAN/UBSAN
    * Debian Linux, R-release, GCC
    * Fedora Linux, R-devel, GCC
    * Fedora Linux, R-devel, clang, gfortran
    * Windows Server 2008 R2 SP1, R-release, 32/64 bit

## R CMD check results
### on local 
0 errors | 0 warnings | 2 notes

There were 2 NOTEs:

* checking CRAN incoming feasibility ... NOTE

  Maintainer: ‘Fabio Corradini <fabio.corradini@inia.cl>’
  New submission

* checking installed package size ... NOTE
  installed size is 10.8Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs      6.1Mb

		/data folder holds a compressed and deflated Spectral Library that makes the identification of microplastics possible. It was tailor-made for the package.
		/extdata holds minimum examples to run the tests.
		All together the /inst and /data are not bigger than 5Mb.

### on rhub
The NOTEs were slightly different in rhub Windows Server 2008 R2 SP1, R-release, 32/64 bit:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Fabio Corradini <fabio.corradini@inia.cl>'

New submission

Possibly mis-spelled words in DESCRIPTION:
  Agilent (3:28, 15:73)
  hyperspectral (15:107)
  microplastic (16:28)
  preprocess (15:38)
  uFTIR (15:90)
  FTIR (3:45)

		I checked the words and they are not misspelled.

* checking installed package size ... NOTE
  installed size is 38.1Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    gdal      3.8Mb
    libs     24.7Mb
    proj      5.0Mb

		On windows gdal is installed along with the package.


I got one extra NOTE for Fedora Linux, R-devel, clang, gfortran

* checking examples ... NOTE
Examples with CPU (user + system) or elapsed time > 5s
                 user system elapsed
summary\_sam    0.632  0.016   9.494
get\_profile    0.056  0.004   6.907
mosaic\_compose 0.056  0.000   5.721
mosaic\_sam     0.052  0.004   5.972

		I did not get the NOTE for Fedora Linux, R-devel, GCC. I think the problem is related with the compiler.

I got an 'OK' for Debian Linux, R-devel, GCC ASAN/UBSAN 
