function [A, AllVectors] = GeneralizedHamming(d,q,F)
% 2 vectors are adjacent if their Hamming distance
% is contained in F
InputVector = 0:1:(q-1);

G = {};
for k=1:d
   G{k} = InputVector ;
end
AllVectors = allcomb(G{:});
HammingDist = pdist2(AllVectors, AllVectors, 'hamming')*d;
A = zeros(size(HammingDist));
for i = 1:length(F)
    A = A + double(HammingDist == F(i));
end
AllVectors = AllVectors';
end

