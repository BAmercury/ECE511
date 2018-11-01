%% SVD_demo  10/8/2016 for ECE-S511
% Matlab solution of example on pg 6-7 of Week 4 Part A
%% define matrix
% Single value decomposition, how computers find rank of a matrix


% Define the matrix
H  =[-1 2; 0 -1; 1 0]


HHT  = H*H'
HTH = H'*H


[R, D1]= eig(HHT)
R = R(:, [3 2 1])
D = D1;
D(1,1) = D1(3,3);
D(3,3) = D1(1,1);
D

[Q, D2]=eig(HTH)

Q = Q(:, [2 1])
DD = D2;
DD(1,1)  = D2(2,2);
DD(2,2) = D2(1,1);
DD
S = R'*H*Q



%% using Matlab
        % [U,S,V] = svd(X) produces a diagonal matrix S, of the same
        %     dimension as X and with nonnegative diagonal elements in
        %     decreasing order, and unitary matrices U and V so that
        %     X = U*S*V'.
        %
        %     S = svd(X) returns a vector containing the singular values.
 [U,S,V] = svd(H)