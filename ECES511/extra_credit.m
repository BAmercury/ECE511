%% CASE I
close all
%setting initial condition
A = [-5.0];
B = [2.0]; 
C = [1.0];
D = [0];
t = 0.1;
IC = 1;
U = 0;
sys = ss(A,B,C,D);
[Yc, Tc] = initial(sys, IC, 0:t:2);

% State Discretition 
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
yd = [];
yd(1) = 1;
Td = [];
Td(1) = 0;
% Exact Discrete
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end



%% Part 1

fprintf("After discretization Ad = expm(-5*t) Bd = ((-2/5)*expm(-5*t)) + (2/5)")
fprintf("State Equation: X[k+1] = Ad*X[k] + Bd*U[k]")
fprintf("Y[k] = X[k]")

%% Part 2
figure 
hold on
initial(sys, IC, 0:0.1:2)

yd = [];
yd(1) = 1;
Td = [];
Td(1) = 0;
% Exact Discrete
t = 0.1;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';
t = 0.3;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'green';
t = 0.5;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'blue';
legend('CT','DT  T=0.1',  'DT  T=0.3', 'DT  T=0.5')

hold off
fprintf("\nThe continous time signal is stable because as t approaches infinity, the amplitude approaches 0")
fprintf("\nThe discrete time signal is stabel for any time T > 0 can be seen from the graph as well for T = 0.1, 0.3, 0.5, the amplitude also approaches 0")

%% Part 3a
figure
fprintf("\nClose form continuous signal is x(t) = e^(A*t) * x(0) \n y(t) = x(t)")
I = imread('d.jpg');
imshow(I)

%% Part 3b
figure
hold on
initial(sys, IC, 0:0.1:2)
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';
legend('CT','DT  T=0.1')

%% Part 3c
figure
hold on
initial(sys, IC, 0:0.1:2)

yd = [];
yd(1) = 1;
Td = [];
Td(1) = 0;
% Exact Discrete
t = 0.1;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';
t = 0.3;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'green';
t = 0.5;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'blue';
legend('CT','DT  T=0.1',  'DT  T=0.3', 'DT  T=0.5')

hold off
fprintf("\nWhen T increases the discrete time signal matches better with continous time. When T decreases the DT signal loses alot of information but in general the discrete time signal is stable for all T")
%% Part 3d
figure
I = imread('case1err.jpg');
imshow(I)
%% Part 4a
figure
I = imread('case1part4ct.jpg');
imshow(I)
figure
I = imread('case1part4dt.jpg');
imshow(I)
%% Part 4b
figure
step(sys, 0:0.01:2);
hold on;
U = 1;
yd(1) = 0;
t = 0.1;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, 'filled', 'DisplayName', 'Exact Discrete');
ed.Color = 'blue';
t = 0.3;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, 'filled', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';
t = 0.5;
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
ed = stem(Td*t,yd, 'filled', 'DisplayName', 'Exact Discrete');
ed.Color = 'green';


%% Case II

%% Part 1
figure
I = imread('case2part1.jpg');
imshow(I)
%% Part 2
figure
I = imread('case2part2.jpg');
imshow(I)
%% Part 3a
figure
I = imread('case2part3a.jpg');
imshow(I)
%% Part 3b
figure
I = imread('case2part3b.jpg');
imshow(I)
fprintf("within the range of stability, samller the period, the higher the lower the error between the estimates\n")
fprintf("this is because as you sample more frequently the estimates gets better matched to the original signal\n")
fprintf("Larger the K value, more time for the method to converge hence lowering the error")
fprintf("The result for this is different comapred to Case 1 part 3d because 3d was an exact solution, while this is an estimate, so 3d has no error component, while forward and backward methods do")
fprintf("\n see next part for graph")
%% Part 3c
close all
A = [-5.0];
B = [2.0]; 
C = [1.0];
D = [];
t = .1;
IC = 1;
U = 0;

% Forward Difference
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);

