
a = 0;
b = 1;
c = 1/(sqrt(2));
d = .25;
e = 1;
for k = 1:5
   a = b;
   b = single((b+c)/2);
   c = single(sqrt(c*a));
   d = single(d - e * (b-a)^2);
   e = single(2 * e);
   f = single((b^2)/d);
   g = single((b + c)^2/(4*d));
   fprintf('k = %i, f = %g, |f - pi| = %g, g = %g, |g - pi| = %g\n', k, f, abs(f - pi), g, abs(g - pi));
end
