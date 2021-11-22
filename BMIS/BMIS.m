function [alphaG, x, runTime] = BMIS(A)
n = size(A,2);
x = binvar(n,1);

Cons = [];
[Edges, Edges2] = find(triu(A));
E = [Edges, Edges2];
for i =1:size(E,1)
    Cons= [Cons; 
        x(E(i,1))+x(E(i,2)) <=  1];
end
Objective = sum(x);

ops= sdpsettings('solver','gurobi', 'verbose', 0, 'cachesolvers', 1);
ops.gurobi.MIPGap = 0.008;
ops.gurobi.TimeLimit = 30;

tic
sol = optimize(Cons,-Objective,ops);
runTime = toc;

x = value(x);
alphaG = value(Objective);
end

