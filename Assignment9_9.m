clear; clc;
x = [1000 1650 1800 1900 1950 1960 1970 1980 1990 2000 2010];
y = [.34 .545 .907 1.61 2.56 3.15 3.65 4.2 5.3 6.12 6.98];
a, b, c = abcfit(x,y);
disp(a, b, c);

function a, b, c = abcfit(x, y)
    A(1,1) = length(x);
    A(1,2) = sum(x);
    A(1,3) = -sum(x.^y);
    A(2,1) = sum(x);
    A(2,2) = sum(x.^2);
    A(2,3) = -sum((x.^2).*y);
    A(3,1) = sum(x.^y);
    A(3,2) = sum((x.^2).*y);
    A(3,3) = -sum((x.^2).*(y.^2));
    B(1,1) = sum(y);
    B(2,1) = sum(x.*y);
    B(3,1) = sum(x.*(y.^2));
    X = linsolve(A,B);
    a = X(1);
    b = X(2);
    c = X(3);
end