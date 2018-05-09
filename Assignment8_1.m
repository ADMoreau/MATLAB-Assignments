a = [4 0 -2; 1 2 0; 1 1 9];

for i =1:size(a,1)
    h = real(a(i,i));
    k = imag(a(i,i));
    r = 0;
    for j = 1:size(a,1)
        if i ~= j
            r = r+(norm(a(i,j)));
        end
    end
    
    N = 256;
    t = (0:N)*2*pi/N;
    plot (r*cos(t)+h, r*sin(t) + h, '-');
    hold on;
    plot(h,k,'+');
end
axis equal;
ev = eig(a);
for i = 1:size(ev)
    rev = plot(real(ev(i)),imag(ev(i)), 'ro');
end
hold off;
legend(rev,'Actual Eigenvalues');



