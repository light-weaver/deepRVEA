Problem = 'zdt1data'; %Problem name
%savedir = ; %current directory
RVEAtrain.name = 'autorun';
%%%%%%%%%%%%++Parameters++%%%%%%%%%%%%%
RVEAtrain.Generations = 1000;
RVEAtrain.NNet_str = [20];           %maximum number of nodes
RVEAtrain.in_index = [1:30];
RVEAtrain.out_index = [32];
RVEAtrain.p1p2 = num2cell([100 0]); %%[p1 p2] define the number of reference vectors. p1 is the number of divisions along an axis
RVEAtrain.N = 120;  %%defines the population size.
RVEAtrain.alpha = 10; % the parameter in APD, the bigger, the faster RVEA converges
RVEAtrain.fr = 0.1; % frequency to call reference vector
%=====================================================
output.RVEAtrain = RVEAtrain;
Train(Problem,output);