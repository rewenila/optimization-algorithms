%Método de Monte Carlo

f = @(x) 2*x^2-5*x-5
%f = @(x) log10(x+3)-1
%f = @(x) x^2
%f = @(x) sin(6*x)
%f = @(x) x*sin(x)+x*cos(2*x)
%f = @(x) -1/((x-0.3)^2+0.01)+1/((x-0.9)^2-6)

n = 2000;
x_best = 4*rand-2;
y_best = f(x_best);
fplot('2*x^2-5*x-5',[-2, 2])

for i=1:n
    x = 4*rand-2;
    y_new = f(x);
    if y_new < y_best
        y_best = y_new;
    end
end

y_best
