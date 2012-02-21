% get graph
P = graph24;
x0 = hcp_cvx_init1(P);

% arcopt options
arcopt_options = arcopt_nm_lc.optset();
arcopt_options.crash = 'firstm';
arcopt_options.print_screen = 1;
arcopt_options.cycle_guard = 0;

% solve tol
solve_tol = -.99;

% solve it
slv = hcp_arcopt(P,x0,'cycle-guard-test',solve_tol,arcopt_options);