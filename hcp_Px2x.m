%hcp_Px2x  convert from weighted adjacency to variable vector

function x = hcp_Px2x(P,Px)

  [i j] = find(P);
  nvar = length(i);
  x = zeros(nvar,1);
  
  for k = 1:nvar
    x(k) = Px(i(k),j(k));
  end
  
end