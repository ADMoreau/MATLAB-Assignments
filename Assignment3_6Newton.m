clear;clc;

%a = -1; b = 1; 
x = 10000;
fa = @(r, y) .5*(y + r/y);
fb = @(r, y) (y*(y^2 + 3*r))/(3*y^2+r);
e1 = 10^-14; e2 = 10^-6;
R = [.001 .1 10 1000];
xamap = []; xbmap = [];

fprintf('Problem 6 1\n\n');

for i = R
    xamap = []; xbmap = [];
    iter = 0;
    xainit = fa(i, x);
    xa = fa(i, xainit);
    xbinit = fb(i, x);
    xb = fb(i, xbinit);
    fprintf('a\n');
    for j = 1:100000
        xa = fa(i, xainit);
        if abs(xa - xainit) < e1
            break
        end
        xamap = [xamap, xa];
        fprintf('iter: %.3d\t  x = %d\t  fx = %g\t  r = %g\n', iter, x, xa, i);
        xainit = xa;
        iter = iter + 1;
        
    end
    fprintf('b\n')
    iter = 0;
    for j = 1:100000
        xb = fb(i, xbinit);
        if abs(xb - xbinit) < e1
            break
        end
        xbmap = [xbmap, xb];
        fprintf('iter: %.3d\t  x = %d\t  fx = %g\t  r = %g\n', iter, x, xb, i);
        xbinit = xb;
        iter = iter + 1;
        
    end
    fprintf('\n');
    figure();
    plot(xamap)
    hold on
    plot(xbmap)
    hold off
end

fprintf('Problem 6 2\n\n');

for i = R
    xamap = []; xbmap = [];
    iter = 0;
    xainit = fa(i, x);
    xa = fa(i, xainit);
    xbinit = fb(i, x);
    xb = fb(i, xbinit);
    fprintf('a\n');
    for j = 1:100000
        xa = fa(i, xainit);
        if abs(xa - xainit) < e2
            break
        end
        xamap = [xamap, xa];
        fprintf('iter: %.3d\t  x = %d\t  fx = %g\t  r = %g\n', iter, x, xa, i);
        xainit = xa;
        iter = iter + 1;
        
    end
    fprintf('b\n');
    iter = 0;
    for j = 1:100000
        xb = fb(i, xbinit);
        if abs(xb - xbinit) < e2
            break
        end
        xbmap = [xbmap, xb];
        fprintf('iter: %.3d\t  x = %d\t  fx = %g\t  r = %g\n', iter, x, xb, i);
        xbinit = xb;
        iter = iter + 1;
        
    end
    fprintf('\n');
    figure();
    plot(xamap)
    hold on
    plot(xbmap)
    hold off
end
    
    
    