%% [V,D] = eig(A)
% Use this form only for distinct eigenvalues - its a numerical algo
[V, D] = eig(A) % Makes ure to enter matrix as phase value canonical form

%{
    A =  0  1
        -2 -3

    V = 0.7071 -0.4472 The "Q" matrix
        -0.7071 0.8944 eig is normalized each column so 2-norm = 1
    D = -1 0; 0 -2 diagonal matrix with eigenvalues on diagnol 
                   note the ordering of eigenvalues and vectors


%}

%% Verify results of Dd = inv(V)*A*V

Dd = inv(V)*A*V % gives the digaonal matrix
% Dd = [-1 0; 0 -2]

% if you run:
format rat
[V, D] = eig(A) % it'll give you the fraction form of V and D


%% Jordan:
[V, D] = jordan(AA) % Jordan() is a symbolic function
% also it does not normalize the transformation matrix
% DO NOT normalize the columns of chained eigvenctors and corresponding GEVs