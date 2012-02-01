%hcp_arcopt  attempt to solve hcp with arcopt

function [hcp_slv] = hcp_arcopt(P,x0,name,solve_tol,solver_options)
  
  % handle optional input
  if nargin < 3 || isempty(name)
    name = 'hcp_problem';
  end
  
  if nargin < 4 || isempty(solve_tol)
    solve_tol = -.99;
  end
  
  if nargin < 5 || isempty(solver_options)
    solver_options = arcopt_nm_lc.optset();
    solver_options.crash = 'firstm';
    solver_options.print_screen = 0;
  end
  
  % get number of edges
  num_edges = sum(P(:));
  
  % get function handles
  func = @(x) usrfun(x,P);
  hess = @(x) usrhess(x,P);
  
  % get constraints
  [A c] = hcp_con(P);
  A = A(1:end-1,:);
  c = c(1:end-1);
  
  % set bounds
  bl = zeros(num_edges,1);
  bu = ones(num_edges,1);
  
  % open print file if requested
  if ischar(solver_options.print_file)
    solver_options.print_file = fopen(solver_options.print_file,'w');
  end
  
  % solve
  mysolver = arcopt_nm_lc(func,hess,x0,bl,bu,A,c,c,solver_options);
  [xstar fstar solver_info aux] = mysolver.solve();

  % prepare output structure
  hcp_slv.xstar = xstar;
  hcp_slv.fstar = fstar;
  hcp_slv.solver_info = solver_info;
  hcp_slv.itercnt = aux.phase2cnt;
  hcp_slv.fevcnt = aux.fevcnt;
  hcp_slv.name = name;
  
  if fstar <= solve_tol
    hcp_slv.hc_found = 1;
  else
    hcp_slv.hc_found = 0;
  end
  
  % close file if opened
  if solver_options.print_file
    fclose(solver_options.print_file);
  end
  
  %keyboard

end

function [f g] = usrfun(x,P)
  [f g] = hcp_obj(x,P);
end

function H = usrhess(x,P)
  H = hcp_hess(x,P);
end