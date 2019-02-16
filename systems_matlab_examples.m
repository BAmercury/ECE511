%% Fundamentals of Systems
% Compiled MATLAB examples for reference





%% Finding Eigenvalues

A = [0 1; -2 -3];

%%
% Use only for distinct eigvenvalues
[V,D] = eig(A)

%%
% V = Right eigenvectors, returned as a square matrix whose columns are the
% right eigenvectors of A or generalized right eigenvectors of the pair,
% (A,B). The form and normalization of V depends on the combination of
% input arguments:

%%
% D = Eigenvalues, returned as a diagonal matrix with the eigenvalues of A
% on the main diagonal or the eigenvalues of the pair, (A,B), with
% multiplicity, on the main diagonal. When A is real and symmetric or
% complex Hermitian, the values of D that satisfy Av = ?v are real.




%%
% If you run:
format rat
[V, D] = eig(A) % it'll give you the fraction form of V and D


%%
% Jordan Form:
[V, D] = jordan(AA)
%%
% Jordan() is a symbolic function
% also it does not normalize the transformation matrix
% DO NOT normalize the columns of chained eigvenctors and corresponding GEVs



%% Single Value Decomposition
% SVD: How computers find the rank of a matrix

%%
% Define a matrix. 
H  =[-1 2; 0 -1; 1 0]

%%
% Compute 
% 
% $$ H*H^T $$
% 


HHT  = H*H'
HTH = H'*H


[R, D1]= eig(HHT)
R = R(:, [3 2 1])
D = D1;
D(1,1) = D1(3,3);
D(3,3) = D1(1,1);
D

[Q, D2]=eig(HTH)

Q = Q(:, [2 1])
DD = D2;
DD(1,1)  = D2(2,2);
DD(2,2) = D2(1,1);
DD
S = R'*H*Q


%% using Matlab
        % [U,S,V] = svd(X) produces a diagonal matrix S, of the same
        %     dimension as X and with nonnegative diagonal elements in
        %     decreasing order, and unitary matrices U and V so that
        %     X = U*S*V'.
        %
        %     S = svd(X) returns a vector containing the singular values.
 [U,S,V] = svd(H)


%% Discretization (CT and DT)
% consider a PVCF 2nd order system
A = [0 1; -125 -20];
B = [0;1];
C = [1,  1];
D = 0;
%%
% The two eigenvalues of the CT system are
eig(A)


%%
% Now lets discretize the system
T = 0.001; % 1 millisecond sampling period
Ad = expm(A*T); % Remember to use expm() and not exp()
Bd = inv(A)*(Ad-eye(2))*Bd;
Cd = C;
Dd = D;

%%
% We can also use Matlab's built in function to find the discrete state representation
sys_ct = ss(A,B,C,D)
sys_dt = c2d(sys_ct, T, 'zoh')

%%
% We can also compute Bd using the integral definition
syms tal
Bds = eval(int(expm(A*tal), tal, 0, T)*sym(B)) % Integrates to the value of T

%%
% Now we can compute CT step response using LTI object and the step() function
[Yc, Tc] = step(sys_ct, [0:T:1]);
figure(1)
plot(Tc, Yc, 'k', 'linewidth', 2)
grid on
title('CT step response')
xlabel('time (s)')

%%
% For the DT step response we will have to recursivley compute the solution
Td = zeros(size(Tc));   % set up array to hold time and outputs
Yd = zeros(size(Yc));
%%
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
figure(2)
stem(Td, Yd)
title('Stem plot of DTS step response')
xlabel('index k')

%%
% Compare CT and DT step responses from 0.05 to 0.1 seconds by overlaying
figure(3)
rg = 50:4:200;   % spread out a bit for easier viewing
plot(Tc(rg), Yc(rg), 'b', 'linewidth', .5)
hold on
plot(Tc(rg), Yc(rg), '*k')
plot(T*Td(rg), Yd(rg), 'ro')
legend('CT line', 'CT at point', 'DT', 'location', 'best')
title('overlay of CT and DT step response')
xlabel('time sec.')

%% Computation of Modal Matrix
% Compute modal matrix using numeric codes in Matlab

%%
% Start with diagonal form with roots  {-1, -5, -2+/-j3}
format rat
J = [-1     0       0       0;...
      0    -5       0       0;...
      0     0       -2+j*3  0;...
      0     0        0    -2-j*3]
