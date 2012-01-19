%drv_ipopt attempt to solve hcp problem with ipopt

function drv_ipopt

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
  %hcp_num = 10;
  
  % attempt to solve
  res_ipopt = [];
  progressbar('hcp ipopt');
  for i = 1:hcp_num
    fprintf('working on: %13s is_hamil: %d\n',hcp_data(i).name,hcp_data(i).is_hamil);
    if hcp_data(i).is_hamil
      res = hcp_ipopt(hcp_data(i).P,hcp_data(i).name);
      res_ipopt = [res_ipopt; res];
    end
    progressbar(i/hcp_num);
  end
  
  % save results
  save([res_dir 'res_ipopt.mat'],'res_ipopt')

  %keyboard
  
end
