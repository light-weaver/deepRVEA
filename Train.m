function Train(Problem_name,parameters)
oldpath = path;
clc;format short;
newpath = pwd;
addpath([newpath '\Public'], [newpath '\RVEA']);
warning off
parameters = parameters.RVEAtrain;
%Data import
filename = [Problem_name '.xls'];         %Data file
[DataSet,paraname,DATA] = xlsread(filename);
parameters.DATA = DATA;
parameters.paraname= paraname;
parameters.DataSet = DataSet;
%====================================================

in_index = parameters.in_index;           %independent variables column no.
out_index = parameters.out_index;         %dependent variable column no.
parameters.noinnodes = length(in_index);
parameters.NNet_str = [parameters.noinnodes parameters.NNet_str];

savedir = fullfile(pwd,'Output',Problem_name,...
					'deepRVEA',parameters.name);
mkdir(savedir);

Xmin = eps; parameters.Xmin = Xmin;          %normalization range for variables
Xmax = 1; parameters.Xmax = Xmax;



%scale the data
DataSet_sc = [];
for i=1:length(DataSet(1,:))
    Data_min(1,i) = min(DataSet(:,i));
    Data_max(1,i) = max(DataSet(:,i));
    DataSet_sc = [DataSet_sc Xmin+...
				 (DataSet(:,i)-Data_min(1,i))/(Data_max(1,i)-Data_min(1,i))*(Xmax-Xmin)];
end
parameters.DataSet_sc = DataSet_sc;
parameters.Data_min = Data_min;
parameters.Data_max = Data_max;
%============================================



for out = out_index
	parameters.dataset.in = DataSet_sc(:,in_index);  %dataset(2)and so on will be later used for subsets.
	parameters.dataset.out = DataSet(:,out);	%make sure to fix the code accordingly for that functionality later.
	eval(['delete ' savedir '\Y' num2str(out-out_index(1)+1) '.mat'])
	fprintf('\nStarting Deep Training on Objective %d\n',(out - out_index(1)+1));
	MAIN(out,parameters,savedir)
end
path(oldpath);
end