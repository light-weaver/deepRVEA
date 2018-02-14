%RVEA Main File. Modified for deep learning.
function MAIN(out_index,parameters,savedir)
%clc;
format compact;tic;
parameters.out =  out_index;
[Generations,N,p1,p2] = P_settings(parameters);
Evaluations = Generations*N; % max number of fitness evaluations
alpha = parameters.alpha; % the parameter in APD, the bigger, the faster RVEA converges
fr = parameters.fr; % frequency to call reference vector
FE = 0; % fitness evaluation counter

%reference vector initialization
[N,Vs] = F_weight(p1,p2,2);
for i = 1:N
    Vs(i,:) = Vs(i,:)./norm(Vs(i,:));
end;
V = Vs;
% Generations = floor(Evaluations/N);

%calculat neighboring angle for angle normalization
cosineVV = V*V';
[scosineVV, neighbor] = sort(cosineVV, 2, 'descend');
acosVV = acos(scosineVV(:,2));
refV = (acosVV);

%population initialization
rand('seed', sum(100 * clock));
[Population] = P_objective('init',parameters,N,0);
FunctionValue = P_objective('value',parameters,Population,0);
num_layers = length(parameters.NNet_str)-1;
for layer = 1:num_layers
    mutval{layer} = squeeze(std(Population{layer}));
end
for Gene = 0 : Generations - 1
    %random mating and reproduction
    %[MatingPool,mutval] = F_mating(Population);
    Offspring = P_generator(Population,mutval,Gene,Generations);  
    %FE = FE + size(Offspring, 1); %check that fix that
    Population = insertOffspringToPopulation(Population,Offspring);
    FunctionValue = [FunctionValue; P_objective('value',parameters,Offspring,0)];
    %APD based selection
    theta0 =  (Gene/(Generations))^alpha*(2);
    [Selection] = F_select(FunctionValue,V, theta0, refV);
    for i = 1:length(Selection)
		for layer = 1:num_layers
			newPopulation{layer}(i,:,:) = Population{layer}(Selection(i),:,:);
			mutval{layer} = squeeze(std(Population{layer}));
		end
	end
	Population = newPopulation;
    FunctionValue = FunctionValue(Selection,:);

    %reference vector adaption
    if(mod(Gene, ceil(Generations*fr)) == 0)
        %update the reference vectors
        Zmin = min(FunctionValue,[],1);	
        Zmax = max(FunctionValue,[],1);	
        V = Vs;
        V = V.*repmat((Zmax - Zmin)*1.0,N,1);
        for i = 1:N
            V(i,:) = V(i,:)./norm(V(i,:));
        end;
        %update the neighborning angle value for angle normalization
        cosineVV = V*V';
        [scosineVV, neighbor] = sort(cosineVV, 2, 'descend');
        acosVV = acos(scosineVV(:,2));
        refV = (acosVV); 
	end
	if rem(Gene,10) == 1
	P_output(Population,toc,savedir,parameters,0);
	end
    clc;
    fprintf('Progress %4s%%\n',num2str(round(Gene/Generations*100,-1)));
end
P_output(Population,toc,savedir,parameters,1);
end