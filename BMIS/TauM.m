function [objValue, x, runTime] = TauM(A, M)

n = size(A,2);
x = sdpvar(n,1);
Cons = [0 <= x; x <= 1];

[Edges, Edges2] = find(triu(A));
E = [Edges, Edges2];
for i =1:size(E,1)
    Cons = [Cons; 
        x(E(i,1))+x(E(i,2)) <= 1];
end

% setting options
ops= sdpsettings('solver','gurobi', 'verbose', 0, 'cachesolvers', 1);
ops.gurobi.MIPGap = 0.008;
ops.gurobi.TimeLimit = 30;

Objective = -(x'*x-M*x'*(1-x));
tic
optimize(Cons, Objective,ops);
runTime = toc;
objValue = -value(Objective);
x = value(x);
end

