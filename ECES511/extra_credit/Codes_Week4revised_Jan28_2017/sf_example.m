%% sf_example

%% given xdot = Ax + bu
A = [1 2; 3, 1]
B = [ 0; 1]

%% eigenvalues of A
eig(A)

%% desired poles
p1 = -1-2*j
p2 = conj(p1)

%% compute k

k = acker(A, B, [p1;p2])

%% check ce

eig(A-B*k)

%% more commands

% characteristic coefficients
C_coeff = poly(A-B*k)

% roots 
roots(C_coeff)
