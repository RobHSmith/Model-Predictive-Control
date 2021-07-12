function [M,epsilon] = meps(ulim,Xlim,N)
%preallocate memory
[rxl,~] = size(Xlim);
[rul,~] = size(ulim);

Mi = zeros((rul+rxl),rxl/2);
Ei = zeros((rul+rxl),rul/2);
[misize,~] = size(Mi);
[eisize,~] = size(Ei);

M = zeros((misize*(N+1))-rul,N*rxl/2);
epsilon = zeros((eisize*(N+1))-rul,N*rul/2);

%create Mi and Ei
Mi((1+rul):(rul + rxl/2),1:rxl/2) = -eye(rxl/2);
Mi((1 + rul + rxl/2):(rul + rxl),1:rxl/2) = eye(rxl/2);

Ei(1:rul/2,1:rul/2) = -eye(rul/2);
Ei((rul/2 + 1):rul,1:rul/2) = eye(rul/2);

j = misize+1;
for i = 1:rxl/2:(N-1)*rxl/2
    M(j:(j+misize-1),i:(i+rxl/2-1)) = Mi;
    j = j + misize;
end

%account for N case (u not computed)
M(j:(j+rxl/2)-1,((N-1)*rxl/2)+1:N*rxl/2) = -eye(rxl/2);
M((j+rxl/2):end,((N-1)*rxl/2)+1:N*rxl/2) = eye(rxl/2);

g = 1;
for k = 1:rul/2:N*rul/2
    epsilon(g:(g+eisize-1),k:(k+rul/2-1)) = Ei;
    g = g + eisize;
end


end


