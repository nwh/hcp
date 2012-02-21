%step3  analyze the results, print tables

function step3
  
  % load experiment data and results
  load exp_data
  load exp_results
  
  % get some counts
  num_graph = length(graph_data);
  num_x0 = num_rand_x0 + 1;
  
  % get graph names
  for i = 1:num_graph
    graph_names{i,1} = graph_data(i).name;
  end
  
  % get result table for arcopt
  arcopt_table = zeros(num_graph,num_x0);
  for i = 1:num_graph
    for j = 1:num_x0
      arcopt_table(i,j) = arcopt_slv(i,j).fevcnt;
      if ~arcopt_slv(i,j).hc_found
        arcopt_table(i,j) = 0;
      end
    end
  end

  % get result table for ipopt
  ipopt_table = zeros(num_graph,num_x0);
  for i = 1:num_graph
    for j = 1:num_x0
      ipopt_table(i,j) = ipopt_slv(i,j).fevcnt;
      if ~ipopt_slv(i,j).hc_found
        ipopt_table(i,j) = 0;
      end
    end
  end

  % construct cells
  arcopt_cell = prod_cell(graph_names,arcopt_table);
  ipopt_cell = prod_cell(graph_names,ipopt_table);
  
  % write cells to disk
  mcute_cell2org(arcopt_cell,'table_arcopt.org');
  mcute_cell2org(ipopt_cell,'table_ipopt.org');
  
  %keyboard
  
end

function C = prod_cell(names,data)
  
  names = names';
  data = data';
  [m n] = size(data);
  
  % compute stats
  num_solved = sum(data > 0);
  frac_solved = num_solved / m;
  total_fev = sum(data);
  avg_fev = total_fev ./ num_solved;
  
  S = [num_solved; frac_solved; total_fev; avg_fev];
  
  % construct final cell
  D = [(1:m+4)' [data; S] ];
  DC = num2cell(D);
  DC = ['x0' names; DC];
  
  DC{m+2,1} = 'num_solved';
  DC{m+3,1} = 'frac_solved';
  DC{m+4,1} = 'total_fev';
  DC{m+5,1} = 'avg_fev';
  
  
  C = DC;
  
  %keyboard
  
end


