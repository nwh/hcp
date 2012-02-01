%step1  collect data and generate random starting points

function step1
  
  % settings
  num_rand_x0 = 19; % number of random starting points
  buffer = .1;
  rng_seed = 12345;
  
  % set the random number generator
  RandStream.setDefaultStream(RandStream('mt19937ar','seed',rng_seed));
  
  % load the graph data
  graph_data(1).P = graph24;
  graph_data(1).num_edg = hcp_num_edg(graph_data(1).P);
  graph_data(1).name = 'node-24_deg-3';

  graph_data(2).P = graph30;
  graph_data(2).num_edg = hcp_num_edg(graph_data(2).P);
  graph_data(2).name = 'node-30_deg-3';
  
  graph_data(3).P = graph30degree4;
  graph_data(3).num_edg = hcp_num_edg(graph_data(3).P);
  graph_data(3).name = 'node-30_deg-4';

  graph_data(4).P = graph38;
  graph_data(4).num_edg = hcp_num_edg(graph_data(4).P);
  graph_data(4).name = 'node-38_deg-3';
  
  % storage for starting points
  for i = 1:length(graph_data)
    graph_data(i).X0 = zeros(graph_data(i).num_edg,num_rand_x0+1);
  end
  
  % compute analytic centers for X0(:,1)
  for i = 1:length(graph_data)
    graph_data(i).X0(:,1) = hcp_cvx_init1(graph_data(i).P);
  end
  
  % compute remainting starting points
  progressbar('graph','initial point')
  for i = 1:length(graph_data)
    % get random points
    XR = (1-2*buffer)*rand(graph_data(i).num_edg,num_rand_x0)+buffer;
    for j = 1:num_rand_x0
      graph_data(i).X0(:,j+1) = hcp_cvx_init2(graph_data(i).P,XR(:,j));
      
      if ~all(isfinite(graph_data(i).X0(:,j+1)))
        keyboard
      end
      
      frac2 = j/num_rand_x0;
      frac1 = ((i-1)+frac2)/length(graph_data);
      progressbar(frac1,frac2);
    end
  end
  
  % check to make sure data is finite
  for i = 1:length(graph_data)
    if ~all(isfinite(graph_data(i).X0(:)))
      fprintf('non finite data in: %d\n',i)
    end
  end
  
  save('exp_data.mat','graph_data','num_rand_x0','rng_seed')
  
  % keyboard

end