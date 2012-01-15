function [A b] = hcp_con(P)
% hcp_con Construct the constraint matrix for HCP.
%
% Input:
%  P = adjacency matrix
%
% Output:
%  A = Constraint matrix
%

n = size(P,1);
[i j] = find(P);
m = length(i);
v = (1:m)';

A = sparse([j;i+n],[v;v],1);
b = ones(2*n,1);
%keyboard