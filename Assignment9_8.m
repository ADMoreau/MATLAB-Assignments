clear; clc;
%step1
%7th degre polynomial
y = @(x) 10.*x.^7+9.*x.^6-8.*x.^5-12.*x.^4+3.*x.^3+2.*x.^2+x+1;
%random initial arrays
n = 100;
randx = 2.*rand(n,1) - 1;%inital x
raddx = .2.*rand(n,1) - .1;%x to be added to y
randy = y(randx);
%max polynomial point
ymax = max(randy);
%polynomial points summed with random array 
init = randy + raddx;
%step2
e = [10^-3 10^-4 10^-5 10^-6 10^-7];
A = [];
B = [];
p = zeros(7, 1);
for i = 1:7
    for j = 1:7
        temp = i + j -2;
        x = sum(randx.^temp);
        A(i, j) = x;
    end
    tempx = sum(randx.^(i-1));
    tempy = sum(init);
    B(i) = tempx*tempy;
end
A(1, 1) = n;
for i = 1:5
    p = B*A^(-1) -e(i);
    out = polyval(p,randx);
    figure(i)
    plot(out, 'DisplayName', 'Regression')
    hold on
    plot(randy, 'DisplayName', 'Initial values')
    legend
    hold off
end





