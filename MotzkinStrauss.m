function [alphaG, runTime, x] = MotzkinStrauss(A)
n = size(A,2);
Q = A + eye(n);
x = sdpvar(n,1);
e = ones(n,1);
Constraints = [e'*x == 1; x >= 0];
Objective = x'*Q*x;

%   KKT based indefinite QP solver
%   is already implemented by matlab
%   ops= sdpsettings('solver','kktqp');
%   see also https://yalmip.github.io/example/nonconvexquadraticprogramming/
ops= sdpsettings('solver','gurobi', 'verbose', 0, 'cachesolvers', 1);
ops.gurobi.MIPGap = 0.008;
ops.gurobi.TimeLimit = 30;

tic
sol = optimize(Constraints,x'*Q*x,ops);
runTime = toc;

x = value(x);
alphaG = 1 / value(Objective);



end