%%
% define QB as on pg 11 of Week 7 notes
QB = [1       0       0       0;...
0       1       0       0;...
0       0       1/2     -j*(1/2);...
0       0       1/2     +j*(1/2)]

%%
% To compute modal form:
J_in_M = inv(QB)*J*QB

%% 
% Computation of modal matrix  using symbolic variables and tools
% this supresses the  +j0 entries in the JB martix for real entries
% remember these are symbolic variables see note at end of the cell
clear all;
clc
J = sym([-1     0       0       0;...
      0    -5       0       0;...
      0     0       -2+j*3  0;...
      0     0        0    -2-j*3])
  
  % define QB as on pg 11 of Week 7 notes
  QB = sym([1       0       0       0;...
        0       1       0       0;...
        0       0       1/2     -j*(1/2);...
        0       0       1/2     +j*(1/2)])

J_in_M = inv(QB)*J*QB

%%
% One way to to get back to numeric so you can use in numeric program
J_in_M_num= eval(J_in_M)


%% 
% Finding Q*Q_bar = inv(P)   see pg 11 notes bottom
% this is direct transform to get modal form from A
% start with A in PVCV  similar to above diagaonal form with roots {-1, -5, -2+/-j3}
den_coeff = conv([conv([1 1], [1,5])], [conv([1 2+j*3],[1 2-j*3])]) % coeff of CE
%%
% validate by finding roots
roots(den_coeff)
coeffs= fliplr(den_coeff) % flip so we can put in PVCF matrix easily
A = [0 1 0 0; 0 0 1 0; 0 0 0 1; -coeffs(1:4)]  % put in PVCF (only 1st 4 coeffs)
[V, D] = eig(A)  % eig works since no repeated roots and no GEVs
%%
% as seen the complex conjugate roots of D are in the two center locations corresponding to
% cols 2 and 3 of V   this was a Matlab ordering - you have to check

%%
% notation from lecture pg 11
QQB = [V(:,1), real(V(:,2)), imag(V(:,3)), V(:,4)] 
%%
% where A = QQB Modal inv(QB)Inv(Q)
% starting with A we get modal for and bypass diagonal with complex roots
% on diagonal.  the basic algorithm is to find the cols in V corresponding
% to the complex roots and make the first col real compoents the second
% imag components
format short
QQB
%%
% note no imaginary cols are in QQB
MM = inv(QQB)*A*QQB
%%
% Modal form

%% Controllable Canonical Form and calculate feedback gains

%%
% Define original system, given in diagonal form and it is controllable and observable
A = [-1 0 ; 0 -2]
B = [1;1]
C = [1 1]
D = 0

%%
% Find the transfer function
tf(ss(A,B,C,D))

%%
% Now write in CCF, this is done by finding tf and doing a coefficient match
Ab = [-3 -2; 1 0]
Bb = [1; 0]
Cb = [2 3]

%%
% get characteristic equation same for both representations
CEA = poly(A)



%%
%  Compute feedback gain based on characteristic equation coeffients
%%
% Our desired closed loop ds = s^2 + 11s + 30 = (s+5)(s+6)
%  (desired - actual)
CED = [1 11 30]

DD = CED-CEA
%%
% strip off first element s^2 coefficient
kb = DD(2:3)
kb = [8 28]  % state feedback in CCF
%%
%   check eigenvalues using kb
eig((Ab-Bb*kb)) % verify correct

%%
% find P = Cbar * inv (C) and k for original system
Cbar = [Bb, Ab*Bb]
CT = [B, A*B]
P = Cbar*inv(CT) % this is transformation
k= kb*P

%%
% verify k with original system
eig((A-B*k))
%%
%  Verify matrices using transform, P are same as by inspection of G(s)
AA = P*A*inv(P)
BB = P*B
CC = C*inv(P)

%%
% compare step responses of both systems without state feedback
% same y so they should yiled same results even though states are different
sys_orig = ss(A, B, C, 0);
sys_CCF = ss(Ab, Bb, Cb, 0);
figure
step(sys_orig, 'ro', sys_CCF, 'bx')
title('step response original and CCF system no feedback')
legend('diagnol form', 'CCF')

