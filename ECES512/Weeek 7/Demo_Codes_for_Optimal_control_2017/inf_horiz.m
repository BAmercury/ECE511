%%  inf_horiz.m
%% 
%  revised 5/22/2012
% shows computation of gain for infinite horizon problem
% used with Simulink file inf_horiz_sml.mdl to illustrate time trajectory
% and computation of cost function

A = [0 1; 0 0]
B = [0;1]
Q = 1000*[1 0; 0 0]
Q = [1000 0; 0 2000]
Q = [10 0; 0 2000]
%Q = 1000*[1 0; 0 0]

R = 1

[K, P, E]= lqr(A, B, Q, R, 0)
% note the above can also be done with are() to find P and then 
% K = inv(R)*B'*P  you need to make sure you adjust inputs to are()

% compute total cost
x1 = 10;
x2 = 10;
x0 = [x1; x2]
J = x0'*P*x0