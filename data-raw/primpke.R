## code to prepare `primpke` dataset goes here

## I reshaped a bit Primpke et al. 2018 library [this is how]
rspec <- read.csv('data-raw/extdata/primpke2018_spectra.csv', stringsAsFactors = F)

# Get the wavenumbers
waveseq <- colnames(rspec)[4:ncol(rspec)]
waveseq <- gsub('X', '', waveseq)
waveseq <- rev(as.numeric(waveseq))

# Get the column names
tmp.names <- rspec[ , grep('Substance', colnames(rspec))]
tmp.clust <- rspec[, grep('Cluster.Autoanalysis', colnames(rspec))]

# Tidy up the data
rspec <- as.matrix(rspec[, ncol(rspec):4])
rownames(rspec) <- tmp.names
colnames(rspec) <- waveseq

# Cluster names
clusterlist <- read.csv('data-raw/extdata/clusterlist.csv', stringsAsFactors = F, head = F)
clusterlist <- clusterlist[,2]
all.equal(unique(clusterlist), clusterlist) # ninguno repetido

primpke <- new("SpectralReference",
               substances = tmp.names,
               clusterlist = tmp.clust,
               Spectra = rspec,
               wavenumbers = waveseq,
               clusternames = clusterlist)

usethis::use_data(primpke)
