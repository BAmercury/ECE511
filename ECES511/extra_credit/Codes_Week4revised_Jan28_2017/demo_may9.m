%% demo 
A = [-1 0; 0 -2]
B = [1;1]
C = [1 1]
%% 
Ac = [-3 -2; 1 0]
Bc = [1;0]
Cc = [2 3]
%  desirec ce s^2 + 11s +30
kc = [(11-3) (30-2)]
% in controllable canonical form
eig(Ac -Bc*kc)

% need to find k corresponding to orignal realization
%%

Ct = ctrb(A,B)

Cct = ctrb(Ac, Bc)
% P = C-bar inv(C)
P = Cct*inv(Ct)
% k for original system
k = kc*P

eig(A-B*k)