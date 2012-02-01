%hcp_num_edg  return number of edges in a graph

function num_edg = hcp_num_edg(P)
  
  [i j] = find(P);
  num_edg = length(i);
  
end