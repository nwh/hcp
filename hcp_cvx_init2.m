%hcp_cvx_init2  use cvx to generate an initial point

function y0 = hcp_cvx_init2(P,v)
 
  % get the constraint matrix
  [A b] = hcp_con(P);
  [m n] = size(A);
  
  % solve the feasibility problem with cvx
  cvx_quiet(true);
  cvx_begin
    variable x(n);
    minimize( sum_square(x-v) );
    A*x == b;
    x >= 0;
    x <= 1;
  cvx_end
  
  % return the solution
  y0 = x;
  
  %keyboard
  
end
