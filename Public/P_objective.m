function [Output, IC] = P_objective(Operation,parameters,Input,final)
% Operation defines the use case of this function
%	case : init  to initialize the deep neural net population
%	case : value to fine the error and complexity of the neural net population or individual
%
% parameters are all the parameters used in the code
%
% Input is the population size in case: init
% Input is the population member/individual in case: value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    P_omit_match = 0.3;
	IC = NaN;
	switch Operation
		case 'init'
			NNet_str = parameters.NNet_str;
			whigh = 5; wlow = -5;
			for layer = 1:(length(NNet_str)-1)
				Output{layer} = rand(Input,NNet_str(layer)+1,NNet_str(layer+1))*(whigh-wlow)+wlow;
				%Eliminating some matches
				for i = 1:Input
					for j = 1:NNet_str(layer)+1
						for k = 1:NNet_str(layer+1)
							if rand(1,1) < P_omit_match
								Output{layer}(i,j,k) = 0;                
							end
						end
					end
				end
			end
			Coding = 'Real'; Boundary = [];
		case 'value'
			F1 = zeros(size(Input{1},1),1);
			F2 = F1; IC = F1;
			for i = 1:size(Input{1},1)
				w = {};
				for layer = 1:length(Input)
					w{layer} = squeeze(Input{layer}(i,:,:));  
				end
				[fval,complexity,W,InfoC] = DNevalnet(w,parameters);
				F1(i) = fval;
				if isnan(F1(i)) || isinf(F1(i))
					F1(i) = F_bad+eps; F2(i) = F_bad+eps;
				end
				F2(i) = complexity;
				UW(i).W = W;
				IC(i) = InfoC;
			end
			Output = [F1 F2];
			if ~final
				IC =[];
			end
	end
end