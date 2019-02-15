clear all
clf
clc
A = -5;
B = 2;
C = 1;
D = 0;

T = .05;
t = 0:T:1;
sys_ct = ss(A, B, C, D);
[Yc, Tc]=step(sys_ct, t);
Td = zeros(size(Tc)); 
Yd = zeros(size(Yc));
Yd(1) = 1;
Td(1) = 1; % remember arrays in Matlab start at 1 these are k values not time
for k = 2: length(Tc)
    Td(k) = exp(-5*Tc(k))*Td(k-1) + (2/5 - (2*exp(-5*Tc(k))/5));
    Yd(k) = Td(k);
end
hold on
plot(Tc, Yc)
plot(Tc, Yd, 'ro')

