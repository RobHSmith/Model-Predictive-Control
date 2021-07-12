# Model-Predictive-Control
This set of files is used to run a model predictive control (MPC) system for a vehicle traveling from an initial point to a goal point.

An introduction to MPC can be found at: https://engineering.purdue.edu/~zak/ECE680/MPC_handout.pdf


# phig

This file is a function used to set up the matrices Phi and Gamma based on the matrices A and B.
A and B are found by comparing x(i+1) = Ax(i) + Bu(i) to the forward Euler integration of particle dynamics.

# JGF

This file is a function used to create the matrices J, G, and F from Phi, Gamma, the initial conditions X0, 
the weight matrices Q and R, the replacement weight matrix S, and the size of the prediction horizon N.

# meps

This file is a function used to convert the system constraints (Xlim, ulim) into a usable format (M, Epsilon) using the size of the prediction horizon N

# quadprep

This file is a function to convert the system (Phi, Gamma, M, Epsilon, Xlim, ulim, N)  into a format usable by the quadprog() function in MATLAB. 

# MPC_Solver

This function is used to hold all of the above functions in a convenient format and solve the optimal control problem using quadprog(),
returning the acceleration commands for the next N simulation steps

# MPC

This file is used as the staging ground for inputs for functions phig through MPC_Solver and a graphing tool for the results.
Instead of idealizing the system and feeding the output acceleration from MPC_Solver into a forward Euler integration to 
determine the next "initial conditions", the acceleration output is fed into the RK4 algorithm to determine the next "initial conditions"

