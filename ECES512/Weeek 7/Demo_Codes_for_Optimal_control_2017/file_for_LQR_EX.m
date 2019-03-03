% file_for_LQR_EX


A = [ -1 0 ; 0 -10];
B = [ 1; 5]

Q = [100 0 ; 0 0]

R = 10


[K,S,E] = lqr(A,B,Q,R,0)

K1 = K(1,1)
K2 = K(1,2)

%%
xo = [10;10];

cost_J = xo'*S*xo

