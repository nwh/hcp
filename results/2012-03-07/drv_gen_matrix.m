
rseed = 2453763;
RandStream.setDefaultStream(RandStream('mt19937ar','seed',rseed));

num_nodes = 50;
add_edges = 25;
[P xc] = hcp_rand1(num_nodes,add_edges);
f = hcp_obj(xc,P)
