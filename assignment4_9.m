clear;clc;
format long
fprintf('                                cos                              \n');
fprintf('         h            |       forward         |        centered  \n');
datasave = [];
for i = 1:5
    h = 10^(-2*i);
    ff = (1/h)*(cos(h) - cos(0));
    dff = abs(-sin(0)- ff); 
    fc = (1/(2*h))*(cos(h) - cos(-h));
    dfc = abs(-sin(0)- fc);
    datasave = [datasave; h dff dfc];
end
disp(datasave)
fprintf('                             arctan                            \n');
fprintf('         h            |     forward       |    centered  \n');
datasave = [];
for i = 1:5
    h = 10^(-2*i);
    ff = (1/h)*(atan(1+h) - atan(1));
    dff = abs(.5 - ff); 
    fc = (1/(2*h))*(atan(1+h) - atan(1-h));
    dfc = abs(.5 - fc);
    datasave = [datasave; h dff dfc];
end
disp(datasave)
fprintf('                           Richardson cos                              \n');
fprintf('         h            |       forward     |           centered  \n');
datasave = [];
Df = [];
Dc = [];
for j = 1:5
    for i = 1:2
        h =10^(-2*j);
        Df(i,1) = (cos(h) - cos(0))/h;
        Dc(i,1) = (cos(h) - cos(-h))/(2*h);
        for k = 2:i
            Df(i,k) = Df(i,k-1) + (Df(i,k-1) - Df(i-1,k-1))/((4^k) -1);
            Dc(i,k) = Dc(i,k-1) + (Dc(i,k-1) - Dc(i-1,k-1))/((4^k) -1);
        end    
    end
    dff = abs(-sin(0)- Df(2,2)); 
    dfc = abs(-sin(0)- Df(2,2));
    datasave = [datasave; h dff dfc];
end
disp(datasave)
fprintf('                        Richardson arctan                              \n');
fprintf('         h            |       forward     |           centered  \n');
datasave = [];
Df = [];
Dc = [];
for j = 1:5
    for i = 1:2
        h =10^(-2*j);
        Df(i,1) = (atan(1+h) - atan(1))/h;
        Dc(i,1) = (atan(1+h) - atan(1-h))/(2*h);
        for k = 2:i
            Df(i,k) = Df(i,k-1) + (Df(i,k-1) - Df(i-1,k-1))/((4^k) -1);
            Dc(i,k) = Dc(i,k-1) + (Dc(i,k-1) - Dc(i-1,k-1))/((4^k) -1);
        end    
    end
    dff = abs(.5- Df(2,2)); 
    dfc = abs(.5- Df(2,2));
    datasave = [datasave; h dff dfc];
end
disp(datasave)