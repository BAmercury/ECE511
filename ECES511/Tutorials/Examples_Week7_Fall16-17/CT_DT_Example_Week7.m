%% CT_DT_Example_Week7
% 30 October 2016   Dr. Tom Chmielewski   Fall 2016-17 ECE-S511
%%
%% Housekeeping
clear all
close all
clc
%% Discretization pages 1, 2, 3 Lecture Week 7
% consider a PVCF 2nd order system
A = [0 1; -125 -20]
B = [0;1]
C = [1,  1]
D = 0
eig(A)

% the two eigenvalues of CT system are 
T = 0.001  % 1 millisecond
Ad = expm(A*T)   % remember to use expm() not exp()
Bd = inv(A)*(Ad-eye(2))*B
Cd = C
Dd = D

% using Matlab's built in funtion to find the discrete state representation
sys_ct = ss(A, B, C, D)   % create CT LTI object from matrices
sys_dt = c2d(sys_ct, T, 'zoh') % result is DT LTI object at sampling time T
%%
% for completness let us compute Bd by the integral definition
syms tal 
Bds = eval(int(expm(A*tal), tal, 0, T)*sym(B))   % integrates to value of T, eval implifies numbers
%% CT response using LTI object and step()
[Yc, Tc]=step(sys_ct, [0:T:1]);  % plot CT step response form 0 to 1 sec
figure
plot(Tc, Yc, 'k', 'linewidth', 2)
grid on
title('CT response to setp input')
xlabel('time sec')
%%  recursively solve for the solution in the discrete domain
Td = zeros(size(Tc));   % set up array to hold time and outputs
Yd = zeros(size(Yc));
% IC = 0 since system is relaxed for step response by definition
Xnew = [0;0];   % at k = 0 IC = [0;0]
Yd(1) = Cd*Xnew;
Td(1) = 0; % remember arrays in Matlab start at 1 these are k values not time
for k = 1: length(Tc);  
    Xold = Xnew;
    Xnew = Ad*Xold+ Bd*1;
    Yd(k+1) = Cd*Xnew;   % save output value
    Td(k+1) = k;  % save corresponding discrete time integer index 
end
figure
stem(Td, Yd)
title('Stem plot of DTS step response')
xlabel('index k')
%% compare CT and DT from 0.05 to 0.1 sec by overlaying
figure
rg = 50:4:200;   % spread out a bit for easier viewing
plot(Tc(rg), Yc(rg), 'b', 'linewidth', .5)
hold on
plot(Tc(rg), Yc(rg), '*k')
plot(T*Td(rg), Yd(rg), 'ro')
legend('CT line', 'CT at point', 'DT', 'location', 'best')
title('overlay of CT and DT step response')
xlabel('time sec.')

