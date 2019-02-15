%% file:  obs_state_xfer
% 

%  use with simulink file obs_state_xfer_mdl

%% get state space representation

[AA, BB, CC, DD]=linmod('obs_based_state_xfer');
%  compute controllability test matrix
CT = ctrb(AA, BB)
%  test rank
rank(CT)
fprintf('here we see that system is not completely controllable so pole zero cancellation occurs \n')
fprintf('\n\n')
fprintf(' state space and transfer function for system not minimum realization\n')
ss_model=ss(AA, BB, CC, DD)
xf_model = zpk(ss_model)
%  this model does not cancel poles and zeros so
%  one should use the following code. It is best to do
%  on state space model then get xfer
fprintf(' use minreal(sys) to obtainstate space and transfer function for system minimum realization\n')
ss_model_min = minreal(ss_model)
xf_model_min = zpk(ss_model_min)
