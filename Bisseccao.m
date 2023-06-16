%Método da Bissecção

f = @(x) 2*x^2-5*x-5;
%f = @(x) log10(x+3)-1
%f = @(x) x^2
%f = @(x) sin(6*x)
%f = @(x) x*sin(x)+x*cos(2*x)
%f = @(x) -1/((x-0.3)^2+0.01)+1/((x-0.9)^2-6)

a = -2.0;
b = 2.0;

n = 10000;

for i=1:n
    c = (a+b)/2;
    if sign(f(c))==sign(f(a))
        a = c;
    else 
        b = c;
    end
end

c
f(c)