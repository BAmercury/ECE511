% Using Matlab or Excel or something else recursively compute x[1] thru x[10]
% note that u[k] = 1 for all k. 

A = -2;
B = 5;
x0 = 10;

sys = ss(-2,5,1,0);

dsys = c2d(sys,1/8,'zoh');

x = [];
x(1) = x0;

for i = 1:1:11
   x(i+1) = dsys.A*x(i) + dsys.B*1;
    
end