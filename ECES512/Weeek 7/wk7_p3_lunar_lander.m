%% Week 7 Problem 3
% Lunar Lander Problem


T = 0.5;

A = [1 T; 0 1];
B = [(T^2)/2; T];



IC = [5000; -500];
CT = B;

for n=1:18
    a=A^n*B;
    CT = [CT a];
end
P_inv = CT'*inv(CT*CT');
u = P_inv*([0;0]-A^19*IC);
u = flipud(u)';

x = [];
x = [x, IC];
for n=1:18
    x = [x, A*x(:,n)+B*u(n)];
end
figure(1)
stem(1:19, x(1,:))
title('Position over Time')
figure(2)
stem(1:19, x(2,:))
title('Velocity over Time')
figure(3)
stem(1:19, u)
title('Acceleration over Time')
J = [];
for n=1:19
    J = [J, 1/2*(u(n))^2];
end
figure(4)
stem(1:19, J)
title('Cost over Time')
