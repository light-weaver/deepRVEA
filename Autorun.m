Problem = 'zdt1data'; %Problem name
%savedir = ; %current directory
RVEAtrain.name = 'autorun';
%%%%%%%%%%%%++Parameters++%%%%%%%%%%%%%
RVEAtrain.Generations = 200;		%Number of generations 
RVEAtrain.NNet_str = [10 5];           %maximum number of nodes
RVEAtrain.in_index = [1:30];		%The variable columns
RVEAtrain.out_index = [32];			%The objective columns
RVEAtrain.p1p2 = num2cell([20 0]); %%[p1 p2] define the number of reference vectors. p1 is the number of divisions along an axis
RVEAtrain.N = 120;  %%defines the initial population size.
RVEAtrain.alpha = 10; % the parameter in APD, the bigger, the faster RVEA converges. Default = 2.
RVEAtrain.fr = 0.1; % frequency to call reference vector realignment
%=====================================================
output.RVEAtrain = RVEAtrain;
Train(Problem,output);