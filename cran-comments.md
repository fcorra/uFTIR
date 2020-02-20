## Test environments
* local Debian GNU/Linux 10 (buster), R 3.5.2
* local Windows 10 Enterprise (1803), R 3.6.1

## R CMD check results
There were no ERRORs or WARNIGs.

There was 1 NOTE:

* checking installed package size ... NOTE
    installed size is 10.8Mb
    sub-directories of 1Mb or more:
      data      2.0Mb
      extdata   2.3Mb
      libs      6.1Mb

data directory holds a compressed and deflated Spectral Library that makes the identification of microplastics possible.

extdata holds minimum examples to run the tests.

## Downstream dependency
I have run R CMD check on downstream dependencies.
All packages that I could install passed.
