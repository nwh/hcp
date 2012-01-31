%hcp_ipopt  attempt to solve hcp problem with ipopt

function hcp_slv = hcp_ipopt(P,name,solve_tol)
  
  % handle optional input
  if nargin < 2 || isempty(name)
    name = 'hcp_problem';
  end
  
  if nargin < 3 || isempty(solve_tol)
    solve_tol = -.99;
  end
  
  % get number of edges
  num_edges = sum(P(:));
  
  % get initial point
  x0 = hcp_cvx_init1(P);

  % get constraints
  [A c] = hcp_con(P);
  A = A(1:end-1,:);
  c = c(1:end-1);
  
  % instrument for function eval count
  fevcnt = 0;
  function f = anon_hcp_func(x)
    fevcnt = fevcnt + 1;
    f = hcp_func(x,P);
  end
  
  % construct function struct
  funcs.objective = @(x) anon_hcp_func(x);
  funcs.gradient = @(x) hcp_grad(x,P);
  funcs.constraints = @(x) A*x;
  funcs.jacobian = @(x) A;
  funcs.jacobianstructure = @() A;
  funcs.hessian = @(x,sigma,lambda) sigma*hcp_hess(x,P,'L');
  funcs.hessianstructure = @() hcp_hess_pat(P,'L');
  
  % set bounds
  options.lb = zeros(num_edges,1);
  options.ub = ones(num_edges,1);
  options.cl = c;
  options.cu = c;

  % set ipopt options
  options.ipopt.print_level = 5;
  %options.ipopt.derivative_test = 'second-order';
  options.ipopt.jac_c_constant = 'yes';
  %options.ipopt.hessian_approximation = 'limited-memory';
  %options.ipopt.limited_memory_max_history = 20;
  
  % call ipopt
  [xstar, info] = ipopt(x0,funcs,options);

  % prepare output structure
  hcp_slv.xstar = xstar;
  hcp_slv.fstar = anon_hcp_func(xstar);
  hcp_slv.solver_info = info.status;
  hcp_slv.itercnt = info.iter;
  hcp_slv.fevcnt = fevcnt;
  hcp_slv.name = name;
  
  if hcp_slv.fstar <= solve_tol
    hcp_slv.hc_found = 1;
  else
    hcp_slv.hc_found = 0;
  end
  
end