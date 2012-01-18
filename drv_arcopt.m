%drv_arcopt  run many problems using arcopt

function drv_arcopt
  
  % choose results dir
  res_dir = 'results/2012-01-18/';
  
  % create results dir if it does not exist
  if ~exist(res_dir,'dir')
    mkdir(res_dir);
  end
  
  % load data
  D = load('graphs/hcp_data.mat');
  
  % combine data
  hcp_data = [D.hcp_set; D.hcp_10; D.hcp_12; D.hcp_14 ];
  hcp_num = length(hcp_data);
  
  % attempt to solve
  res_arcopt = [];
  for i = 1:10
    fprintf('working on: %13s is_hamil: %d\n',hcp_data(i).name,hcp_data(i).is_hamil);
    if hcp_data(i).is_hamil
      res = hcp_arcopt(hcp_data(i).P,hcp_data(i).name);
      res_arcopt = [res_arcopt; res];
    end
  end
  
  % save results
  save([res_dir 'res_arcopt.mat'],'res_arcopt')
  
end