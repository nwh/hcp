%hcp_edg2adj  Convert edge list to adjacency matrix
%
% Input:
%  E = array of edges, for each i, there is an edge between E(i,1) and E(i,2)
%
% Output:
%  P = adjacency matrix (undirected)
%  num_edges = number of edges after graph made undirected
%

function [P num_edges] = hcp_edg2adj(E)
  
  % get number of notes
  num_nodes = max(E(:));
  
  % get symmetric edge set
  E2 = [E; E(:,[2 1])];
  
  % generate temporary adjacency matrix
  P_temp = sparse(E2(:,1),E2(:,2),1,num_nodes,num_nodes);
  
  % generate adjacency matrix with all ones
  [i j] = find(P_temp);
  P = sparse(i,j,1,num_nodes,num_nodes);
  
  % get the final number of edges
  num_edges = length(i);
  
end
