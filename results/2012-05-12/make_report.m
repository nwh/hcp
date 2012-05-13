%drv_results  analyze results from hcp runs

function make_report
  
  % load data
  load('res_arcopt.mat');
  load('res_ipopt.mat');
  
  % return org tables
  mcute_struct2org(res_arcopt,'res_arcopt.org');
  mcute_struct2org(res_ipopt,'res_ipopt.org');
  
  % get cells
  %C_data = struct2cell(hcp_data)';
  C_arcopt = struct2cell(res_arcopt)';
  
  % separate different size graphs
  res_code = arrayfun(@(i) cell_filt(C_arcopt{i,6}),1:size(C_arcopt,1))';
  
  % get fieldnames
  fn_arcopt = fieldnames(res_arcopt);

  % extract important data
  hc_arcopt = cell2mat(C_arcopt(:,end));

  fev_arcopt = cell2mat(C_arcopt(:,5));

  % print report
  num_prob = length(res_arcopt);
  num_arcopt = sum(hc_arcopt);
  fprintf('... arcopt hcp summary ...\n');
  fprintf('total number of problems.. %d\n',num_prob);
  fprintf('arcopt # solved........... %d\n',num_arcopt);
  fprintf('arcopt %% solved........... %g\n',num_arcopt/num_prob);
  fprintf('arcopt total fev.......... %g\n',sum(fev_arcopt));
  fprintf('arcopt avg fev............ %g\n',sum(fev_arcopt)/num_prob);
  
  % 10 node problems
  code = 2;
  res_lx = res_code == code;
  num_prob = sum(res_lx);
  num_arcopt = sum(hc_arcopt(res_lx));
  fprintf('\n... arcopt hcp summary: 10 nodes ...\n');
  fprintf('number of graphs.......... %d\n',sum(hcp_code == code));
  fprintf('number of graphs with hc.. %d\n',num_prob);
  fprintf('arcopt # solved........... %g\n',num_arcopt);
  fprintf('arcopt %% solved........... %g\n',num_arcopt/num_prob);
  fprintf('arcopt total fev.......... %g\n',sum(fev_arcopt(res_lx)));
  fprintf('arcopt avg fev............ %g\n',sum(fev_arcopt(res_lx))/num_prob);
  
  % 12 node problems
  code = 3;
  res_lx = res_code == code;
  num_prob = sum(res_lx);
  num_arcopt = sum(hc_arcopt(res_lx));
  fprintf('\n... arcopt hcp summary: 12 nodes ...\n');
  fprintf('number of graphs.......... %d\n',sum(hcp_code == code));
  fprintf('number of graphs with hc.. %d\n',num_prob);
  fprintf('arcopt # solved........... %g\n',num_arcopt);
  fprintf('arcopt %% solved........... %g\n',num_arcopt/num_prob);
  fprintf('arcopt total fev.......... %g\n',sum(fev_arcopt(res_lx)));
  fprintf('arcopt avg fev............ %g\n',sum(fev_arcopt(res_lx))/num_prob);
  
  % 14 node problems
  code = 4;
  res_lx = res_code == code;
  num_prob = sum(res_lx);
  num_arcopt = sum(hc_arcopt(res_lx));
  fprintf('\n... arcopt hcp summary: 14 nodes ...\n');
  fprintf('number of graphs.......... %d\n',sum(hcp_code == code));
  fprintf('number of graphs with hc.. %d\n',num_prob);
  fprintf('arcopt # solved........... %g\n',num_arcopt);
  fprintf('arcopt %% solved........... %g\n',num_arcopt/num_prob);
  fprintf('arcopt total fev.......... %g\n',sum(fev_arcopt(res_lx)));
  fprintf('arcopt avg fev............ %g\n',sum(fev_arcopt(res_lx))/num_prob);
  
  %keyboard
  
end

function n = cell_filt(s)

  switch s(1:2)
    case '10'
      n = 2;
    case '12'
      n = 3;
    case '14'
      n = 4;
    otherwise
      n = 1;
  end

end