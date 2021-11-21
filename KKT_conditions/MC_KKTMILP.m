function [alpha, mu, x, runTime] = MC_KKTMILP(A)
% KKT reformulation of Motzkin-Strauss formulation
%   Note that a KKT based indefinite QP solver
%   is already implemented by Yalmip:
%   ops= sdpsettings('solver','kktqp');
%   see also https://yalmip.github.io/example/nonconvexquadraticprogramming/
n = size(A,2);
I = eye(n);
e = ones(n,1);
mu = sdpvar(1,1);
x = sdpvar(n,1);
lambda = sdpvar(n,1);
z = binvar(n,1);
V = 4*n+0.2;
cons =[2*(A+I)*x+mu*e - lambda == 0; e'*x == 1;
        x >=0; x <= z, lambda >= 0; 
        lambda <= (1-z)*V];
% same settings as Motzkin-Strauss formulation
ops= sdpsettings('solver','gurobi', 'verbose', 0, 'cachesolvers', 1);

% time constraints
ops.gurobi.MIPGap = 0.008;
ops.gurobi.TimeLimit = 30;

Objective = -0.5*mu;
tic
sol = optimize(cons,Objective,ops);
runTime = toc;

alpha = 1 / value(Objective);
x = value(x);
mu = value(mu);
end

