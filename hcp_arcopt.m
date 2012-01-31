%hcp_arcopt  attempt to solve hcp with arcopt

function [hcp_slv] = hcp_arcopt(P,name,solve_tol,print_fname)
  
  % handle optional input
  if nargin < 2 || isempty(name)
    name = 'hcp_problem';
  end
  
  if nargin < 3 || isempty(solve_tol)
    solve_tol = -.99;
  end
  
  if nargin < 4 || isempty(print_fname)
    print_fname = '';
  end
  
  % get number of edges
  num_edges = sum(P(:));
  
  % get initial point
  x0 = hcp_cvx_init1(P);
  
  %v = rand(num_edges,1);
  %x0 = hcp_cvx_init2(P,v);
  
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
  if print_fname
    print_fid = fopen(print_fname,'w');
  else
    print_fid = 0;
  end
  
  % options for arcopt
  options = arcopt_nm_lc.optset();
  options.crash = 'firstm';
  options.print_file = print_fid;
  options.print_level = 'iter';
  options.print_screen = 1;

  % solve
  mysolver = arcopt_nm_lc(func,hess,x0,bl,bu,A,c,c,options);
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
  if print_fname
    fclose(print_fid);
  end
  
  %keyboard

end

function [f g] = usrfun(x,P)
  [f g] = hcp_obj(x,P);
end

function H = usrhess(x,P)
  H = hcp_hess(x,P);
end