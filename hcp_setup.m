%hcp_setup  setup script for hcp directory

function hcp_setup
  
  % call tool loaders
  load_cvx
  load_luimc
  load_snlc
  load_ipopt
  load_arcopt
  load_mcute
  
  % add hcp dir and graphs dir to path
  hcp_dir = [getenv('HOME') '/Dropbox/code/thesis/hcp'];
  grh_dir = [hcp_dir '/graphs'];
  
  addpath(hcp_dir);
  addpath(grh_dir);
  
end