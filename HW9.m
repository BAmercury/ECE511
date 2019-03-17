%% ECES 512 HW 9
% Bhautik Amin

%% Instructor Problem 1
% Given the system:
A = diag([-1 -2, -100, -200])
B = [1;1;1;1]
C = [1 1 0.5 0.5]
D = 0
%%
% Find the balanced realization and compare the transfer functions to
% original and balanced realization

sys_org = ss(A,B,C,D);
%%
% Original System Transfer Function
sys_tf_org = zpk(sys_org)

%%
% Balanced Realization Transfer Function (balread() returns: [Realization, Hankel Singular
% Values )
[sys_bal, G] = balreal(sys_tf_org);

tf_bal = zpk(sys_bal)


%%
% Find a reduced order system by eliminating the two states from the
% balanced realization that have the lowest Hankel singular values

G'
%%
% We can see that the last two states have the lowest singular values

sys_reduced = modred(sys_bal, 3:4,'Truncate')
sys_tf_red = zpk(sys_reduced)

%%
% Compare the results by looking at the bode plots of each
figure(1)
bodeplot(sys_tf_org, sys_tf_red, 'r--')

%%
% Where in the dotted red line represents the reduced order system and the
% blue represents the original system. We can see that the reduced order
% system's phase plot is has a noticiable difference than the original
% system. 

%%
% From the bode plot, we can see that the 

%%
% Compare the step response of the original and reduced order system. Look
% at the final value and also the initial rise time (blow up graphs and see
% this around the initial and terminal values)
figure(2)
step(sys_tf_org)
title('Original System Step Response')
figure(3)
step(sys_tf_red)
title('Reduced Order System Step Response')
figure(4)
step(sys_tf_org)
hold on;
step(sys_tf_red)
title('Original and Reduced Step Response')












