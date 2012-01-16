%hcp_grad  gradient for hcp objective

function g = hcp_grad(x,P)

  [f g] = hcp_obj(x,P);
  
end