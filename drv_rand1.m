%drv_rand1  driver to generate and test random graphs

function drv_rand1

  % set the rng
  RandStream.setDefaultStream(RandStream('mt19937ar','seed',1));
  
  num_nodes = 50;
  add_edges = 100;
  
  % generate graph
  P = hcp_rand1(num_nodes,add_edges);
  spy(P)
  
  % get initial point
  %x0 = hcp_cvx_init1(P);
  
  % solve
  [hcp_slv] = hcp_ipopt(P)
  
  keyboard
  
end