#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::cube csmooth_sam(arma::cube myCube, int wind, int bins, int nslices){
	// wind = window size.
	// bins = how many clusters we had/have?
	// nslices = how many slices, starting from zero, should be smoothered.
	
	arma::cube tmp_Cube(size(myCube.slices(0, nslices)));
	
	for(int dslice = 0; dslice <= nslices; ++dslice)
	{
	  arma::mat myCubeSlice = myCube.slice(dslice);
	  
		for(int drow = 0; drow < myCubeSlice.n_rows; ++drow)
		{
			for(int dcol = 0; dcol < myCubeSlice.n_cols; ++dcol)
			{
				int first_row = (drow - wind > 0) ? drow - wind : 0;
				int first_col = (dcol - wind > 0) ? dcol - wind : 0;
				int last_row = (drow + wind < myCubeSlice.n_rows - 1) ? drow + wind : myCubeSlice.n_rows -1;
				int last_col = (dcol + wind < myCubeSlice.n_cols - 1) ? dcol + wind : myCubeSlice.n_cols -1;

				arma::vec electors = arma::vectorise(myCubeSlice.submat(first_row, first_col, last_row, last_col));

				// find the mode
				// we can do that using an histogram
				std::vector<int> histogram(bins, 0);
				for(int i = 0; i < electors.n_elem; ++i)
					++histogram[ electors[i] ];
				int vote = std::max_element( histogram.begin(), histogram.end() ) - histogram.begin();

				tmp_Cube(drow, dcol, dslice) = vote;
			}
		}
	}
	return tmp_Cube;
}

