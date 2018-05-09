clear;clc;
%function Assignment3_5Secant(a,b,nmax,e)

a = -1; b = 1; 
%c = 0;
f = @(x) x*(x*(2*x + 7) + 14) + 3;
e = .5*10^-14;
nmax = 2000;

fa = f(a);
fb = f(b);

if fb - fa == 0
    error('Error: f(b)-f(a) must be nonzero.')
end

if b - a == 0
    error('Error: b-a must be nonzero.')
end

if abs(fa) < abs(fb)
    t = a;
    a = b;
    b = t;
    t = fa;
    fa = fb;
    fb = t;
end

x = 0;
fx = fb;
for iter = 0:nmax
    deltaX = - fx / (fb - fa) * (b - a);
    x = x + deltaX;
    fx = f(x);
    fprintf('iter: %d   a: %.4f  fa: %.4f  b: %.4f   fb: %.4f   x: %.4f   fx: %.4f   deltaX: %.4f\n', iter, a, fa, b, fb, x, fx, deltaX);

    if abs(deltaX) <= e && abs(fx) <= e
        break;
    end

    a = b;
    fa = fb;
    b = x;
    fb = fx;
end
root = x;

if abs(deltaX) <= e && abs(fx) <= e
    converged = 1;
else
    warning('Warning: The method did not converge.');
    converged = 0;
end
    
    