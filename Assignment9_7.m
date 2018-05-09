clear; clc;
format long
datasave = [];
fprintf('     n                    iterations                RMS       \n\n')

for en = 1:10
n = en*10; nh = ceil(n/2);
A = zeros(n, n);
%creating the A & b matrix
for i = 1:n
    for j = 1:n
        if i==j
            A(i,j) = 3;
        elseif j == i+1 || i == j+1
            A(i,j) = -1;
        elseif (j+i)-1 == n
            A(i,j) = .5;
        end
    end
end
b = A * ones(n,1);

k = 0; x = zeros(n,1); r = b-A*x; iter = 0;
delta2 = dot(r,r); delta1 = 0;
e = 10^-7; beta = 0; alpha = 0;
while (sqrt(delta2) > e*sqrt(dot(b,b)))
   k = k+1;
   if k == 1
       p = r;
   else
       beta = delta2/delta1;
       p = r + beta*p;
   end
   w = A*p;
   alpha = delta2/dot(p,w);
   x = x + (alpha * p);
   r = r - alpha * w;
   delta1 = delta2;
   delta2 = dot(r,r);
   iter = iter + 1;
end
temp = ones(n,1);
err = immse(x, temp);
err = sqrt(err);
datasave = [datasave; n iter err];
end
disp(datasave);


