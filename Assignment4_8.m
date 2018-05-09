clear;clc;
r = @(x) 1./(1+25*x.^2);
node = @(x,y) cos((x*pi)/y);
cheb = @(x,y) cos(((2*x + 1)*pi)/(2*y + 2)); 
x1 = -1;
x2 = 1;
n = [5 10 20 40];
for i = 1:4
    %temp = an array of n equally spaced nodes between -1 and 1
    temp = x1:(2/n(i)):x2;
    nodes = [];
    cheby = [];
    %nodes = array of node with cos(i*pi/n)
    for j = temp
        nodes = [nodes, node(j, n(i))];
    end
    %Cheby = an array of chebyshev nodes 
    for j = temp
        cheby = [cheby, cheb(j, n(i))];
    end
    %initialize vectors using the runge function and the nodes created in
    %a, b and c
    a = r(temp);
    b = r(nodes);
    c = r(cheby);
    %evaluate divided differences using function with runge functions as
    %f(x) and the equally spaced x values between -1 and 1 as the x values
    ad = divdif(temp, a);
    bd = divdif(temp, b);
    cd = divdif(temp, c);
    %eval coefficients produced
    x = linspace(-1,1,200);
    ax = interp(a, ad, x);
    bx = interp(b, bd, x);
    cx = interp(c, cd, x);
    %eval runge at the 200 points
    fx = r(x);
    figure(1)
    hold on
    plot(fx - ax)
    legend()
    %hold on
    figure(2)
    hold on
    plot(fx - bx)
    legend()
    figure(3)
    hold on
    legend()
    plot(fx - cx)
    %calculate MSE
    erra = immse(fx, ax);
    errb = immse(fx, bx);
    errc = immse(fx, cx);
end
hold off
function divdif_y = divdif(x_nodes, y_values)
divdif_y = y_values;
m = length(x_nodes);
for i = 2:m
    for j = m:-1:i
        divdif_y(j) = (divdif_y(j)-divdif_y(j-1))/(x_nodes(j)-x_nodes(j-i+1));
    end
end
end

function p_eval = interp(x_nodes,divdif_y,x_eval)
m = length(x_nodes);
p_eval = divdif_y(m)*ones(size(x_eval));
for i = m-1:-1:1
    p_eval = divdif_y(i) + (x_eval - x_nodes(i)).*p_eval;
end
end