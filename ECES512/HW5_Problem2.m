%% Homework 5 Problem 2
% Bhautik (Brian) Amin


%% Observer based state feedack of DC motor


%% Setup constants
% mechanical constants
J = 0.0038
B = 9.55e-4
Tload = 0
% coupling
Kt = 10.02
% electrical
Ra = 1.64
La = 3.39e-3
Kv = 0.0708

%% Part 1: Make Simulink Model and find tf
% Make a Simulink model and find the transfer function
% Omega(s)/Vin(s) using limnod() and the in and out blocks from the
% source and sink library. You should get:
% 7.778e05
% ----------------------
% s^2 + 484 s + 5.519e04

A = [-B/J Kt/J; -Kv/La -Ra/La];
B = [0; 1/La];
C = [1 0];
D = 0;
IC = [0; 0];
K = [1 1];
%%
[As, Bs, Cs, Ds]=linmod('DC_motor_state_feedback')
ssm = ss(As, Bs, Cs, Ds)
zpk(ssm)
minreal(zpk(ssm))
%% Part 2: Design state feedback Controller
% Design a state feedback controller to place the eigenvalues at -500 and
% -600 radians. You should use Matlab to do the computations. Verify
% your design using limmod(), i.e. find the transfer function.
K = acker(A,B,[-500, -600])








