## Since the full references cannot be loaded to GitHub, we made toy vectors form them to
## make our example files (on inst/extdata).

## Checking the references:
ps <- tile_read("data-raw/references/ps.bsp")
bg <- tile_read("data-raw/references/bg_anodisc_15x.bsp")
length(bg@wavenumbers) == length(ps@wavenumbers)
#[1] FALSE
dim(bg@Spectra[,, bg@wavenumbers %in% ps@wavenumbers])

plot(ps@Spectra[24,72,]~ps@wavenumbers, type = "l")
plot(bg@Spectra[45,45,]~bg@wavenumbers, type = "l")

## Making the short versions
bg <- bg@Spectra[45,45, bg@wavenumbers %in% ps@wavenumbers]
wn <- ps@wavenumbers
ps <- ps@Spectra[24,72,]

# dput(bg, file = "data-raw/references/bg_vec")
# dput(ps, file = "data-raw/references/ps_vec")
# dput(wn, file = "data-raw/references/wn_vec")

save(list = ls(), file = "data-raw/references/dump_refs.Rdata")

rm(list=ls())
