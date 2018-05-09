clear; clc;
A = [-149 -50 -154; 537 180 546; -27 -9 -25];
evalue = eig(A);
singval = svd(A);
condnum = norm(A) * norm(inv(A));