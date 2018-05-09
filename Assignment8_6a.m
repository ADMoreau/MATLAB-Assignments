clear;clc;
A = [-4 14 0; -5 13 0; -1 0 2];
x1 = [0; 1; 2];
kmax = 40;
fprintf('POWER METHOD######################\n\n');
for k =1:kmax
    y = A * x1;
    lambda1 = norm(y)/norm(x1);
    x1 = y;
    fprintf('k = %i, ||eigenvector 1|| = %g, lambda 1 = %g \n',k, norm(x1), lambda1);
end
fprintf('\nDEFLATION METHOD#################\n\n');
x3 = (1/(lambda1 * x1(1)) * A(1,:));
T = x1*x1';
B = A - ((lambda1*T) / dot(x1, x1'));
%B(1,:) = [];
%B(:,1) = [];
x3 = [0; 1; 3];
for k =1:kmax
    y = B * x3;
    lambda2 = norm(y)/norm(x3);
    x3 = y;
    fprintf('k = %i, ||eigenvector 2|| = %g, lambda 2 = %g \n',k, norm(x3), lambda2);
end
fprintf('\nINVERSE POWER METHOD#################\n\n');
x2 = [0; 1; 2];
for k = 1:kmax
    %v = x/norm(x);
    y = A\x2;
    x2 = y/norm(y);
    lambda3 = 1/norm(y);
    fprintf('k = %i, ||eigenvector 3|| = %g, lambda 3 = %g \n',k, norm(x2), lambda3);
end

        
        
