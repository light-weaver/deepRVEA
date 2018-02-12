function f_EvoDN_net(parameters)
    setno = 1;
	in = parameters.dataset(setno).in;
	out = parameters.dataset(setno).out;
    no_layer = length(parameters.dataset.pareto.P);
    w = (parameters.dataset.pareto.P);
    select = parameters.dataset.pareto.select;
	select = 1;
    outmax = max(out);
	outmin = min(out);
	no_points = length(out);
    net = {};
    for layer = 1:no_layer
        net{layer}(:,:) = squeeze(w{layer}.w(select,:,:));  
    end
	for layer = 1:no_layer  %-1?
		in = in*net{layer}(2:end,:);
		bias = net{layer}(1,:);
		in = in+bias;
		in = 1./(1+exp(-in));
    end
	%% LLSQ to solve in*Beta = out
	Beta = in\out;
    hold on
 	modelout = in*Beta;
%     plot(out,modelout,'kd','LineWidth', 2)
%     pol = polyfit(out,modelout,1);
%     ylim=get(gca,'ylim');
%     xlim=get(gca,'xlim');
%     text(xlim(1)+0.1*(xlim(2)-xlim(1)),ylim(2),['\fontsize{12} \color{red} Slope =' num2str(pol(1))])
%     pol = pol(1)*out + pol(2);
%     plot(out,pol, '.-b', 'LineWidth', 2)
    plot([1:no_points],out,'--o',[1:no_points],modelout,'-or')
    hold off

end