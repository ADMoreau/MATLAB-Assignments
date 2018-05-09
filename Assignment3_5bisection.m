function Assignment3_5bisection(a,b,nmax,e)

%a = -1; b = 1; 
c = 0;
f = @(x)  x*(x*(2*x + 7) + 14) + 3;
%e = .5*10^-14;
%nmax = 200000;

%bisection method
fa = f(a);
fb = f(b);
if sign(fa) == sign(fb)
   fprintf('error: f(a) & f(b) have the same sign');
else
   error = b-a;
   for n = 0:nmax
       error = error/2;
       c = a + error;
       fc = f(c);
       fprintf('n = %i, c = %g, f(c) = %g, error = %g\n',n,c,fc,error);
       if abs(error) < e
           fprintf('convergence');
           return
       elseif sign(fa) ~= sign(fc)
           b = c;
           fb = fc;
       else
           a = c;
           fa = fc;
       end
   end
end
end