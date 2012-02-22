
N = [10 12 14 24 30 38]
A = [16 19 23 34 39 48]
I = [109 115 123 121 347 644]
  

figure(1)
subplot(2,1,1)
plot(N,A,'o-')

title('arcopt on hcp')
xlabel('number of nodes (all degree 3)')
ylabel('func evals')

N2 = [30 36 42 72 90 114 120]
A2 = [16 19 23 34 39 48 71]

subplot(2,1,2)
plot(N2,A2,'o-')

xlabel('number of variables (last one is degree 4)')
ylabel('func evals')

print -depsc2 arcopt_hcp_iter