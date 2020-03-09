#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// I think I don't use any of these functions anymore. As the summary is done by vectorizing the raster.
// grep -rnwl R/ -e "cget_particles"  

arma::mat buffer_add(int r, int c, int t_r, int t_c, arma::mat buffer, arma::mat A){
  arma::mat tmp_add(1,4);
  tmp_add(0) = A(r,c);
  tmp_add(2) = r;
  tmp_add(3) = c;
  for(arma::uword i = 0; i < buffer.n_rows; ++i){
    if( buffer(i,2) == t_r && buffer(i,3) == t_c ){
      tmp_add(1) = buffer(i,1);
      buffer = join_cols(buffer, tmp_add);
      return buffer;
    }
  }
  Rcpp::Rcout << "WARNING: The particle number has not been assigned" << std::endl;
  tmp_add(1) = 0;
  buffer = join_cols(buffer, tmp_add);
  return buffer;
}

arma::mat buffer_new(int r, int c, arma::mat buffer, arma::mat A){
  arma::mat tmp(1,4);
  tmp(0) = A(r,c);
  tmp(2) = r;
  tmp(3) = c;
  tmp(1) = buffer.col(1).max() +1;
  buffer = join_cols(buffer, tmp);
  return buffer;
}

arma::mat buffer_merge(int r, int c, int t_r, int t_c, arma::mat buffer){
  arma::vec tmp_vec(2);
  for( arma::uword i = 0; i < buffer.n_rows; ++i ){
    if( buffer(i,2) == r && buffer(i,3) == c ){
      tmp_vec(0) = buffer(i,1);
    } else if( buffer(i,2) == t_r && buffer(i,3) == t_c ){
      tmp_vec(1) = buffer(i,1);
    }
  }
  for( arma::uword i = 0; i < buffer.n_rows; ++i ){
    if( buffer(i,1) == tmp_vec.max() ){
      buffer(i,1) = tmp_vec.min();
    }
  }
  return buffer;
}

arma::mat buffer_summary(arma::mat buffer){
  int x = buffer.col(1).max();
  arma::mat out(x+1,2,arma::fill::zeros);
  for(int i = 0; i <= x; ++i){
    arma::uvec set_vect = find( buffer.col(1) == i );
    if( set_vect.n_elem != 0 ){
      arma::mat sub_mat = buffer(set_vect);
      out(i, 1) = sub_mat.n_rows;
      out(i, 0) = sub_mat(0,0);
    }
  }
  arma::uvec vdel = find( out.col(0) == 0 );
  out.shed_rows(vdel);
  return out;
}

// [[Rcpp::export]]
arma::mat cget_particles(arma::mat A){
  arma::mat buffer(1, 4);
  buffer << -1 << -1 << -1 << -1 << arma::endr;
  // value; particle number; number of pixels
  
  for(arma::uword r = 0; r < A.n_rows; ++r){
    for(arma::uword c = 0; c < A.n_cols; ++c){
      
      if( r-1 >= 0 && c-1 >= 0 && c+1 < A.n_cols && ( A(r,c) == A(r-1,c-1) || A(r,c) == A(r,c-1) ) && A(r,c) != A(r-1,c) && A(r,c) == A(r-1,c+1) ){
        if( A(r,c) == A(r,c-1) ){
          buffer = buffer_add(r,c, r,c-1, buffer, A);
          buffer = buffer_merge(r,c,r-1,c+1,buffer);
        } else { //if( A(r,c) == A(r-1,c-1) ){
          buffer = buffer_add(r,c, r-1,c-1, buffer, A);
          buffer = buffer_merge(r,c,r-1,c+1,buffer);
        }
      } else if( c-1 >=0 && A(r,c) == A(r,c-1) ){
        buffer = buffer_add(r,c, r,c-1, buffer,A);	
      } else if( r-1 >=0 ){
        if( c+1 < A.n_cols && A(r,c) == A(r-1,c+1) ){
          buffer = buffer_add(r,c, r-1,c+1, buffer,A);
        } else if ( A(r,c) == A(r-1,c) ){
          buffer = buffer_add(r,c, r-1,c, buffer,A);
        } else if ( c-1 >=0 && A(r,c) == A(r-1,c-1) ){
          buffer = buffer_add(r,c, r-1,c-1, buffer,A);
        } else {
          buffer = buffer_new(r,c,buffer,A);
        }	
      } else {
        buffer = buffer_new(r,c,buffer,A);
      }
    }
    int r_test = r;
    if( r_test -1 == -1 ){
      buffer.shed_row(0);
    }
  }
  //std::cout << "The buffer:\n" <<  buffer;
  arma::mat out = buffer_summary(buffer);
  return out;
}

