test_that("Tile can be plotted", {
  x <- tile_read(system.file("extdata", "tile.bsp", package="uFTIR"))
  expect_null(plot(x))
})

test_that("SpectralPack can be plotted", {
  x <- tile_read(system.file("extdata", "tile.bsp", package="uFTIR"))
  x <- wavealign(x, primpke)
  expect_null(plot(x))
})

test_that("SAM can be plotted", {
  x <- tile_read(system.file("extdata", "tile.bsp", package="uFTIR"))
  x <- wavealign(x, primpke)
  x <- tile_sam(x)
  expect_null(plot(x))
})

test_that("Smooth can be plotted", {
  x <- tile_read(system.file("extdata", "tile.bsp", package="uFTIR"))
  x <- wavealign(x, primpke)
  x <- tile_sam(x)
  x <- smooth_sam(x, as.integer(length(primpke@clusternames)), window = 3, nslices = 1)
  expect_null(plot(x))
})

test_that("clipper can be plotted", {
  x <- tile_read(system.file("extdata", "tile.bsp", package="uFTIR"))
  x <- wavealign(x, primpke)
  x <- tile_sam(x)
  clip <- toClip(8,20,c(10,10))
  x <- clipper(x, clip@centre, clip@rad, 1)
  expect_null(plot(x))
})

test_that("clipper can be plotted", {
  x <- tile_read(system.file("extdata", "tile.bsp", package="uFTIR"))
  x <- wavealign(x, primpke)
  x <- tile_sam(x)
  clip <- toClip(8,20,c(10,10))
  x <- clipper(x, clip@centre, clip@rad, 1)
  expect_null(highlight_substance(x, 5))
})