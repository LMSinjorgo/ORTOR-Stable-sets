function [alphaG, W] = MIS_M_DN(A,M)
n = size(A,2);
Q = (1+M)* eye(n);
X = sdpvar(n,n);
x = sdpvar(n,1);
e = ones(n,1);
W = [1, x';
    x X];
Cons = [W(:) >= 0; W >= 0];

% W >= 0 \iff X is PSD, relaxation
% W(:) >= 0 is elemtwise nonnegativity, i.e. X is 
%   completely positive.

for i = 1:n
   Cons = [Cons; x(i) == X(i,i); x(i) <= 1];
end


[Edges, Edges2] = find(triu(A));
AllEdges = [Edges, Edges2];
for i =1:size(AllEdges,1)
    E = AllEdges(i,:);
    Cons = [Cons; 
                    X(E(1),E(1))+X(E(2),E(2)) + X(E(2),E(1))+ X(E(1),E(2)) <= 1];
end
Objective = trace(Q*X)-M*e'*x;

ops = sdpsettings('solver', 'mosek','verbose',0);
sol = optimize(Cons, -Objective, ops);

W = value(W);
alphaG = value(Objective);



end