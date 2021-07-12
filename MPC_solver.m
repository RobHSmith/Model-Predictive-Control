function [Uc] = MPC_solver(X0,N,A,B,Q,R,S,ulim,Xlim) 

%compute phi and gamma
[phi,gamma] = phig(A,B,N);

%compute G and F
[G,F] = JGF(Q,R,S,X0,gamma,phi,N);

%compute M and epsilon
[M,epsilon] = meps(ulim,Xlim,N);

%compute S', C, w
[Sprime,C,w] = quadprep(M,phi,gamma,epsilon,Xlim,ulim,N);

%run quadprog
Uc = quadprog(G,F*X0,Sprime,C+(w*X0));

end