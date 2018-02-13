function [Generations,N,varargout] = P_settings(parameters)
%myFun - Description
%
% Syntax: [Generations,N,varargout] = myFun(input)
%
% Long description
	Generations = parameters.Generations;
	varargout = parameters.p1p2;
	N = parameters.N;
end