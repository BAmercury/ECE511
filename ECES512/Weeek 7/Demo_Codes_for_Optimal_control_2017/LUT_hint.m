% file:  LUT_hint.m

%  modifications for use with Simulink Model
% this assumes thae the data is in the worksa[pce from Riccati_sol.m
tt = fliplr(t_acc);  % flip time for use with table lookup
p11 = fliplr(p11_acc);
p12 = fliplr(p12_acc);
p22 = fliplr(p22_acc);