% mechanical constants
J = 0.0038
B = 9.55e-4
Tload = 0
% coupling
Kt = 10.02
% electrical
Ra = 1.64
La = 3.39e-3
Kv = 0.0708

%%
% Find transfer function from the simulink model
arg = linmod('DC_motor_model')
[NUM, DEN] = ss2tf(arg.a, arg.b, arg.c, arg.d);
tfsys = tf(NUM, DEN)
step(tf_sys)