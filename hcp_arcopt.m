%hcp_arcopt  attempt to solve hcp with arcopt

function [x info] = hcp_arcopt(P)

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
  
  % options for arcopt
  options = arcopt_nm_lc.optset();
  options.crash = 'firstm';

  % solve
  mysolver = arcopt_nm_lc(func,hess,x0,bl,bu,A,c,c,options);
  [xstar f flg aux] = mysolver.solve();

  x = xstar;
  info = f;
  
  %keyboard

end

function [f g] = usrfun(x,P)
  [f g] = hcp_obj(x,P);
end

function H = usrhess(x,P)
  H = hcp_hess(x,P);
end