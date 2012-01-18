% solve hcp problem with mgf_lc

function drv2
  
  % load data
  load('graphs/hcp_data.mat')

  [hcp_slv] = hcp_arcopt(hcp_14(132).P);
  hcp_slv
  
  keyboard
  
end

