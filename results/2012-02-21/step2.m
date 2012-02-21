%step2  attempt to solve problems with arcopt and ipopt

function step2
  
  % load data
  load exp_data

  % solve_tol
  solve_tol = -.99;
  
  % number of graphs
  num_graph = length(graph_data);
  num_x0 = num_rand_x0 + 1;
  
  % setup arcopt options
  arcopt_options = arcopt_nm_lc.optset();
  arcopt_options.crash = 'firstm';
  arcopt_options.print_screen = 0;
  
  % setup ipopt options
  ipopt_options.print_level = 5;
  
  progressbar('graph','initial point')
  for i = 1:num_graph
    P = graph_data(i).P;
    for j = 1:num_x0
      x0 = graph_data(i).X0(:,j);
      name = sprintf('%s-%02d',graph_data(i).name,j);

      % run arcopt
      arcopt_filename = ['run_arcopt/' name '.txt'];
      arcopt_options.print_file = arcopt_filename;
      arcopt_slv(i,j) = hcp_arcopt(P,x0,name,solve_tol,arcopt_options);
      
      % run ipopt
      ipopt_filename = ['run_ipopt/' name '.txt'];
      diary(ipopt_filename);
      ipopt_slv(i,j) = hcp_ipopt(P,x0,name,solve_tol,ipopt_options);
      diary off
      
      frac2 = j/num_x0;
      frac1 = ((i-1)+frac2)/num_graph;
      progressbar(frac1,frac2);
    end
  end
  
  save('exp_results.mat','arcopt_slv','ipopt_slv');
  
  %keyboard
  
end