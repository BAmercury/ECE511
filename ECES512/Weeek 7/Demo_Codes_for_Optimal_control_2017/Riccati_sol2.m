% file:  Riccati_sol2.m
%  implements the solution of the differential Riccati equation using
%  backwards integration and sets up file for Simulink
%  finite_horizon.LQr.mdl

%  set up initial conditions value at T = 5
T = 5;
p11_old = 1;
p12_old = 0;
p22_old = 2;

% p11_old = 40;
% p12_old = 0;
% p22_old = 40;

Delta = 0.01   %  use pos number since equations take negative into account
t_acc = []; % accumulate time index
p11_acc = []; %  save values in array
p12_acc = [];
p22_acc = [];
for t = T:-Delta:0 
    t_acc = [t_acc, t];
    p11_acc = [p11_acc, p11_old]; % save data 
    p12_acc = [p12_acc, p12_old];
    p22_acc = [p22_acc, p22_old];
    
    p11_new = -Delta*(2*p12_old^2 - 2)+ p11_old;
    p12_new = -Delta*(-p11_old + 2*p22_old*p12_old -1)+ p12_old;
    p22_new = -Delta*(-2*p12_old + 2*p22_old^2 -4)+ p22_old;
    
    p11_old = p11_new;  %  swap variables for next iteration
    p12_old = p12_new;
    p22_old = p22_new;
end

%%  create plots 
subplot(3,1,1)
plot(t_acc, p11_acc, 'r',  'linewidth', 2)
ylabel('p11')
grid on
subplot(3,1,2)
plot(t_acc, p12_acc, 'g', 'linewidth', 2)
ylabel('p12')
grid on
subplot(3,1,3)
plot(t_acc, p22_acc, 'k', 'linewidth', 2)
ylabel('p22')
grid on

%% set up for Simulink
%  modifications for use with Simulink Model
tt = fliplr(t_acc);  % flip time for use with table lookup
p11 = fliplr(p11_acc);
p12 = fliplr(p12_acc);
p22 = fliplr(p22_acc);

Q = [2 1; 1 4];
R = 1/2;
Z = [1 0; 0 2];
Z = [p11_old p12_old; p12_old, p22_old]