sys = ss(A,B,C,D);
[Yc, Tc] = initial(sys, IC, 0:0.01:2);
hold on;
initial(sys, IC, 0:0.01:2)
ybd = [];
yd = [];
yd(1) = 1;
Td = [];
Td(1) = 0;
% Exact Discrete
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
hold on;
ed = stem(Td(1:11)*t,yd(1:11), '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';

yfd = [];
yfd(1) = 1;
Td = [];
Td(1) = 0;
% Forward Difference
for i = 1:length(Tc)
    yfd(i+1) = (1+(t*A))*yfd(i) +(B*t*U);
    Td(i+1) = i;
end
hold on;
fd = stem(Td(1:11)*t,yfd(1:11), 'filled','DisplayName', 'Forward Difference');
fd.Color = 'green';
ybd = zeros(1, length(Td));
ybd(1) = 1;
% Backward Difference
for k = 2:length(Td)
    z = 0;
    for m = 1:k
        z = z + 1/(1-A*t)^(k-m+1) * (B*t*U);
    end
    ybd(k) = ybd(1)*(1/((1-A*t)^k)) + z;
end
bd = stem(Td(1:11)*t,ybd(1:11), 'filled','DisplayName', 'Backward Difference');
bd.Color = 'blue';
legend('CT','CT(kT)','Fwd','Back')

en_forward = [];
en_backward = [];
t = 0.1;
for k = 1:11
    en_forward(k) = abs(exp(-5*k*t) - (1-5*t)^k);
    en_backward(k) = abs(exp(-5*k*t) - (1/(1+5*t)^k));
end
k = 1:11;
figure
hold on
stem(k, en_forward)
stem(k, en_backward)
title("Error Norm for T = 0.1")
xlabel("k")
ylabel("error")
legend("Foward", "Backward")
t = 0.3;
for k = 1:11
    en_forward(k) = abs(exp(-5*k*t) - (1-5*t)^k);
    en_backward(k) = abs(exp(-5*k*t) - (1/(1+5*t)^k));
end
k = 1:11;
figure
hold on
stem(k, en_forward)
stem(k, en_backward)
title("Error Norm for T = 0.3")
xlabel("k")
ylabel("error")
legend("Foward", "Backward")
t = 0.05;
for k = 1:11
    en_forward(k) = abs(exp(-5*k*t) - (1-5*t)^k);
    en_backward(k) = abs(exp(-5*k*t) - (1/(1+5*t)^k));
end
k = 1:11;
figure
hold on
stem(k, en_forward)
stem(k, en_backward)
title("Error Norm for T = 0.05")
xlabel("k")
ylabel("error")
legend("Foward", "Backward")
%% Part 4a
figure
I = imread('case2part4af.jpg');
imshow(I)
figure
I = imread('case2part4ab.jpg');
imshow(I)

%% Part 4b1
close all
A = [-5.0];
B = [2.0]; 
C = [1.0];
D = [];
IC = 1;
U = 0;
figure
% Exact Difference
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);

