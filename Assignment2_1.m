%for the following several functions they are split into two groups
%One group is for pivoting and one without
%if the variables are declared with a wp in the name
%they do not use pivoting (wp = without pivot)
%likewise if there is a pp then they are using partial pivoting
%pp = partial pivoting

function Assignment2_1()
a = -.5;
b = .5;
A = a + (b - a) .* rand(1000, 1000);
n = size(A,1);

z = ones([1000, 1]);
B = A*z;
Awps = single(A);
Bwps = B;
sumwp = 0;
xwp = zeros([1000, 1]);

%WITHOUT PIVOTING
tic
%forward elimination
for row = 1:n-1
    for i = row+1:n
        factor = single(Awps(i,row) / Awps(row,row));
        for j = row:n
            Awps(i,j) = Awps(i,j) - factor * Awps(row,j);
        end
        Bwps(i) = Bwps(i) - factor*Bwps(row);
    end
end

xwp(n) = single(Bwps(n)/Awps(n,n));
%back substitution
for i = n-1:-1.0:1.0
    sumwp = Bwps(i);
    for j = i+1:n
        sumwp = single(sumwp - Awps(i, j)*z(j));
    end
    xwp(i) = single(sumwp/(Awps(i,i)));
end
toc

MSEwp = 0;
for i = 1:n
    MSEwp = single(MSEwp + (xwp(i) - 1)^2);
end
fprintf('Without Pivoting, single precision\n');
MSEwp = single(MSEwp / n);
SMSEwp = single(sqrt(MSEwp));
fprintf('MSE = %g\n', MSEwp);
fprintf('SMSE = %g\n', SMSEwp);

%WITHOUT PIVOTING
Awp = A;
Bwp = B;
sumwp = 0;
xwp = zeros([1000, 1]);
tic
%forward elimination
for row = 1:n-1
    for i = row+1:n
        factor = Awp(i,row) / Awp(row,row);
        for j = row:n
            Awp(i,j) = Awp(i,j) - factor * Awp(row,j);
        end
        Bwp(i) = Bwp(i) - factor*Bwp(row);
    end
end

xwp(n) = Bwp(n)/Awp(n,n);
%back substitution
for i = n-1:-1.0:1.0
    sumwp = Bwp(i);
    for j = i+1:n
        sumwp = sumwp - Awp(i, j)*z(j);
    end
    xwp(i) = sumwp/(Awp(i,i));
end
toc

MSEwp = 0;
for i = 1:n
    MSEwp = MSEwp + (xwp(i) - 1)^2;
end
fprintf('Without Pivoting, double precision\n');
MSEwp = MSEwp / n;
SMSEwp = sqrt(MSEwp);
fprintf('MSE = %g\n', MSEwp);
fprintf('SMSE = %g\n', SMSEwp);

%WITH PIVOTING
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
fprintf('With Pivoting\n');
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


