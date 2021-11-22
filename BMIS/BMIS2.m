function [alphaG, x, runTime] = BMIS2(A)
n = size(A,2);
x = binvar(n,1);

Cons = x'*A*x <= 1;
Objective = x'*x;

ops= sdpsettings('solver','gurobi', 'verbose', 0, 'cachesolvers', 1);
ops.gurobi.MIPGap = 0.008;
ops.gurobi.TimeLimit = 30;

tic
sol = optimize(Cons,-Objective,ops);
runTime = toc;

x = value(x);
alphaG = value(Objective);
end

