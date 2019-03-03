%% solving the Riccati equation using an equation solver
%  This method follows the discussion in Lewis on page 174
% and uses the example in the handwritten notes on Finite Horizon
% compare to difference equation solution in notes
% this is an exact solution rather than an approximation 
% small moficications 5/14/2015,  2/18/2018

% Define matrices
A = [0 1; 0 0]
B = [0;1]
T = 5
Q = [2 1; 1 4]
R = 1/2
Z = [1 0; 0 2]  % aka S(T)


% Riccati equation
%  -S_dot = S*A + A'*S - S*B*inv(R)*B'*S + Q

% transformation using pg 174 Edition 2  pg 146 Ed 3
% Sb_dot = Sb*A + A'*Sb - Sb*B*inv(R)*B'*Sb + Q
%  solve  forward from t = 0 
%  then reverse solution and shift to t = T


% we will solve using simulink file
sim('tc_Riccati_solve');


%%  look at simulation results

t = ric_out.time;
s= ric_out.signals.values(:,:,:);
arrs = max(size(s));
s11 = reshape(ric_out.signals.values(1,1,:),arrs,1);
s12 = reshape(ric_out.signals.values(1,2,:),arrs,1);
s22 = reshape(ric_out.signals.values(2,2,:),arrs,1);
figure
subplot(3,1,1)
plot(t,s11, 'r', 'linewidth', 2 )
hold on
plot(0, Z(1,1), 'k*', 'linewidth', 2)
title('s11 - solved fwd in time')
subplot(3,1,2)
plot(t,s12, 'g', 'linewidth', 2)
hold on
plot(0, Z(1,2), 'k*', 'linewidth', 2)
title('s12 = s21  - solved fwd in time')
subplot(3,1,3)
plot(t,s22, 'b', 'linewidth', 2)
hold on
plot(0, Z(2,2), 'k*', 'linewidth', 2)
title('s22 - solved fwd in time')

%% now flip so that solution is correct

% flip time axis
s11 = fliplr(s11);
s12 = fliplr(s12);
s22 = fliplr(s22);

% shift time axis
t = 5-t;   % use t from forward integration

figure
subplot(3,1,1)
plot(t,s11, 'r', 'linewidth', 2 )
hold on
plot(5, Z(1,1), 'k*', 'linewidth', 2)
title('s11 - time reversed')
subplot(3,1,2)
plot(t,s12, 'g', 'linewidth', 2)
hold on
plot(5, Z(1,2), 'k*', 'linewidth', 2)
title('s12 = s21  - time reversed')
subplot(3,1,3)
plot(t,s22, 'b', 'linewidth', 2)
hold on
plot(5, Z(2,2), 'k*', 'linewidth', 2)
title('s22 - time reversed')

% as a reminder  you verify the boundary condition at t = 5
% these are shown as "stars" on plot


