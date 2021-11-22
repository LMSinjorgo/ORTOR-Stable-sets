clc
clear
A = CreateTestInstances();
% Let A be the cell containing all the matrices
numInstances = size(A,1);

% run all the  instances and record value and runtime
results = zeros(numInstances,10);

for i = 1:numInstances
   [value, ~,runTime] =  BMIS(A{i});
        results(i,1:2) = [value, runTime];
   [value, ~,runTime] =  BMIS2(A{i});
        results(i,3:4) = [value, runTime];
   [value,~,runTime] =  TauM(A{i},0.1);
        results(i,5:6) = [value, runTime];
   [value, ~,runTime] =  TauM(A{i},0.25);
        results(i,7:8) = [value, runTime];
   [value, ~,runTime] =  TauM(A{i},0.5);
        results(i,9:10) = [value, runTime];
end