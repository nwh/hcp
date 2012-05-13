%drv_test_obj  test the hcp objective function

function drv_test_obj
  
  %% set up problem
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
%   P = hcp_edg2adj(E);

  P = graph30;

  n = size(P,1);
  [i j] = find(P);
  
  %% compute initial point
  %x0 = hcp_cvx_init1(P);
  %x0 = [  2/3  1/6  1/6  2/3  1/6  1/6  1/6  2/3  1/6  1/6  2/3  1/6  1/6  1/6  2/3  1/6  1/6  2/3  ];
  m = length(i);
  %v = 0.5*ones(m,1);
  v = rand(m,1);
  %v = zeros(m,1);
  x0 = hcp_cvx_init2(P,v);
  
  %% get constraints
  [A b] = hcp_con(P);
  Px = hcp_P2Px(P,x0);

  % evaluate function
  [f g H] = hcp_obj(x0,P);
  
  %% inspect patterns
  Hp = hcp_hess_pat(P);
  
  figure(1); spy(H);
  figure(2); spy(Hp);
  
  H1 = H;
  H1(find(H1)) = 1;
  norm(Hp-H1,1)
  
  %% test single evaluations
  f = hcp_func(x0,P);
  g = hcp_grad(x0,P);
  H = hcp_hess(x0,P,'L');
  spy(H);
  
  %% test derivatives
  [g_fd g_true] = grad_checker(@(s)hcp_obj(s,P),x0,1e-8);
  g_err = norm(g_fd-g_true)
  
  [H_fd H_true] = hess_checker(@(s)hcp_obj(s,P),x0,1e-8);
  H_err = norm(H_fd-H_true,1)
  
end