%Método de Newton-Raphson

f = @(x) 2*x^2-5*x-5;
%f = @(x) log10(x+3)-1
%f = @(x) x^2
%f = @(x) sin(6*x)
%f = @(x) x*sin(x)+x*cos(2*x)
%f = @(x) -1/((x-0.3)^2+0.01)+1/((x-0.9)^2-6)

n = 1000;
x_ant = 1;

for i=1:n
    x = x_ant - (f(x_ant)/((f(x_ant+0.0001)-f(x_ant))/(0.0001)));
    x_ant = x;
end

x
f(x)