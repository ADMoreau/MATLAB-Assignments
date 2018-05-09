function Assignment2_2()
n = 1000;
A = zeros([n, n]);

for i = 1:n
    for j = 1:n
        A(i, j) = 1/(i+j-1);
    end
end
   
z = ones([n, 1]);
B = A*z;

%WITH PIVOTING
App = single(A);
Bpp = single(B);
sumpp = 0;
xpp = zeros([1000, 1]);
tic
lambda = 1:n;

for k = 1:n   % zero column k below diag
    
    % find pivot row
    amax = abs(App(k,k));
    rho = k;
    for i = k+1:n
        temp = abs(App(i,k));
        if temp > amax
            amax = temp;
            rho = i;
        end
    end
    % rho is now the row index with the largest magnitude entry
    % in column k on or below the diagonal
    
    %switch lambda(rho) and lambda(k) to keep track of the permutation
    temp = lambda(rho);
    lambda(rho) = lambda(k);
    lambda(k) = temp;
    %lambda is a 'permutation vector' specifying the row interchanges
    
    %pivot: Switch rows rho and k of A.  Doing this for j = 1:n 
    %    switches the rows of the U portion of A AND the L portion of A
    for j = 1:n
        temp = App(k,j);
        App(k,j) = App(rho,j);
        App(rho,j) = temp;
    end
    
    % do the elimination
    if App(k,k) ~= 0 
        for i = k+1:n   % calculate multiplier that zeros A(i,k)
            App(i,k) = single(App(i,k)/App(k,k));
        end
        for i = k+1:n  % add multiple of row k to row i
            m = App(i,k);
            for j = k+1:n  % update row i, column j
                App(i,j) = single(App(i,j) - m*App(k,j));
            end
        end
    else
        % If A(k,k) is 0, do nothing for this k.  After partial pivoting
        % column k is already zero below (and on) the diagonal.
    end
end
%back substitution
for i = n-1:-1.0:1.0
    sumpp = Bpp(i);
    for j = i+1:n
        sumpp = single(sumpp - App(i, j)*z(j));
    end
    xpp(i) = single(sumpp/(App(i,i)));
end
toc

MSEpp = 0;
for i = 1:n
    MSEpp = single(MSEpp + (xpp(i) - 1)^2);
end
fprintf('With Pivoting, single precision\n');
MSEpp = single(MSEpp / n);
SMSEpp = single(sqrt(MSEpp));
fprintf('MSE = %g\n', MSEpp);
fprintf('SMSE = %g\n', SMSEpp);


App = A;
Bpp = B;
sumpp = 0;
xpp = zeros([1000, 1]);
tic
lambda = 1:n;

for k = 1:n   % zero column k below diag
    
    % find pivot row
    amax = abs(App(k,k));
    rho = k;
    for i = k+1:n
        temp = abs(App(i,k));
        if temp > amax
            amax = temp;
            rho = i;
        end
    end
    % rho is now the row index with the largest magnitude entry
    % in column k on or below the diagonal
    
    %switch lambda(rho) and lambda(k) to keep track of the permutation
    temp = lambda(rho);
    lambda(rho) = lambda(k);
    lambda(k) = temp;
    %lambda is a 'permutation vector' specifying the row interchanges
    
    %pivot: Switch rows rho and k of A.  Doing this for j = 1:n 
    %    switches the rows of the U portion of A AND the L portion of A
    for j = 1:n
        temp = App(k,j);
        App(k,j) = App(rho,j);
        App(rho,j) = temp;
    end
    
    % do the elimination
    if App(k,k) ~= 0 
        for i = k+1:n   % calculate multiplier that zeros A(i,k)
            App(i,k) = App(i,k)/App(k,k);
        end
        for i = k+1:n  % add multiple of row k to row i
            m = App(i,k);
            for j = k+1:n  % update row i, column j
                App(i,j) = App(i,j) - m*App(k,j);
            end
        end
    else
        % If A(k,k) is 0, do nothing for this k.  After partial pivoting
        % column k is already zero below (and on) the diagonal.
    end
end
%back substitution
for i = n-1:-1.0:1.0
    sumpp = Bpp(i);
    for j = i+1:n
        sumpp = sumpp - App(i, j)*z(j);
    end
    xpp(i) = sumpp/(App(i,i));
end
toc

MSEpp = 0;
for i = 1:n
    MSEpp = MSEpp + (xpp(i) - 1)^2;
end
fprintf('With Pivoting, double precision\n');
MSEpp = MSEpp / n;
SMSEpp = sqrt(MSEpp);
fprintf('MSE = %g\n', MSEpp);
fprintf('SMSE = %g\n', SMSEpp);


fprintf('Using built in funcitons\n')
tic
xsolve = linsolve(A, B);
toc
err = immse(xsolve, ones(n,1));
serr = sqrt(err);
fprintf('MSE = %g\n', err);
fprintf('SMSE = %g\n', serr);

