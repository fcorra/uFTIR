# 0.1.3 Version comments

The package last version (0.1.3) was archived on 27 September 2021 as it 
wrote two examples into the user directory. This violates CRAN's policy.

To fix the problem, I added a new parameter to a function to write to a tempdir.

I have checked the package both locally and remotely, and I present a summary
of the outputs (**NOTES: 1**).

# Test environments

## Local
   Linux L02BACK 5.10.0-9-amd64 #1 SMP Debian 5.10.70-1 (2021-09-30) x86\_64 GNU/Linux
   Debian GNU/Linux 11 (bullseye)
   gcc (Debian 10.2.1-6) 10.2.1 20210110

## win-builder
   R-devel

## Rhub
   macOS 10.13.6 High Sierra, R-release, CRAN's setup

# Check results

* checking CRAN incoming feasibility ... NOTE
   New submission
   Package was archived on CRAN

   Possibly misspelled words in DESCRIPTION:
      Agilent (3:28, 15:61)
      FTIR (3:45)
      hyperspectral (15:95)
      microplastic (16:28)
      uFTIR (15:78)
   
   CRAN repository db overrides:
   X-CRAN-Comment: Archived on 2021-09-27 for policy violation.



