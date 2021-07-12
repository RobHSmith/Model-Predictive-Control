clear
clc

%give initial conditions
X0 = [-100;0];

SX = X0;

N = 40;

Tt = 30;

A = [1 0.5;0 1];

B = [0.125;0.5];

Q = [10 0;0 1];

R = 1;

S = 10*Q;

dt = 0.1;

%give constraints
ulim = [3;2];
Xlim = [100;0;10;20];

%determine number of simulation steps
tsteps = Tt/dt;

%create array of zeros for storage of state data
X = zeros((length(X0)*tsteps)-2,1);
X(1:length(X0),1) = X0;

U = zeros(tsteps,1);

%run MPC solver
for t = 1:tsteps
    [Uc] = MPC_solver(X0,N,A,B,Q,R,S,ulim,Xlim);
    
    %solve dynamics with RK4
    k1 = f(X0,Uc(1))*dt;
    k2 = f(X0 + 0.5*k1,Uc(1))*dt;
    k3 = f(X0 + 0.5*k2,Uc(1))*dt;
    k4 = f(X0 + k3,Uc(1))*dt;
    
    X0 = X0 + (k1 + 2*k2 + 2*k3 + k4)/6;
    
    X(((length(X0)*t)+1):(length(X0)*(t+1)),1) = X0;
    U(t,1) = Uc(1);
end

%plot states
steps = linspace(0,Tt,(Tt/dt)+1);
usteps = linspace(0,Tt-dt,(Tt/dt));

pos = zeros(1,length(X)/length(X0));
vel = zeros(1,length(X)/length(X0));

pos = X(1:length(X0):end)';
vel = X(length(X0):length(X0):end)';

figure('color','w')
subplot(3,1,1)
    box on
    hold on
    grid on
    plot(steps,pos)
    ylabel('Position')
subplot(3,1,2)
    box on
    hold on
    grid on
    plot(steps,vel)
    ylabel('Velocity')
subplot(3,1,3)
    box on
    hold on
    grid on
    plot(usteps,U)
    xlabel('Time')
    ylabel('Accel')

function [xdot] = f(X0,u)
    xdot = [X0(2);u];
end



