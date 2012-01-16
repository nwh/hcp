%hcp_obj  objective function for HCP

function [f g H] = hcp_obj(x,P,factor)

  % handle optional factor input
  if nargin < 3 || isempty(factor)
    factor = 'full';
  end
  
  % do nothing if there are no output arguments
  if nargout == 0
    return
  end
  
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
  
  % do not compute g and H if only f is requested
  if nargout == 1
    return
  end
  
  % compute gradient
  Linv = L\I;
  Uinv = U\I;
  Ginv = Uinv*Linv;
  
  g = zeros(m,1);
  for k = 1:m
    g(k) = -f*Ginv(j(k),i(k));
  end

  % do not compute H if only f and g are requested
  if nargout == 2
    return
  end

  % output hessian indicies and values
  iRow = [];
  jCol = [];
  hVal = [];
  
  % compute hessian
  %H = zeros(m,m);
  elemcnt = 0;
  for k1 = 1:m
    for k2 = k1+1:m
      hi = i(k1);
      hj = j(k1);
      hk = i(k2);
      hl = j(k2);
      
      if hi == hk || hj == hl || any([hi hj hk hl] == n)
        continue;
      end
   
      elemcnt = elemcnt + 1;
      iRow(elemcnt) = k1;
      jCol(elemcnt) = k2;
      hVal(elemcnt) = Ginv(hj,hk)*Ginv(hl,hi) - Ginv(hj,hi)*Ginv(hl,hk);
      
      %H(k1,k2) = Ginv(hj,hk)*Ginv(hl,hi) - Ginv(hj,hi)*Ginv(hl,hk);
      
    end
  end
  
  % orient and adjust
  iRow = iRow(:);
  jCol = jCol(:);
  hVal = -f*hVal(:);
  
  switch factor
    case 'L'
      H = sparse(jCol,iRow,hVal,m,m);
    case 'U'
      H = sparse(iRow,jCol,hVal,m,m);
    case 'full'
      H = sparse([iRow;jCol],[jCol;iRow],[hVal;hVal],m,m);
      % note that the diagonal is always zero, don't need to worry about it
      % doubling
    otherwise
      error('hcp_obj:unrecognized_factor','factor must be L, U, or full.');
  end
  
  %H = -f*H;
  %H = H+H';
  
  %keyboard
  
end