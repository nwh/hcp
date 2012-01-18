
%% setup
close all
clear all

%% get the envelope graph
hcp_set(1).P = envelope();
hcp_set(1).name = 'envelope';
hcp_set(1).is_hamil = 1;
hcp_set(1).num_edges = sum(sum(hcp_set(1).P));

%% get graph8
hcp_set(2).P = graph8();
hcp_set(2).name = 'graph8';
hcp_set(2).is_hamil = 1;
hcp_set(2).num_edges = sum(sum(hcp_set(2).P));

%% get graph12
hcp_set(3).P = graph12();
hcp_set(3).name = 'graph12';
hcp_set(3).is_hamil = 1;
hcp_set(3).num_edges = sum(sum(hcp_set(3).P));

%% get 10 node
n10 = load('10_node.mat');
n10_num = length(n10.hamil);
cnt = 0
for i = 1:n10_num
  
  cnt = cnt + 1;
  hcp_10(cnt).P = n10.mat{i};
  hcp_10(cnt).name = sprintf('10_node(%02d)',i);
  hcp_10(cnt).is_hamil = n10.hamil(i);
  hcp_10(cnt).num_edges = sum(sum(hcp_10(cnt).P));
  
end

%% get 12 node
n12 = load('12_node.mat');
n12_num = length(n12.hamil);
cnt = 0;
for i = 1:n12_num
  
  cnt = cnt + 1;
  hcp_12(cnt).P = n12.mat{i};
  hcp_12(cnt).name = sprintf('12_node(%02d)',i);
  hcp_12(cnt).is_hamil = n12.hamil(i);
  hcp_12(cnt).num_edges = sum(sum(hcp_12(cnt).P));
  
end

%% get 14 node
n14 = load('14_node.mat');
n14_num = length(n14.hamil);
cnt = 0;
for i = 1:n14_num
  
  cnt = cnt + 1;
  hcp_14(cnt).P = n14.mat{i};
  hcp_14(cnt).name = sprintf('14_node(%03d)',i);
  hcp_14(cnt).is_hamil = n14.hamil(i);
  hcp_14(cnt).num_edges = sum(sum(hcp_14(cnt).P));
  
end

%% orient to columns
hcp_set = hcp_set(:);
hcp_10 = hcp_10(:);
hcp_12 = hcp_12(:);
hcp_14 = hcp_14(:);

%% save data
save('hcp_data','hcp_set','hcp_10','hcp_12','hcp_14')
