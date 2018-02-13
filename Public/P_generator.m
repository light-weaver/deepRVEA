function offspring = P_generator(Input,mutval,generation,no_generations)
%P_generator - Description
%
% Syntax: offspring = P_generator(input)
%
% Long description
	P_node_xover = 0.8; %Prob with which a node is exchanged
	P_mutation = 0.3;   %Prob with which a connection mutates
	Mut_alfa = 0.7;     %Mutation parameter
	P_kill_connection = 0.1;
	% cross_technique = 'short';
	% mut_technique = 'short';
	num_runs = 1;
	num_individuals = size(Input{1},1);
	num_layers = length(Input);
	off_count = 1;
	for i = 1:num_runs
		for ind = 1:num_individuals
			p2 = ceil(rand*num_individuals);
			for layer = 1:num_layers
				Offsprng1{layer} = Input{layer}(ind,:,:);
				Offsprng2{layer} = Input{layer}(p2,:,:);
				%Crossover++++++++++++++++++++++++++++++++++++++
				connections = numel(Offsprng1{layer});
				exchange = binornd(connections,P_node_xover);
				exchange = randperm(connections,exchange);
				Offsprng_tmp = Offsprng1{layer};
				Offsprng1{layer}(exchange) = Offsprng2{layer}(exchange);
				Offsprng2{layer}(exchange) = Offsprng_tmp(exchange);
				%Mutatuion+++++++++++++++++++++++++++++++++++++++
				mutate = binornd(connections,P_mutation);
				mutate = randperm(connections,mutate);
				Offsprng1{layer}(mutate) = Offsprng1{layer}(mutate) + (-1).^round(rand(1,length(mutate))).*mutval{layer}(mutate)*Mut_alfa*(1-generation/no_generations);
				Offsprng1{layer}(mutate(1:ceil(P_kill_connection*length(mutate)))) = 0;
				mutate = binornd(connections,P_mutation);
				mutate = randperm(connections,mutate);
				%mutval = squeeze(std(Prey{layer}));
				Offsprng2{layer}(mutate) = Offsprng2{layer}(mutate) + (-1).^round(rand(1,length(mutate))).*mutval{layer}(mutate)*Mut_alfa*(1-generation/no_generations);
				Offsprng2{layer}(mutate(1:ceil(P_kill_connection*length(mutate)))) = 0;
				%++++++++++++++++++++++++++++++++++++++++++++++++
				offspring{layer}(off_count,:,:) = Offsprng1{layer};
				offspring{layer}(off_count+1,:,:) = Offsprng2{layer};
			end
			off_count = off_count+2;
		end
	end
end