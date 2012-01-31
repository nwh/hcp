% solve hcp problem with arcopt

function drv2
  
  % add path
  addpath ./graphs
  
  % load data
  P = graph38

  [hcp_slv] = hcp_arcopt(P);
  hcp_slv
  
  %keyboard
  
end

