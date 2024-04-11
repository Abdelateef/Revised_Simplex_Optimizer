clear 
clc
%%
% Example 1
f = [2 3];
A = [2 1; 1 2];
b = [4; 5];
disp("                        Example 1                     ")
revised_simplex(f, A, b,"max");
disp("-------------------------------------------------------")
%%
% Example 2
f = [5 4];
A = [6 4; 1 2;-1 1;0 1];
b = [24 ;6;1;2];
disp("                        Example 2                     ")
revised_simplex(f, A, b,'max');
disp("-------------------------------------------------------")
 