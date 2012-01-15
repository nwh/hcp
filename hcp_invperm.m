function q = hcp_invperm(p)
%hcp_invperm Invert permutation vector p.
%
% Input:
%  p = permutation vector
%
% Output:
%  q = inverse permutation vector of p
%

n = length(p);
q = p;
q(p) = 1:n;