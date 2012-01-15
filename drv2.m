% solve hcp problem with mgf_lc

function drv2
  
  % construct graph
  % envelope graph
  E = [1 2
    1 5
    1 4
    2 6
    2 3
    3 6
    3 4
    4 5
    5 6];
  
  [P num_edges] = hcp_edg2adj(E);
  
  % get initial point
  x0 = hcp_cvx_init1(P);
  
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
  mysolver = mgf_lc(func,hess,x0,bl,bu,A,c,c,options);
  [xstar f flg aux] = mysolver.solve();
  
  keyboard
  
end

function [f g] = usrfun(x,P)
  [f g] = hcp_obj(x,P);
end

function H = usrhess(x,P)
  [f g H] = hcp_obj(x,P);
end