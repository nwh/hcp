%drv_results  analyze results from hcp runs

function drv_results
  
  % results directory
  res_dir = 'results/2012-01-25/';
  
  % load data
  load([res_dir 'res_arcopt.mat']);
  
  % return org tables
  mcute_struct2org(res_arcopt,[res_dir 'res_arcopt.org']);
  
  % get cells
  C_arcopt = struct2cell(res_arcopt)';
  
  % get fieldnames
  fn_arcopt = fieldnames(res_arcopt);

  % extract important data
  hc_arcopt = cell2mat(C_arcopt(:,end));

  fev_arcopt = cell2mat(C_arcopt(:,5));

  % print report
  num_prob = length(res_arcopt);
  num_arcopt = sum(hc_arcopt);
  num_ipopt = sum(hc_ipopt);
  fprintf('total number of problems: %d\n',num_prob);
  fprintf(' arcopt # solved: %d\n',num_arcopt);
  fprintf(' arcopt %% solved: %g\n',num_arcopt/num_prob);
  fprintf('arcopt total fev: %g\n',sum(fev_arcopt));
  
  keyboard
  
end