function P_output (Population,time,savedir,parameters,saveon)

[FunctionValue IC] = P_objective('value',parameters,Population,1);

%TrueValue = P_objective('true',Problem,M,1000);
%del = find(FunctionValue(:,1) < 0)
%FunctionValue(del,:) = [];
%del = find(FunctionValue(:,2) < 0)
%FunctionValue(del,:) = [];
[rank, front]  = NONDOM_SORT(FunctionValue);
NonDominated = find(front ==1);
num_layers = length(Population);
%Population    = Population(NonDominated,:);
FunctionValue = FunctionValue(NonDominated,:);
IC = IC(NonDominated,:);
[~,select] = min(IC);
[~,i] = sort(FunctionValue(:,1));
hold off;
plot(FunctionValue(i,1), FunctionValue(i,2), '--ro');
hold on
plot(FunctionValue(select,1),FunctionValue(select,2),'s','MarkerFaceColor','b');
xlabel('f_1');ylabel('f_2');
drawnow;
new_Pop ={};
for new_index = 1:length(NonDominated)
	for layer = 1:num_layers
		new_Pop{layer}(new_index,:,:) = Population{layer}(NonDominated(new_index),:,:);
	end
end
Population = new_Pop;
if saveon
	close gcf
	y = ['Y' num2str(parameters.out-parameters.out_index(1)+1)];
	f_EvoDN_net(Population,parameters,select,savedir,y);
	eval(['save ' savedir '/' y '.mat Population parameters FunctionValue time'])
end
end


