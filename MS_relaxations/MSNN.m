function [alphaG, X] = MSNN(A)
n = size(A,2);
Q = A + eye(n);
X = sdpvar(n,n);
J = ones(n,n);
Constraints = [X(:) >= 0, trace(J*X) == 1];

% X(:) >= 0 is elemtwise nonnegativity, i.e. X is 
%   completely positive.

Objective = trace(Q*X);

ops = sdpsettings('solver', 'mosek','verbose',0);
sol = optimize(Constraints, Objective, ops);

X = value(X);
alphaG = value(Objective);



end