%% inverted_pendulum_Feb28_2016 - Ogata derivation
% note this is a terser version then the full simulation suite

% System Parameters need for Simulink models in workspace
M = 2;
m = .1;
l = 0.5;
g = 9.81;

% state assignments:   [pen_pos;  pen_vel; cart_pos; cart_vel]

%  these are correct matrices and match lecture notes for parameters given
%  above, if parameter change these need adjustment
A = [0, 1, 0, 0;...
    20.601, 0, 0, 0;...
    0, 0, 0, 1;...
    -.4905, 0, 0, 0];

B = [0; -1; 0; 0.5];


%% check observability with different measurements
C_theta = [1 0 0 0] %  pendulum position
D = 0;

Ot1 = obsv(A, C_theta)
rank(Ot1)
theta_on_F = tf(ss(A, B, C_theta, D))


C_position = [0 0 1 0] % cart position

Ot2 = obsv(A, C_position)
rank(Ot2)
position_on_F =tf(ss(A, B, C_position, D))


%% desired poles for demonstration

P1 = [-5, -.5, -.5, -5];  % set 1   matches notes
P2 = [-1, -.10, -1, -.1];  % set 2
P3 = [-10, -20, -10, -20]  % set 3

P = P1; % ***** use assighment statement to select poles
K = acker(A,B,P) % pole placement algorithm
K1 = K(1);   % corresponding simulink gain blocks
K2 = K(2);
K3 = K(3);
K4 = K(4);

% compute new poles for verification

AF = (A-B*K)
eig(AF)