close all
A = -5.0;
B = 2.0; 
C = 1.0;
D = 0;
t = 0.05;

% Forward Difference
Ad = expm(-5*t);
Ad2 = 1/expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5)
Bd2 = Ad*(Ad2)*B;

sys = ss(A,B,C,D);
step(sys)
hold on;
dsys = c2d(sys,t);
hold on;
step(dsys,'m')

[Yc, Tc]=step(sys, [0:t:1]);

x = []
y = []
Xnew = 0;
Td = []
Td(1) = 1;
% Forward difference
for i = 1:1:length(Tc)
    Xold = Xnew;
    Xnew = Ad*Xold+ Bd*1;
    y(i+1) = 1*Xnew;
    Td(i+1) = i; % save corresponding discrete time integer index
end
hold on;
stem(Td*t,y, 'g', 'DisplayName', 'Forward Difference');
fwd_diff = y;

x = []
y = []
Xnew = 0;
Td = []
Td(1) = 1;
% Backward Difference
for i = 1:length(Tc)
    Xold = Xnew;
    Xnew = ((1+(t*A))*Xold +(t*B*1));
    y(i+1) = 1*Xnew;
    Td(i+1) = i;
end

hold on;
stem(Td*t,y, 'r o','DisplayName', 'Backward Difference');

    




    
    