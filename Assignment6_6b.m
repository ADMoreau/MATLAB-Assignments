clear;clc;
%f = @(g) 1/(1+(5*g)^2);
n = 41;
t = linspace(-1,1,41);
y = [];
%Define the coefficients
for i = t
    y = [y, 1/(1+(5*i)^2)];
end
h = [];
for i = 2:n
    h(i) = t(i) - t(i-1);
end
h(1) = h(2);
h(n+1) = h(n);
delta = -1;
gamma = 2*(y(1));
p = delta*gamma;
q = 2;
for i = 1:n
   r = (h(i+1))/(h(i));
   delta = -r*delta;
   gamma = -r *gamma + (r + 1)*y(i);
   p = p + delta * gamma;
   q = q + delta ^ 2;
end
a(1) = -p/q;
for i = 2:n+1
    a(i) = ((h(i-1)+h(i))*y(i-1) - h(i)*a(i-1))/h(i-1);
end
%Evaluate
z = [];
for i = 1:n-1
    x = (t(i) + t(i+1))/2;
    z = [z, eval(n, t, a, h, x)];
end
z(41) = y(41);
plot(y-z);
MSE = sqrt(mean((y-z).^2));
disp(MSE);

function z = eval(n, t, a, h, x)
    i = n-1;
    while (x - t(i)) <= 0
        i = i -1;
    end
    i = i+1;
    d = (a(i+1)*(x-t(i-1)) + a(i)*(t(i)-x+h(i+1)))/(h(i)+h(i+1));
    e = (a(i)*(x-t(i-1)+h(i-1))+a(i-1)*(t(i-1)-x+h(i)))/(h(i-1)+h(i));
    z = (d*(x-t(i-1))+e*(t(i)-x))/h(i);
end