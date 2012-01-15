%hcp_rand1  generate a random graph with cycle

function [P] = hcp_rand1(num_nodes,add_edges)
  
  v = (1:num_nodes)';
  E = [v circshift(v,1)];
  P = hcp_edg2adj(E);
  
  while add_edges > 0
  
    test_edge = randi(num_nodes,[1 2]);
    
    if test_edge(1) == test_edge(2) || P(test_edge(1),test_edge(2))
      continue
    end
  
    P(test_edge(1),test_edge(2)) = 1;
    P(test_edge(2),test_edge(1)) = 1;
    add_edges = add_edges - 1;
    
  end
  
  rp = randperm(num_nodes);
  P = P(rp,rp);
  
  %keyboard
  
end