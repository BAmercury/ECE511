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

%%
% Implementing a state feedback controller

%%
% Check if we are controllable:
Cont = ctrb(arg.a, arg.b);
rank(Cont)

%%
% Perform pole placement
K = place(arg.a,arg.b, [-500 -600])
K1 = K(1);
K2 = K(2);

%%
% Get new closed loop transfer function
cl_arg = linmod('DC_motor_model')
[NUM, DEN] = ss2tf(cl_arg.a, cl_arg.b, cl_arg.c, cl_arg.d);
cl_tfsys = tf(NUM, DEN)
%%
% Check poles of the new closed loop transfer function
P = pole(cl_tfsys)

%%
% Step Response
step(cl_tfsys)
