function [Generations,N,varargout] = P_settings(parameters)
%myFun - Description
%
% Syntax: [Generations,N,varargout] = myFun(input)
%
% Long description
	Generations = parameters.RVEAopt.Generations;
	varargout = parameters.RVEAopt.p1p2;
	N = parameters.RVEAopt.N;
end