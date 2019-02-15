A = [0 1; 0 0];
l_bar = [1;1];
C = [1 0];
e1 = -10;
e2 = -20;
F = [e1 0; 0 e2];
T = lyap(-F, A, -l_bar*C);
l = inv(T)*l_bar    

