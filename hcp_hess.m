%hcp_hess  hessian for hcp objective

function H = hcp_hess(x,P,factor)
  
  if nargin < 3 || isempty(factor)
    factor = 'full';
  end
  
  [f g H] = hcp_obj(x,P,factor);
  
end