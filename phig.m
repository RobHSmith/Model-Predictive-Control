function [phi, gamma] = phig(A,B,N)

%preallocate memory
[rA,cA] = size(A);
[~,cB] = size(B);

phi = zeros(N*rA,cA);

gamma = zeros(N*rA,N*cB);
[rg,cg] = size(gamma);

exponm = zeros(N);

%add A^N matrices to phi
for i = 1:rA:N*rA
    phi(i:(i+rA-1),1:cA) = A^((i+rA-1)/rA);
end

%create matrix of exponents for gamma
exponv = linspace(0,N-1,N);

for j = 1:N
    exponm(1:length(exponv),j) = exponv;
    exponm(:,j) = circshift(exponm(:,1),j-1);
end

for k = 1:N %this loop added since circshift() messes with coordinates
    for g = 1:N
        if g > k
            exponm(k,g) = 0;
        end
    end
end

%fill gamma with A^exponm(coord.)*B
for i = 1:rA:rg
    for w = 1:cB:cg
        gamma(i:(i+rA-1),w:(w+cB-1)) = (A^exponm((i+rA-1)/rA,(w+cB-1)/cB))*B;
    end
end

for c = 1:rg
    for d = 1:cg
        if (2*d)-1 > c
            gamma(c,d) = 0;
        end
    end
end

end

