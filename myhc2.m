function [f g H] = myhc2(x,A,alpha,rows,cols)
% myhc2 Compute the objective, gradient, and Hessian for the HC problem.
%
% Objective:
%  f = -det(I-P+alpha*e*e')
%
% Gradient:
%  G1 = I-P+alpha*e*e'
%  G2 = -f*inv(G)'
%  df/dp_{ij} = G2(i,j)
%
% Hessian:
%  Note that df/dp_{ij} = -(-1)^(i+j)*det(G(r,c))
%  G(r,c) is G with row i and col j removed
%  Thus, grad(df/dp_{ij}) = -(-1)^(i_j)*grad(det(G(r,c))
%  This code uses a recursive call to compute these gradients
%
% Note: there are different ways to compute all of these terms.  This is
% not the most efficient way.
%
% Inputs:
%  x = variable vector
%  A = adjacency matrix
%  alpha = parameter
%  rows = logical index for included rows (optional)
%  cols = logical index for included cols (optional)
%
% Outputs:
%  f = objective function value
%  g = gradient
%  H = Hessian
%
% References:
%  Matrix Reference Manual
%   http://www.ee.ic.ac.uk/hp/staff/dmb/matrix/intro.html
%  Matrix Cookbook
%   http://matrixcookbook.com/ (down at the moment)
%
% 2010-03-26 (nwh) first working version

n = size(A,1);

if nargin < 4
  rows = true(n,1);
  cols = true(n,1);
end

inds = (A == 1);
indr = (A(rows,cols) == 1);
P = double(A);
P(inds) = x;
m = length(x);
G = eye(n)-P+alpha*ones(n,n);
G = G(rows,cols);

% compute the objective function
f = -det(G);

if nargout > 1
  % compute the gradient
  B = -(f*inv(G))';
  g = B(indr);
end

if nargout > 2
  % compute the Hessian with recursive call
  [i j] = find(A);
  r = true(n,1);
  c = true(n,1);
  H = zeros(n,n);
  
  for k = 1:m
    r(i(k)) = false;
    c(j(k)) = false;
    v = (i~=i(k) & j~=j(k));
    [f2 g2] = myhc2(x,A,alpha,r,c);
    H(k,v) = -(-1)^(i(k)+j(k))*g2;
    r(i(k)) = true;
    c(j(k)) = true;
  end
end
