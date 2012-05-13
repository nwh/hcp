%make_prof  generate performance profile for HCP results

function make_prof
  
  load res_arcopt
  load res_ipopt
  
  arc_cell = struct2cell(res_arcopt)';
  ip_cell = struct2cell(res_ipopt)';
  
  fev = [cell2mat(arc_cell(:,5)) cell2mat(ip_cell(:,5))];
  hc = [cell2mat(arc_cell(:,7)) cell2mat(ip_cell(:,7))];
  
  fev(hc ~= 1) = nan;
  
  figure(1); clf
  perf(fev)
  xlim([.5 12])
  
  xlabel('relative performance','fontsize',14)
  ylabel('fraction solved','fontsize',14)
  
  legend('arcopt','ipopt','location','southeast')
  
  print -depsc2 hcp-perf
  
  keyboard
  
end
