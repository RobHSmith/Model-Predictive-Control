function [G,F] = JGF(Q,R,S,X0,gamma,phi,N)

%preallocate memory
[rx0,~] = size(X0);
[rR,~] = size(R);
omega = zeros(rx0*N);
psi = zeros(rR*N);

%fill omega
j = 1;
for i = 1:rx0:N*rx0
    omega(i:(i+rx0-1),j:(j+rx0-1)) = Q;
    j = j + rx0;
end

%switch last matrix on diagonal for S
omega(((N-1)*rx0)+1:N*rx0,((N-1)*rx0)+1:N*rx0) = S;

%fill psi
k =1;
for g = 1:rR:N*rR
    psi(g:(g+rR-1),k:(k+rR-1)) = R;
    k = k + rR;
end

%calculate G
G = 2*(psi + gamma' * omega * gamma);

if G <= 0
    error('G not positive definite');
end

%calculate F
F = 2*(gamma' * omega * phi);

if F < 0
    error('F not positive semi-definite');
end

end
