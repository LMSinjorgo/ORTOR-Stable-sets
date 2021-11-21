clc
clear
A = CreateTestInstances();
% Let A be the cell containing all the matrices
numInstances = size(A,1);

% run all the  instances and record value and runtime
results = zeros(numInstances,2);

for i = 1:numInstances
   [value, ~,~,runTime] =  MC_KKTMILP(A{i});
   results(i,:) = [value, runTime];
end