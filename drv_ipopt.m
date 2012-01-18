%drv_ipopt attempt to solve hcp problem with ipopt

function drv_ipopt

  % construct graph
  % envelope graph
%   E = [1 2
%     1 5
%     1 4
%     2 6
%     2 3
%     3 6
%     3 4
%     4 5
%     5 6];
%   
%   [P num_edges] = hcp_edg2adj(E);
  
  addpath graphs
  P = envelope;
  num_edges = sum(sum(P));

  % get initial point
  x0 = hcp_cvx_init1(P);
  %v = rand(num_edges,1);
  %x0 = hcp_cvx_init2(P,v);

  % get constraints
  [A c] = hcp_con(P);
  A = A(1:end-1,:);
  c = c(1:end-1);
  
  % construct function struct
  funcs.objective = @(x) hcp_func(x,P);
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
  %options.ipopt.derivative_test = 'second-order';
  options.ipopt.jac_c_constant = 'yes';
  %options.ipopt.hessian_approximation = 'limited-memory';
  %options.ipopt.limited_memory_max_history = 20;
  
  % call ipopt
  [x, info] = ipopt(x0,funcs,options);
  
  keyboard
  
end
