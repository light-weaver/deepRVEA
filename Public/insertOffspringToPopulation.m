function Offspring = insertOfspringToPopulation(Population,Offspring)
%insertOfspringToPopulation - Description
%
% Syntax: output = insertOfspringToPopulation(Population,Offspring)
%
% Long description
	pop_length = length(Population{1});
	pop_length = pop_length + 1;
	offsprng_length = length(Offspring{1});
	num_layers = length(Population);
	for off_index = 1:offsprng_length
		for layer = 1:num_layers
			Population{layer}(pop_length,:,:) = Offspring{layer}(off_index,:,:);
		end
		pop_length = pop_length + 1;
	end
end