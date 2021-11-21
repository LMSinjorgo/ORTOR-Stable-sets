function [A] = CreateTestInstances()
A = {};
for i = 4:12
NewGraph = KneserGraph(i,2);
n = size(NewGraph,2);
% Add Kneser graph
A = [A; NewGraph];

% Add complement of Kneser Graph
A = [A; ones(n,n)-NewGraph-eye(n)];
end
for i = 6:10
A =[A; KneserGraph(i,3)];
end

A = [A;GeneralizedHamming(4,2,1)];
A = [A; GeneralizedHamming(4,3,1)];
end



