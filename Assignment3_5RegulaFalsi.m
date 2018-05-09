clear;clc;
%function Assignment3_5RegulaFalsi(a,b,nmax,e)

a = -1; b = 1; 
%c = 0;
f = @(x) x*(x*(2*x + 7) + 14) + 3;
e = .5*10^-14;
n = 1;

fa = f(a);
fb = f(b);
if sign(fa) == sign(fb)
    fprintf('error: f(a) & f(b) have the same sign');
else
    ctop = a*f(b) - b*f(a);
    cbottom = f(b) - f(a);
    c = ctop/cbottom;
    fc = f(c);
    while fc ~= 0
        fprintf('n = %i, c = %g, f(c) = %g, error = %g \n',n,c,fc,(b-a));
        n = n + 1;
        if sign(f(b)) == sign(f(c))
            b = c;
            ctop = a*f(b) - b*f(a);
            cbottom = f(b) - f(a);
            c = ctop/cbottom;
            fc = f(c);
        elseif sign(f(a)) == sign(f(c))
            a = c;
            ctop = a*f(b) - b*f(a);
            cbottom = f(b) - f(a);
            c = ctop/cbottom;
            fc = f(c);  
        end
    end
end

            
