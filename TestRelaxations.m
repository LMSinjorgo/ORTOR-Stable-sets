clc
clear
A = CreateTestInstances();
% Let A be the cell containing all the matrices
numInstances = size(A,1);

% run all the  instances and record value and runtime
results = zeros(numInstances,3);

for i = 1:numInstances
   G = A{i};
   MSDN_value = MSDN(G);
   MSNN_value = MSNN(G);
   MSPSD_value = MSPSD(G);
   results(i,:) = [MSDN_value, MSNN_value, MSPSD_value];
end