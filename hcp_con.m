%hcp_con Construct the constraint matrix and rhs vector for HCP
%
% Input:
%  P = adjacency matrix
%
% Output:
%  A = Constraint matrix
%

function [A b] = hcp_con(P)
  
  n = size(P,1);
  [i j] = find(P);
  m = length(i);
  v = (1:m)';
  
  A = sparse([j;i+n],[v;v],1);
  b = ones(2*n,1);
  %keyboard
  
end