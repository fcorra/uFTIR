# 0.1.3 Version comments

The package last version (0.1.2) was archived on 02 September 2021 as it used
proj_api.h headers from PROJ4. Since PROJ8 removed the header, the package
installation failed.

To fix the problem, I removed GDAL and PROJ from the SystemRequirements.  The
package has now two new dependences; rgdal, and rgeos.

I have checked the package both locally and remotelly, and I present a summary
of the outputs (**NOTES: 2**).

# Test environments

## Local
   Linux 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03) x86_64 GNU/Linux
   Debian GNU/Linux 11 (bullseye)
   gcc (Debian 10.2.1-6) 10.2.1 20210110

## Winbuilder


## Rhub

# Check results

**NOTE:**
* checking CRAN incoming feasibility ... NOTE
   New submission
   Package was archived on CRAN
   CRAN repository db overrides:
     X-CRAN-Comment: Archived on 2021-09-02 as check problems were not
       corrected in time.
     Requires obsolete PROJ interface, so fail with PROJ 8 (despite the
       SystemRequirements).

**NOTE:**
* checking installed package size ... NOTE
  installed size is 10.5Mb
  sub-directories of 1Mb or more:
    data      2.0Mb
    extdata   2.3Mb
    libs      5.9Mb

