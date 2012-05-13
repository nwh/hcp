% tst1.m  run the singly stochastic test

% set the random number generator
rng(10);

% get the graph
P = graph30;
[nnode ~] = size(P);
e = ones(nnode,1);

% get the initial point
[i ~] = find(P);
nvar = length(i);
v = rand(nvar,1);
x0 = hcp_cvx_init2(P,v);
Px = hcp_P2Px(P,x0);

% run arcopt
solver_options = arcopt_nm_lc.optset();
[hcp_slv] = hcp_arcopt(P,x0,'test1',.95,solver_options)