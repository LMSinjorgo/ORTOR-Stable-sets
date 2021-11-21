function [Adjacency, AllVectors] = KneserGraph(n,m)
%KNESERGRAPH
% n > m, 
% Create n dimensional binary vectors that sum to m
[~, AllVectors] = GeneralizedHamming(n,2,0);
VectorSums = sum(AllVectors,1);
AllVectors =AllVectors(:, VectorSums == m);
Adjacency = AllVectors' * AllVectors;
Adjacency = double(Adjacency == 0);
end

