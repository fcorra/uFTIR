#include <RcppArmadillo.h>
#include <fstream>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::cube mosaic_read_chunk(char const* filename, int fpa, int wl)
{
  std::ifstream is(filename, std::ifstream::binary);
  if (is)
  {
    float size;

    is.seekg (0, is.end);
    int length = is.tellg();
    is.seekg (255*sizeof(size), is.beg);

    int numIntegers = length/sizeof(size);
    float* buffer = new float [numIntegers];
    
    is.read(reinterpret_cast<char*>(buffer), numIntegers*sizeof(size));
    
    arma::fcube tmpout((const float*)(buffer), fpa, fpa, wl);
    arma::cube out = arma::conv_to<arma::cube>::from(tmpout);
    
    is.close();

    return out;
  }
  else
  {
    arma::cube out(0,0,0);
    out.zeros();
    return out;
  }
}

