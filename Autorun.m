Problem = ""; %Problem name
savedir = ; %current directory

%%%%%%%%%%%%++Parameters++%%%%%%%%%%%%%
RVEAtrain.Generations = 500;
RVEAtrain.NNet_str = [5 5 5];           %maximum number of nodes
RVEAtrain.in_index = [];
RVEAtrain.out_index = [];
RVEAtrain.p1p2 = num2cell([100 0]); %%[p1 p2] define the number of reference vectors. p1 is the number of divisions along an axis
RVEAtrain.N = 120;  %%defines the population size.
RVEAtrain.alpha = 2; % the parameter in APD, the bigger, the faster RVEA converges
RVEAtrain.fr = 0.1; % frequency to call reference vector
%=====================================================
output.RVEAtrain = RVEAtrain;