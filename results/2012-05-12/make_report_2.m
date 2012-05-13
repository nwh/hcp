% generate report for hcp exp with 10,12,and 14 node cubic graphs
%
% you should run hcp_setup before this!

function make_report_2

load('hcp_data.mat')
load('res_arcopt.mat')
load('res_ipopt.mat')

% remove first 3 graphs
res_arcopt = res_arcopt(4:end);
res_ipopt = res_ipopt(4:end);

% graph and graph-hc counts
num_10 = length(hcp_10);
num_12 = length(hcp_12);
num_14 = length(hcp_14);
num_tot = num_10+num_12+num_14;

hc_10 = arrayfun(@(x)hcp_10(x).is_hamil,1:num_10);
hc_12 = arrayfun(@(x)hcp_12(x).is_hamil,1:num_12);
hc_14 = arrayfun(@(x)hcp_14(x).is_hamil,1:num_14);

num_10_hc = sum(hc_10);
num_12_hc = sum(hc_12);
num_14_hc = sum(hc_14);
num_tot_hc = num_10_hc+num_12_hc+num_14_hc;

% get cells
CA = struct2cell(res_arcopt)';
CI = struct2cell(res_ipopt)';
num_run = length(res_arcopt);

lx_10 = arrayfun(@(x) strcmp(CA{x,6}(1:2),'10'),1:num_run);
lx_12 = arrayfun(@(x) strcmp(CA{x,6}(1:2),'12'),1:num_run);
lx_14 = arrayfun(@(x) strcmp(CA{x,6}(1:2),'14'),1:num_run);

arcopt_fev = cell2mat(CA(:,5));
arcopt_hc = cell2mat(CA(:,7));
num_arcopt_hc = sum(arcopt_hc);
num_arcopt_fev = sum(arcopt_fev);

ipopt_fev = cell2mat(CI(:,5));
ipopt_hc = cell2mat(CI(:,7));
num_ipopt_hc = sum(ipopt_hc);
num_ipopt_fev = sum(ipopt_fev);

fid = fopen('report.org','w');
fprintf(fid,'* total\n');
fprintf(fid,'|%s|%d|%d|\n','num graphs',num_tot,0);
fprintf(fid,'|%s|%d|%d|\n','num graphs with hc',num_tot_hc,0);
fprintf(fid,'|%s|%d|%d|\n','num hc found',num_arcopt_hc,num_ipopt_hc);
fprintf(fid,'|%s|%.1f|%.1f|\n','% found',100*num_arcopt_hc/num_tot_hc,100*num_ipopt_hc/num_tot_hc);
fprintf(fid,'|%s|%d|%d|\n','tot fev',num_arcopt_fev,num_ipopt_fev);
fprintf(fid,'|%s|%.1f|%.1f|\n','avg fev',num_arcopt_fev/num_tot_hc,num_ipopt_fev/num_tot_hc);

fprintf(fid,'* 10 node\n');
fprintf(fid,'|%s|%d|%d|\n','num 10 node graphs',num_10,0);
fprintf(fid,'|%s|%d|%d|\n','num 10 node graphs with hc',num_10_hc,0);
fprintf(fid,'|%s|%d|%d|\n','num hc found',sum(arcopt_hc(lx_10)),sum(ipopt_hc(lx_10)));
fprintf(fid,'|%s|%.1f|%.1f|\n','% found',100*sum(arcopt_hc(lx_10))/num_10_hc,100*sum(ipopt_hc(lx_10))/num_10_hc);
fprintf(fid,'|%s|%d|%d|\n','tot fev',sum(arcopt_fev(lx_10)),sum(ipopt_fev(lx_10)));
fprintf(fid,'|%s|%.1f|%.1f|\n','avg fev',sum(arcopt_fev(lx_10))/num_10_hc,sum(ipopt_fev(lx_10))/num_10_hc);

fprintf(fid,'* 12 node\n');
fprintf(fid,'|%s|%d|%d|\n','num 12 node graphs',num_12,0);
fprintf(fid,'|%s|%d|%d|\n','num 12 node graphs with hc',num_12_hc,0);
fprintf(fid,'|%s|%d|%d|\n','num hc found',sum(arcopt_hc(lx_12)),sum(ipopt_hc(lx_12)));
fprintf(fid,'|%s|%.1f|%.1f|\n','% found',100*sum(arcopt_hc(lx_12))/num_12_hc,100*sum(ipopt_hc(lx_12))/num_12_hc);
fprintf(fid,'|%s|%d|%d|\n','tot fev',sum(arcopt_fev(lx_12)),sum(ipopt_fev(lx_12)));
fprintf(fid,'|%s|%.1f|%.1f|\n','avg fev',sum(arcopt_fev(lx_12))/num_12_hc,sum(ipopt_fev(lx_12))/num_12_hc);

fprintf(fid,'* 14 node\n');
fprintf(fid,'|%s|%d|%d|\n','num 14 node graphs',num_14,0);
fprintf(fid,'|%s|%d|%d|\n','num 14 node graphs with hc',num_14_hc,0);
fprintf(fid,'|%s|%d|%d|\n','num hc found',sum(arcopt_hc(lx_14)),sum(ipopt_hc(lx_14)));
fprintf(fid,'|%s|%.1f|%.1f|\n','% found',100*sum(arcopt_hc(lx_14))/num_14_hc,100*sum(ipopt_hc(lx_14))/num_14_hc);
fprintf(fid,'|%s|%d|%d|\n','tot fev',sum(arcopt_fev(lx_14)),sum(ipopt_fev(lx_14)));
fprintf(fid,'|%s|%.1f|%.1f|\n','avg fev',sum(arcopt_fev(lx_14))/num_14_hc,sum(ipopt_fev(lx_14))/num_14_hc);

fclose(fid);

%keyboard

end