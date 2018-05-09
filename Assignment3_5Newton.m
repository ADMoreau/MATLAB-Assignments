clear;clc;
%function Assignment3_5Newton(a,b,nmax,e)

%a = -1; b = 1; 
x = -1;
f  = @(x) x*(x*(2*x + 7) + 14) + 3;
fd = @(x)  x*(6*x + 14) + 14 ;
e = .5*10^-14; d = 0;
nmax = 200000;
fx = f(x);

fprintf('x = %i, f(x) = %g\n',x, fx);
for n = 1:nmax
    fp = fd(x);
    if abs(fp) < d
        fprintf('small derivative');
        return;
    end
    fx = f(x);
    d = fx/fp;
    x = x - d;
    fprintf('n = %i, x = %g, f(x) = %g\n',n,x,fx);
    if abs(d) < e
        fprintf('convergence');
        return;
    end
end

    
    
    
    