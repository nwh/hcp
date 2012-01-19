%drv_results  analyze results from hcp runs

function drv_results
  
  % results directory
  res_dir = 'results/2012-01-18/';
  
  % load data
  load([res_dir 'res_arcopt.mat']);
  load([res_dir 'res_ipopt.mat']);
  
  % return org tables
  mcute_struct2org(res_arcopt,[res_dir 'res_arcopt.org']);
  mcute_struct2org(res_ipopt,[res_dir 'res_ipopt.org']);
  
  % get cells
  C_arcopt = struct2cell(res_arcopt)';
  C_ipopt = struct2cell(res_ipopt)';
  
  % get fieldnames
  fn_arcopt = fieldnames(res_arcopt);
  fn_ipopt = fieldnames(res_ipopt);

  % extract important data
  hc_arcopt = cell2mat(C_arcopt(:,end));
  hc_ipopt = cell2mat(C_ipopt(:,end));

  fev_arcopt = cell2mat(C_arcopt(:,5));
  fev_ipopt = cell2mat(C_ipopt(:,5));

  % print report
  num_prob = length(res_arcopt);
  num_arcopt = sum(hc_arcopt);
  num_ipopt = sum(hc_ipopt);
  fprintf('total number of problems: %d\n',num_prob);
  fprintf(' arcopt # solved: %d\n',num_arcopt);
  fprintf(' arcopt %% solved: %g\n',num_arcopt/num_prob);
  fprintf('arcopt total fev: %g\n',sum(fev_arcopt));
  fprintf('  ipopt # solved: %d\n',num_ipopt);
  fprintf('  ipopt %% solved: %g\n',num_ipopt/num_prob);
  fprintf(' ipopt total fev: %g\n',sum(fev_ipopt));
  
  % generate performance profile
  
  % set failures to NaN
  fev_arcopt(hc_arcopt == 0) = NaN;
  fev_ipopt(hc_ipopt == 0) = NaN;
  
  perf([fev_arcopt fev_ipopt])
  legend('arcopt','ipopt','Location','SouthEast')
  title('Performance profile on HCP','FontSize',14)
  ylabel('fraction solved','FontSize',14)
  xlabel('performance ratio (function evals)','FontSize',14)
  
  print('-depsc2',[res_dir 'res_prof.eps'])
  
  keyboard
  
end