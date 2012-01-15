% attempt to solve hcp problem with snopt

function drv6

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

  % get constraints
  [A c] = hcp_con(P);
  A = A(1:end-1,:);
  c = c(1:end-1);
  
  % set bounds
  bl = zeros(num_edges,1);
  bu = ones(num_edges,1);

  % get snlc prob struct
  prob = snlc_solve();
  
  % create spc struct
  prob.spc_struct.major_print_level = '1';
  prob.spc_struct.minor_print_level = '1';
  prob.spc_struct.total_integer_workspace = '50000';
  prob.spc_struct.total_real_workspace = '50000';
  
  prob.name = 'hcp-envelope';
  prob.x0 = x0;
  prob.bl = bl;
  prob.bu = bu;
  prob.A = A;
  prob.cl = c;
  prob.cu = c;
  prob.usrfun = func;
  
  % solve problem
  out = snlc_solve(prob);
  
  out.xstar
  out.info

  keyboard
  
end

function [f g] = usrfun(x,P)
  [f g] = hcp_obj(x,P);
end