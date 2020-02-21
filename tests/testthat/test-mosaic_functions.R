test_that("Example is load as expected", {
  x <- mosaic_info(system.file("extdata", "mosaic.dmt", package = "uFTIR"))
  expect_true(mosaic_sam(x, primpke, n_cores = 1))
  
  y <- mosaic_compose(x@path, primpke@clusterlist)
  y1 <- get_profile_sinfo(y, where = list("info" = x, "dmdfile" = "mosaic_0000_0000.dmd"), 5, FALSE, FALSE)
  y2 <- get_profile_sinfo(y, where = list("info" = x, "dmdfile" = "mosaic_0001_0000.dmd"), 5, FALSE, FALSE)

  expect_true(nrow(y1) == 15 & ncol(y1) == length(x@wavenumbers))
  expect_true(nrow(y2) == 25 & ncol(y2) == length(x@wavenumbers))
})

test_that("Functions return S4 and S3 classes", {
  expect_s4_class(x <- mosaic_info(system.file("extdata", "mosaic.dmt", package = "uFTIR")),
                  "SpectralInfo")
  expect_true(mosaic_sam(x, primpke, n_cores = 1))
  expect_s4_class(y <- mosaic_compose(x@path, primpke@clusterlist), "SAM")
  y <- smooth_sam(y, as.integer(length(primpke@clusternames)), 3, 1)
  expect_s4_class(y, "Smooth")
  clip <- toClip(8, 20, c(10,10))
  expect_s3_class(y <- clipper(y, clip@centre, clip@rad, slice = 1), "clipper")
})

test_that("The program can preprocess within mosaic_sam calls", {
  expect_s4_class(x <- mosaic_info(system.file("extdata", "mosaic.dmt", package = "uFTIR")),
                  "SpectralInfo")
  expect_true(mosaic_sam(x, primpke, FUN = function(x){x}, n_cores = 1))
  expect_s4_class(y <- mosaic_compose(x@path, primpke@clusterlist), "SAM")
})