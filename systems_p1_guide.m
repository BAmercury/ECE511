%% Fundamentals of Systems 1 (ECES511)





%% Finding Eigenvalues

A = [0 1; -2 -3];

%%
% Use only for distinct eigvenvalues
[V,D] = eig(A)

%%
% V = Right eigenvectors, returned as a square matrix whose columns are the
% right eigenvectors of A or generalized right eigenvectors of the pair,
% (A,B). The form and normalization of V depends on the combination of
% input arguments:

%%
% D = Eigenvalues, returned as a diagonal matrix with the eigenvalues of A
% on the main diagonal or the eigenvalues of the pair, (A,B), with
% multiplicity, on the main diagonal. When A is real and symmetric or
% complex Hermitian, the values of D that satisfy Av = ?v are real.




%%
% If you run:
format rat
[V, D] = eig(A) % it'll give you the fraction form of V and D


%%
% Jordan Form:
[V, D] = jordan(AA)
%%
% Jordan() is a symbolic function
% also it does not normalize the transformation matrix
% DO NOT normalize the columns of chained eigvenctors and corresponding GEVs



%% Single Value Decomposition
% SVD: How computers find the rank of a matrix

%%
% Define a matrix. 
H  =[-1 2; 0 -1; 1 0]

%%
% Compute 
% 
% $$ H*H^T $$
% 


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













