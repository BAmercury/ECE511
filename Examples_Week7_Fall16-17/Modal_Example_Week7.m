%% Modal_Example_Week7
% 30 October 2016   Dr. Tom Chmielewski   Fall 2016-17 ECE-S511
%%
%% Computation of modal matrix  using numeric codes in Matlab
% start with diagaonal form with roots {-1, -5, -2+/-j3}
format rat
J = [-1     0       0       0;...
      0    -5       0       0;...
      0     0       -2+j*3  0;...
      0     0        0    -2-j*3]
  
  % define QB as on pg 11 of Week 7 notes
  QB = [1       0       0       0;...
        0       1       0       0;...
        0       0       1/2     -j*(1/2);...
        0       0       1/2     +j*(1/2)]
    
J_in_M = inv(QB)*J*QB   % "modal" form
%% Computation of modal matrix  using symbolic variables and tools
% this surprsses the  +j0 entries in the JB martix for real entries
% remember these are symbolic variables see note at end of the cell
clear all;
clc
J = sym([-1     0       0       0;...
      0    -5       0       0;...
      0     0       -2+j*3  0;...
      0     0        0    -2-j*3])
  
  % define QB as on pg 11 of Week 7 notes
  QB = sym([1       0       0       0;...
        0       1       0       0;...
        0       0       1/2     -j*(1/2);...
        0       0       1/2     +j*(1/2)])
    
J_in_M = inv(QB)*J*QB
% one way to to get back to numeric so you can use in numeric program
J_in_M_num= eval(J_in_M)

%% Finding Q*Q_bar = inv(P)   see pg 11 notes bottom
% this is direct transform to get modal form from A
% start with A in PVCV  similar to above diagaonal form with roots {-1, -5, -2+/-j3}
den_coeff = conv([conv([1 1], [1,5])], [conv([1 2+j*3],[1 2-j*3])]) % coeff of CE
% validate by finding roots
roots(den_coeff)
coeffs= fliplr(den_coeff) % flip so we can put in PVCF matrix easily
A = [0 1 0 0; 0 0 1 0; 0 0 0 1; -coeffs(1:4)]  % put in PVCF (only 1st 4 coeffs)
[V, D] = eig(A)  % eig works since no repeated roots and no GEVs
%%
% as seen the complex conjugate roots of D are in the two center locations corresponding to
% cols 2 and 3 of V   this was a Matlab ordering - you have to check
%%   notation from lecture pg 11
QQB = [V(:,1), real(V(:,2)), imag(V(:,3)), V(:,4)] % where A = QQB Modal inv(QB)Inv(Q)
% starting with A we get modal for and bypass diagonal with complex roots
% on diagonal.  the basic algorithm is to find the cols in V corresponding
% to the complex roots and make the first col real compoents the second
% imag components
format short
QQB
%%
% note no imaginary cols are in QQB
MM = inv(QQB)*A*QQB
%%
% Modal form