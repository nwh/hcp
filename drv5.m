% solve random hcp problem with mgf_lc

function drv5
  
  % settings
  num_nodes = 25;
  add_edges = 0;
  
  % generate random graph
  P = hcp_rand1(num_nodes,add_edges);
  [i j] = find(P);
  num_edges = length(i);
  
  % get initial point
  x0 = hcp_cvx_init1(P);
  %x0 = hcp_cvx_init2(P,[1; zeros(num_edges-1,1)]);
  
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
  
  % set up mgf
  options = mgf_lc.optset();
  options.crash = 'firstm';
  mysolver = mgf_lc(func,hess,x0,bl,bu,A,c,c,options);
  [xstar f flg aux] = mysolver.solve();
  
  %keyboard
  
end

function [f g] = usrfun(x,P)
  [f g] = hcp_obj(x,P);
end

function H = usrhess(x,P)
  [f g H] = hcp_obj(x,P);
end