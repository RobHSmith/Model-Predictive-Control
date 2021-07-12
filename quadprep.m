function [Sprime,C,w] = quadprep(M,phi,gamma,epsilon,Xlim,ulim,N)
%construct S'
Sprime = (M * gamma) + epsilon;

%construct C
bi = [ulim;Xlim];

[rbi,~] = size(bi);

C = zeros((N*rbi)+length(Xlim),1);

for i = 1:rbi:rbi*N
    C(i:(i+rbi-1),1) = bi;
end 

C((N*rbi)+1:end,1) = Xlim;

%construct w
w = -M * phi;

end