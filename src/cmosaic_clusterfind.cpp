#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::cube cmosaic_clusterfind(arma::cube sam_match, arma::rowvec clusters){
	arma::cube out(size(sam_match));
	for(int s = 0; s < out.n_slices; ++s)
	{
		for(int r = 0; r < out.n_rows; ++r)
		{
			for(int c = 0; c < out.n_cols; ++c)
			{
				out(r,c,s) = clusters(sam_match(r,c,s) -1);
			}
		}
	}
	return out;
}
