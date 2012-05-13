load test_mat1

solver_options = arcopt_nm_lc.optset();
solver_options.crash = 'firstm';
solver_options.print_screen = 1;

num_var = sum(sum(P));
v = rand(num_var,1);
%x0 = hcp_cvx_init2(P,v);
x0 = hcp_cvx_init1(P);

[f g H] = hcp_obj(x0,P)

[hcp_slv] = hcp_arcopt(P,x0,'go',-.99,solver_options);