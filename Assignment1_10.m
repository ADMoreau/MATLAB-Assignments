clear; clc;

x = linspace(-5,5);
%x = transpose(x);

s  =  cos(x)                    ;
s1 =  x.*0 + 1                         ;
s3 =  1 -  (x.^2)/(factorial(2));
s5 =  1 -  (x.^2)/(factorial(2)) + (x.^4)/(factorial(4));
s7 =  1 -  (x.^2)/(factorial(2)) + (x.^4)/(factorial(4)) - (x.^6)/(factorial(6));
s9 =  1 -  (x.^2)/(factorial(2)) + (x.^4)/(factorial(4)) - (x.^6)/(factorial(6)) + (x.^8)/(factorial(8));


plot(x,s,'DisplayName','cos(x)'); hold on;
plot(x,s1,'DisplayName','s1'); hold on;
plot(x,s3,'DisplayName','s3'); hold on;
plot(x,s5,'DisplayName','s5'); hold on;
plot(x,s7,'DisplayName','s7'); hold on;
plot(x,s9,'DisplayName','s9'); hold on;
hold off

legend