%%
% compare step responses systems of both systems with state feedback
% same y so they should yiled same results even though states are different
sys_orig_f = ss((A-B*k), B, C, 0);
sys_CCF_f = ss((Ab-Bb*kb), Bb, Cb, 0);
figure
step(sys_orig_f, 'ro', sys_CCF_f, 'bx')
title('step response original and CCF system with state feedback')
legend('diagnol form', 'CCF')
%%
% show transfer functions 
% original transfer function
gg1= tf(sys_orig_f)
%%
% transfer function with state feedback
gg2 = tf(sys_CCF_f)

%% 
%% look at components of transfer function with state feedback
s = tf('s')

g1 = -7/(s+5)
g2 = 9/(s+6)

[y1, t1] = step(g1);
[y2, t2] = step(g2, t1);
figure
plot(t1, y1, t2, y2, t1,(y1+y2))

hold on
step((g1+g2), 'r.')
legend('-7/(s+5)', '9/(s+6)', 'sum')
title('components contributing to step response')
%%
% Phase plane analysis for system without and with state feedback
% this is solution to homogeneous system x_dot = Ax with x(0) or zdot=
% (A-Bk)z  note with state feedback we saw overshoot in y(t)
t = 0:.01:10;  % create time vector
u = zeros(size(t)); % input u = 0;
x0 = [10;10] % initial condition;
C = eye(2) ; % to see both states
sys_CCF = ss(Ab, Bb, C, 0);  % modified to see both states
sys_CCF_f = ss((Ab-Bb*kb), Bb, C, 0);% modified to see both states
X = lsim(sys_CCF,u,t, x0);   % CCF 
Xf = lsim(sys_CCF_f,u,t, x0);   % CCF with state feedback
figure
plot(X(:,1), X(:,2),  'b', 'LineWidth', 2)
hold on

plot(Xf(:,1), Xf(:,2), 'g', 'LineWidth', 2)

plot(10, 10, 'r*', 'LineWidth', 2)
plot(0, 0, 'k*', 'LineWidth', 2')
legend('original', 'with state fdbk', 'IC', 'origin','Location', 'Best')
title('Phase Plane Trajectories')
grid on

%% Demo for CCF and Finding state feedback gains

%%
% Define original system
A = [-1 0; 0 -2]
B = [1;1]
C = [1 1]

%%
% In CCF form
Ac = [-3 -2; 1 0]
Bc = [1;0]
Cc = [2 3]
%%
%  desired ce s^2 + 11s +30
kc = [(11-3) (30-2)]
%%
% in controllable canonical form
eig(Ac -Bc*kc)

%%
% need to find k corresponding to orignal realization
Ct = ctrb(A,B)
Cct = ctrb(Ac, Bc)
% P = C-bar inv(C)
P = Cct*inv(Ct)
% k for original system
k = kc*P

eig(A-B*k)

%% Solving Inverted Pendulum Problem using Lyapunov Method

%%
% Define original system
A = [0 1 0 0; 0 0 -1 0; 0 0 0 1; 0 0 5 0]
b = [0 1 0 -2]'

%% 
% define the F matrix to be observable canonical form
F = [-5 1 0 0; -10.5 0 1 0; -11 0 0 1; -5 0 0 0]
kb = [1 0 0 0]

%%
% alternate way to define F
% coeffs = poly(A); %get characteristic equation coefficients this is lenght 5
% Fa = [-5 1 0 0; -10.5 0 1 0; -11 0 0 1; -5 0 0 0]
%%
% 
%     X = LYAP(A,B,C) solves the Sylvester equation:
%  
%         A*X + X*B + C = 0
% we need to solve AT - TF = bk_bar
T = lyap(A, -F, -b*kb)
k = kb*inv(T)
%% 
% check eigenvalues
eig(A -b*k)

%% State Feedback example
%% 
% given xdot = Ax + bu
A = [1 2; 3, 1]
B = [ 0; 1]

%% 
% eigenvalues of A
eig(A)

%% 
% desired poles
p1 = -1-2*j
p2 = conj(p1)

%% 
% compute k

k = acker(A, B, [p1;p2])

%% 
% check ce

eig(A-B*k)

%% 
% more commands

%%
% characteristic coefficients
C_coeff = poly(A-B*k)
%%
% roots 
roots(C_coeff)