sys = ss(A,B,C,D);
[Yc, Tc] = initial(sys, IC, 0:0.01:2);
hold on;
initial(sys, IC, 0:0.01:2)
ybd = [];
yd = [];
yd(1) = 1;
Td = [];
Td(1) = 0;
% Exact Discrete
t = .1;
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
hold on;
ed = stem(Td(1:11)*t,yd(1:11), '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';

yfd = [];
yfd(1) = 1;
Td = [];
Td(1) = 0;
% Forward Difference
for i = 1:length(Tc)
    yfd(i+1) = (1+(t*A))*yfd(i) +(B*t*U);
    Td(i+1) = i;
end
hold on;
fd = stem(Td(1:11)*t,yfd(1:11), 'filled','DisplayName', 'Forward Difference');
fd.Color = 'green';
ybd = zeros(1, length(Td));
ybd(1) = 1;
% Backward Difference
for k = 2:length(Td)
    z = 0;
    for m = 1:k
        z = z + 1/(1-A*t)^(k-m+1) * (B*t*U);
    end
    ybd(k) = ybd(1)*(1/((1-A*t)^k)) + z;
end
bd = stem(Td(1:11)*t,ybd(1:11), 'filled','DisplayName', 'Backward Difference');
bd.Color = 'blue';
legend('CT','CT(kT)','Fwd','Back')
title('Discrete methods for T = 0.1')
figure
initial(sys, IC, 0:0.01:2)
t = .3;
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
hold on;
ed = stem(Td(1:11)*t,yd(1:11), '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';

yfd = [];
yfd(1) = 1;
Td = [];
Td(1) = 0;
% Forward Difference
for i = 1:length(Tc)
    yfd(i+1) = (1+(t*A))*yfd(i) +(B*t*U);
    Td(i+1) = i;
end
hold on;
fd = stem(Td(1:11)*t,yfd(1:11), 'filled','DisplayName', 'Forward Difference');
fd.Color = 'green';
ybd = zeros(1, length(Td));
ybd(1) = 1;
% Backward Difference
for k = 2:length(Td)
    z = 0;
    for m = 1:k
        z = z + 1/(1-A*t)^(k-m+1) * (B*t*U);
    end
    ybd(k) = ybd(1)*(1/((1-A*t)^k)) + z;
end
bd = stem(Td(1:11)*t,ybd(1:11), 'filled','DisplayName', 'Backward Difference');
bd.Color = 'blue';
legend('CT','CT(kT)','Fwd','Back')
title('Discrete methods for T = 0.3')
figure
t = .05;
initial(sys, IC, 0:0.01:2)
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
hold on;
ed = stem(Td(1:11)*t,yd(1:11), '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';

yfd = [];
yfd(1) = 1;
Td = [];
Td(1) = 0;
% Forward Difference
for i = 1:length(Tc)
    yfd(i+1) = (1+(t*A))*yfd(i) +(B*t*U);
    Td(i+1) = i;
end
hold on;
fd = stem(Td(1:11)*t,yfd(1:11), 'filled','DisplayName', 'Forward Difference');
fd.Color = 'green';
ybd = zeros(1, length(Td));
ybd(1) = 1;
% Backward Difference
for k = 2:length(Td)
    z = 0;
    for m = 1:k
        z = z + 1/(1-A*t)^(k-m+1) * (B*t*U);
    end
    ybd(k) = ybd(1)*(1/((1-A*t)^k)) + z;
end
bd = stem(Td(1:11)*t,ybd(1:11), 'filled','DisplayName', 'Backward Difference');
bd.Color = 'blue';
legend('CT','CT(kT)','Fwd','Back')
title('Discrete methods for T = 0.05')
%% Part 4b2
close all
A = [-5.0];
B = [2.0]; 
C = [1.0];
D = [];
IC = 1;
U = 0;
figure
% Exact Difference
Ad = expm(-5*t);
Bd = ((-2/5)*expm(-5*t)) + (2/5);

sys = ss(A,B,C,D);
[Yc, Tc] = initial(sys, IC, 0:0.01:2);
hold on;
initial(sys, IC, 0:0.01:2)
ybd = [];
yd = [];
yd(1) = 1;
Td = [];
Td(1) = 0;
% Exact Discrete
t = .1;
for i = 1:length(Tc)
    yd(i+1) = Ad*yd(i) +(Bd*U);
    Td(i+1) = i; % save corresponding discrete time integer index
end
hold on;
ed = stem(Td(1:11)*t,yd(1:11), '*', 'DisplayName', 'Exact Discrete');
ed.Color = 'red';

yfd = [];
yfd(1) = 1;
Td = [];
Td(1) = 0;
% Forward Difference
for i = 1:length(Tc)
    yfd(i+1) = (1+(t*A))*yfd(i) +(B*t*U);
    Td(i+1) = i;
end
hold on;
fd = stem(Td(1:11)*t,yfd(1:11), 'filled','DisplayName', 'Forward Difference');
fd.Color = 'green';
ybd = zeros(1, length(Td));
ybd(1) = 1;
% Backward Difference
t = 0.3;
for k = 2:length(Td)
    z = 0;
    for m = 1:k
        z = z + 1/(1-A*t)^(k-m+1) * (B*t*U);
    end
    ybd(k) = ybd(1)*(1/((1-A*t)^k)) + z;
end
bd = stem(Td(1:11)*t,ybd(1:11), 'filled','DisplayName', 'Backward Difference');
bd.Color = 'blue';
legend('CT','CT(kT)','Fwd T=0.1','Back T=0.3')
title('Discrete methods for T = 0.1')
%% Part 4b3

% the results shows that backwards difference will work for all T > -1/3
% and forward difference will only work for T = 0<T<1/3 
% inorder to have the same negative poles for the transfer function, the T
% for forward has to be less than 0.2 and the T for backward have to be
% greater than 0.2 so in the graph, T for forward was 0.1 and backward was
% 0.3 and this will have the same poles for the transfer function. 

% also for forward difference the it grows very instable as T increases,
% and the threshhold is 0.3333 before it becomes unstable and this can be
% seen in the graph. 