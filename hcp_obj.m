%hcp_obj  objective function for HCP

function [f g H] = hcp_obj(x,P)

  % get number of nodes
  n = size(P,1);
  
  % get edges
  [i j] = find(P);
  
  % get number of edges
  m = length(x);
  
  % get sparse identity
  I = speye(n,n);
  
  Px = hcp_P2Px(P,x);
  G = I - Px;
  
  [L U] = luimc(G,'pivot','none');
  L(n,:) = 0; L(n,n) = 1;
  U(:,n) = 0; U(n,n) = 1;
  
  % compute objective
  Udiag = diag(U);
  f = -prod(Udiag(1:n-1));
  f = full(f);
  
  % compute gradient
  Linv = L\I;
  Uinv = U\I;
  Ginv = Uinv*Linv;
  
  g = zeros(m,1);
  for k = 1:m
    g(k) = -f*Ginv(j(k),i(k));
  end

  %keyboard 
  
  % compute hessian
  H = zeros(m,m);
  for k1 = 1:m
    for k2 = k1+1:m
      hi = i(k1);
      hj = j(k1);
      hk = i(k2);
      hl = j(k2);
      
      if hi == hk || hj == hl || any([hi hj hk hl] == n)
        continue;
      end
      
      H(k1,k2) = Ginv(hj,hk)*Ginv(hl,hi) - Ginv(hj,hi)*Ginv(hl,hk);
      
    end
  end
  
  H = -f*H;
  H = H+H';
  
  %keyboard
  
end