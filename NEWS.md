# CHANGELOG

The *hcl* branch implements new functions to adapt the package to the high-performance computer.

## NEW FUNCTIONS

+ It adds a new method to get\_profile. It is called get\_profile\_all and it reads the info of all pixels that matched a substance/cluster. It only works for 'clipper' objects (actually, x should be a matrix). It will replace get\_profile\_sinfo some day. Is fast, it does not plot, it does its job.
+ It adds to new functions to load and write *SAM* objects. They are called sam\_write and sam\_load.
+ It adds a matrix\_sam function to perform a spectral angle mapper between to matrices (x can even be a vector). It is connected with the C++ sam\_internal which now is exported. I wrote it only for debugging purposes.
+ It adds a mosak_sam function to cut off pixles that have a poor match.

## FUNCTIONS THAT CHANGED

+ mosaic\_chunk was rewritten to add three extra argument to the function. The function can now read a chunk without pointing a SpectralInfo object. This change has the following implications:
	+ Arguments should be called explicitly, as some of them can be missing.
	+ If info is omitted you should provide the fpa size, the wavenumbers and the file path. You can omit the path if the connection to the \*.dmd file includes its full path.


