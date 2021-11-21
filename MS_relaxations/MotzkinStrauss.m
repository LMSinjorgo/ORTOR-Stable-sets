function [alphaG, runTime, x] = MotzkinStrauss(A)
% MotzkinStrauss formulation
% A is the adjacency matrix of the graph.
% Runs for 30 seconds, or less if optimality gap of 0.8% has been reached. (Due to time constraints)
n = size(A,2);
Q = A + eye(n);
x = sdpvar(n,1);
e = ones(n,1);
Constraints = [e'*x == 1; x >= 0];
Objective = x'*Q*x;

ops= sdpsettings('solver','gurobi', 'verbose', 0, 'cachesolvers', 1);
ops.gurobi.MIPGap = 0.008;
ops.gurobi.TimeLimit = 30;

tic
sol = optimize(Constraints,x'*Q*x,ops);
runTime = toc;

x = value(x);
alphaG = 1 / value(Objective);
end

