%% consolidated_models
% This mfile sets us the matrices for the mdl file Consilidate_all.mdl
% this representation uses terse Simulink notation to show the original
% system, the system with state feedback, an observer and an observer based
% state feedback system
%  reference file OBSV_example.pdf

% original system
A = [0 1; -50 -15]
B = [0;1]
C = [1 0]

% state feedback for poles at -20, -20
% K = acker(A, B, [-20 -20])
K = [350 25]
K = acker(A, B, [-20 -25])
% observer gains for observer error at -50 -50
%  L = acker(A', C' [-50, -50])'
L = [85;1175]
L = acker(A', C', [-50, -60])'


%% getting transfer for observer based state feedback sytstem
[As, Bs, Cs, Ds]=linmod('Consolidate_Observer_based_state_feedback_xfer');
ssm = ss(As, Bs, Cs, Ds)
zpk(ssm)
minreal(zpk(ssm))