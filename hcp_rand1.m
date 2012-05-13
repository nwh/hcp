%hcp_rand1  generate a random graph with cycle

function [P xc] = hcp_rand1(num_nodes,add_edges)
  
  v = (1:num_nodes)';
  E = [v circshift(v,1)];
  P = hcp_edg2adj(E);
  Pc = triu(P);
  Pc(1,end) = 0;
  Pc(end,1) = 1;
  
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
  Pc = Pc(rp,rp);
  xc = hcp_Px2x(P,Pc);
  
  %keyboard
  
end