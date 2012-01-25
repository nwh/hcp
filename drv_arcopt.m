%drv_arcopt  run many problems using arcopt

function drv_arcopt
  
  % choose results dir
  res_dir = 'results/2012-01-25/';
  run_dir = [res_dir 'runs/'];
  
  % settings
  solve_tol = -.99;
  
  % create dirs if they don't exist
  if ~exist(res_dir,'dir')
    mkdir(res_dir);
  end
  if ~exist(run_dir,'dir')
    mkdir(run_dir);
  end
  
  % load data
  D = load('graphs/hcp_data.mat');
  
  % get lengths of different data sets
  len_set = length(D.hcp_set);
  len_10 = length(D.hcp_10);
  len_12 = length(D.hcp_12);
  len_14 = length(D.hcp_14);
  
  % combine data
  hcp_data = [D.hcp_set; D.hcp_10; D.hcp_12; D.hcp_14];
  hcp_code = [ones(len_set,1); 2*ones(len_10,1); 
    3*ones(len_12,1); 4*ones(len_14,1)];
  hcp_num = length(hcp_data);
  %hcp_num = 10;
  
  % attempt to solve
  res_arcopt = [];
  progressbar('hcp arcopt');
  for i = 1:hcp_num
    fprintf('working on: %13s is_hamil: %d\n',hcp_data(i).name,hcp_data(i).is_hamil);
    if hcp_data(i).is_hamil
      run_fname = [run_dir mod_fname(hcp_data(i).name) '.txt'];
      res = hcp_arcopt(hcp_data(i).P,hcp_data(i).name,solve_tol,run_fname);
      res_arcopt = [res_arcopt; res];
    end
    progressbar(i/hcp_num);
  end
  
  % save results
  save([res_dir 'res_arcopt.mat'],'res_arcopt','hcp_data','hcp_code');
  
end

function s = mod_fname(fname)
  
  s = regexprep(fname, '[()]', '_');
  
end