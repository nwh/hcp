%hcp_hess_pat  compute non-zero pattern of hessian for HCP
%
% Generates the non-zero pattern for the Hessian of the HCP objective function.
% 
% Input:
%  P = adjacency matrix
%  factor = string indicating desired factor in {'full','L','U'}
%
% Output:
%  Hp = sparse matrix for non-zero pattern, all non-zero elements are 1
%

function Hp = hcp_hess_pat(P,factor)
  
  % handle optional input
  if nargin < 2 || isempty(factor)
    factor = 'full';
  end
  
  % get number of nodes
  n = size(P,1);
  
  % get edges
  [i j] = find(P);
  
  % get number of edges
  m = length(i);
  
  % compute hessian pattern
  Hp_idx = [];
  for k1 = 1:m
    for k2 = k1+1:m
      hi = i(k1);
      hj = j(k1);
      hk = i(k2);
      hl = j(k2);
      
      if hi == hk || hj == hl || any([hi hj hk hl] == n)
        continue;
      end
      
      Hp_idx = [Hp_idx; [k1 k2]];
      
    end
  end
  
  % generate desired output
  switch factor
    case 'L'
      Hp = sparse(Hp_idx(:,2),Hp_idx(:,1),1,m,m);
    case 'U'
      Hp = sparse(Hp_idx(:,1),Hp_idx(:,2),1,m,m);
    case 'full'
      Hp_idx = [Hp_idx; Hp_idx(:,[2 1])];
      Hp = sparse(Hp_idx(:,1),Hp_idx(:,2),1,m,m);
    otherwise
      error('hcp_hess_pat:unrecognized_factor','factor must be L, U, or full.')
  end
  
  %keyboard
  
end