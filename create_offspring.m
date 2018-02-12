function output = create_offspring(Prey, i,parent2,mutval,generation,no_generations)
%myFun - Description
%
% Syntax: children = create_offspring(Prey, i,parent2,P_node_xover,P_mutation,Mut_alfa)
%
% Long description
P_node_xover = 0.8; %Prob with which a node is exchanged
P_mutation = 0.3;   %Prob with which a connection mutates
Mut_alfa = 0.7;     %Mutation parameter
P_kill_connection = 0.1;
cross_technique = 'short';
mut_technique = 'short';
for layer = 1:length(Prey)
 %**********Crossover*********************
	%Exchanging "node-packages"
	Offsprng1{layer} = Prey{layer}(i,:,:);
	Offsprng2{layer} = Prey{layer}(parent2,:,:);
	switch cross_technique
	case 'short'
		connections = numel(Offsprng1{layer});
		exchange = binornd(connections,P_node_xover);
		exchange = randperm(connections,exchange);
		Offsprng_tmp = Offsprng1{layer};
		Offsprng1{layer}(exchange) = Offsprng2{layer}(exchange);
		Offsprng2{layer}(exchange) = Offsprng_tmp(exchange);
	end
	switch mut_technique
	case 'short'
		connections = numel(Offsprng1{layer});
		mutate = binornd(connections,P_mutation);
		mutate = randperm(connections,mutate);
		%mutval = squeeze(std(Prey{layer}));
        Offsprng1{layer}(mutate) = Offsprng1{layer}(mutate) + (-1).^round(rand(1,length(mutate))).*mutval{layer}(mutate)*Mut_alfa*(1-generation/no_generations);
		Offsprng1{layer}(mutate(1:ceil(P_kill_connection*length(mutate)))) = 0;
		mutate = binornd(connections,P_mutation);
		mutate = randperm(connections,mutate);
		%mutval = squeeze(std(Prey{layer}));
		Offsprng2{layer}(mutate) = Offsprng2{layer}(mutate) + (-1).^round(rand(1,length(mutate))).*mutval{layer}(mutate)*Mut_alfa*(1-generation/no_generations);
		Offsprng2{layer}(mutate(1:ceil(P_kill_connection*length(mutate)))) = 0;
	end
	output{layer}(1,:,:) = Offsprng1{layer};
	output{layer}(2,:,:) = Offsprng2{layer};
end

end