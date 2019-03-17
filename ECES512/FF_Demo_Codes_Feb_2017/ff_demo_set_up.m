%% ff_demo_set_up
% Version: 25 February 2017
% Dr. Thomas Chmielewski
% Sets up variables in Matlab Workspace for use with Simulink files:
%  Feedforward_demo_Feb25_2017.slx
%  FF_variations_Feb25_2015.slx


%% Plant G(s) parameters   G(s) = k/(s+p)
% try changing these
p = 5
k = 10

%% FF gain for perfect tracking see notes for derivation
Kf = 1/(p+k)