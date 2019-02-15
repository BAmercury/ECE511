%lyap_fdbk
% solution of the inverted pendulum problem of Example 8.3 using
% the Lyapunov method of section 8.2.1
%%  define original system matrices
A = [0 1 0 0; 0 0 -1 0; 0 0 0 1; 0 0 5 0]
b = [0 1 0 -2]'

%% define the F matrix to be observable canonical form


F = [-5 1 0 0; -10.5 0 1 0; -11 0 0 1; -5 0 0 0]
kb = [1 0 0 0]

% alternate way to define F
%coeffs = poly(A); %get characteristic equation coefficients this is lenght 5
%Fa = [-5 1 0 0; -10.5 0 1 0; -11 0 0 1; -5 0 0 0]

%%
% 
%     X = LYAP(A,B,C) solves the Sylvester equation:
%  
%         A*X + X*B + C = 0
% we need to solve AT - TF = bk_bar

T = lyap(A, -F, -b*kb)

k = kb*inv(T)



%% check eigenvalues

eig(A -b*k)