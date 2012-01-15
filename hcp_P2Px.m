%hcp_P2Px  convert from 0-1 adjacency to weighted adjacency

function Px = hcp_P2Px(P,x)
  
  n = size(P,1);
  [i j] = find(P);
  Px = sparse(i,j,x,n,n);
  
  if ~issparse(P)
    Px = full(Px);
  end
  
end