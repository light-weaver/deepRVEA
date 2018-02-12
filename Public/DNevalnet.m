function [errorVal,F2,Beta,InfoC] = DNevalnet(net,parameters)
%DNevalnet - Description
%
% Syntax: [fval,W,InfoC] = DNevalnet(net)
%
% Long description
    setno = 1;
	in = parameters.dataset(setno).in;
	out = parameters.dataset(setno).out;
	outmax = max(out);
	outmin = min(out);
	no_points = length(out);
	no_layer = length(net);
	complexity = ones(1,size(in,2));
	k = 0;
	for layer = 1:no_layer  %-1?
		in = in*net{layer}(2:end,:);
		bias = net{layer}(1,:);
		in = in+bias;
		in = 1./(1+exp(-in));
		complexity = complexity*abs(net{layer}(2:end,:));
		k = k+ length(find(net{layer}));
	end
	complexity = sum(complexity);
	%% LLSQ to solve in*Beta = out
	Beta = in\out;
	modelout = in*Beta;

	errorVal = sqrt(sum(((modelout-out)/(outmax-outmin)).^2)/no_points);
	F2 = complexity;

	n = no_points;
	k = k+length(find(Beta));
	rss = sum(sum((modelout-out).^2));
	InfoC = 2*k+n*log(rss/n);
	InfoC = InfoC+(2*k*(k+1)/(n-k-1));
end