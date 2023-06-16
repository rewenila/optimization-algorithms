%Golden Search

f = @(x) 2*x^2-5*x-5;
%f = @(x) log10(x+3)-1
%f = @(x) x^2
%f = @(x) sin(6*x)
%f = @(x) x*sin(x)+x*cos(2*x)
%f = @(x) -1/((x-0.3)^2+0.01)+1/((x-0.9)^2-6)

a = -2;
b = 2;

n = 100

alpha1 = (3-sqrt(5))/2;
alpha2 = 1-alpha1;

for i = 1:n
    xL = a+alpha1*(b-a);
    xR = a+alpha2*(b-a);
    if f(xL)<f(xR)
        b = xR;
    else
        a = xR;
    end
end

xR
f(xR)