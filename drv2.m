% solve hcp problem with mgf_lc

function drv2
  
  % load data
  load('graphs/hcp_data.mat')

  [x info] = hcp_arcopt(hcp_set(3).P);
  
  %keyboard
  
end

