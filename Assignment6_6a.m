clear;clc;
f = @(x) 1./(1+(5.*x).^2);
t = linspace(-1,1,41);
y = [];
z = zeros(41);
for i = t
    y = [y, f(i)];
end
%Develop the quadratic piecewise functions 
z2 = znext(z(1), y(1), y(2), t(1), t(2));
z(2) = z2;
Q = q(z(1), z(2), t(1), t(2), y(1));
syms x
pw = piecewise(t(1) <= x <= t(2), Q); 
for i = 2:40
    z2 = znext(z(i), y(i), y(i+1), t(i), t(i+1));
    z(i+1) = z2;
    Q = q(z(i), z(i+1), t(i), t(i+1), y(i));
    pw = piecewise(t(i) <= x <= t(i+1), Q, pw);
end
%test
test = linspace(-1, 1, 200);
fx = f(test);
sx = subs(pw, x, test);
out = (fx - sx);
plot(out)
MSE = sqrt(mean((out).^2));
disp(MSE);

%function to find z(i+1)
function z2 = znext(zi, y1, y2, t1, t2)
    z2 = -zi+2*((y2-y1)/(t2-t1));
end
%function to find Q(i)
function Q = q(z1, z2, t1, t2, y1)
    Q = @(x) ((z2 - z1)/2*(t2 - t1))*(x - t1)^2 + z1*(x-t1) + y1;
end