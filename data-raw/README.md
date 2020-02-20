
## NOTES

### **\[Spectral Library\]**

The spectral library included in the package and the data in the
./extdata folder come from:

Primpke, S., Wirth, M., Lorenz, C., Gerdts, G. 2018. Reference database
design for the automated analysis of microplastic samples based on
Fourier transform infrared (FTIR) spectroscopy. Analytical and
Bioanalytical Chemistry 410: 5131-5141.

The article is available
[here](https://doi.org/10.1007/s00216-018-1156-x)

### **\[References\]**

I took the reference samples in ./references with the following
settings:

  - Mode: *Transmission*
  - High magnification: *off*
  - Sample scan: *8*
  - Background scan: *16*
  - Resolution: *8 cm-1*
  - Scan type: *Absorbance*
  - Scan range: *3500 - 1300 cm-1*
  - Beam splitter: *KBr*
  - Beam attenuator: *100%*

The *./references/bg\_anodisc\_15x.\** sample corresponds to an anodisc
place above the KBr glass. The background for that sample was the same
anodisc above the same KBr glass. In other words, the sample is a
background re-reading. It was taken with 15x objectives to reach a IR
pixel size of 5.5 x 5.5 um.

The *./references/ps.\** sample corresponds to a Polystyrene sheet. It
was taken with 4x objectives to reach a IR pixel size of 20.6 x 20.6 um

### **\[Getting the references\]**

The references are too heavy to be shared through Github. We extracted a
vector from each (all you need to make the examples) and include them in
the /references folder. The process was:

``` r
ps <- tile_read("data-raw/references/ps.bsp")
bg <- tile_read("data-raw/references/bg_anodisc_15x.bsp")

bg <- bg@Spectra[45,45, bg@wavenumbers %in% ps@wavenumbers]
wn <- ps@wavenumbers
ps <- ps@Spectra[24,72,]

dput(bg, file = "data-raw/references/bg_vec")
dput(ps, file = "data-raw/references/ps_vec")
dput(wn, file = "data-raw/references/wn_vec")
```
