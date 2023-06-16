clear
clc
rng(1);

f = @(x) 100*(x(2)-x(1).^2).^2+(1-x(1)).^2;
rest = @(x) x(1)^2+x(2)^2;   %restrição
fp = @(x) 2^(rest(x)-1.5) - 1;  %função de penalização
xl = [-3 3; -3 3];
n = 40;
w = 0.5;
lambda1 = 1;
lambda2 = 2;
xgbest = [1000,1000];
flag = 0;
k = 100;

[X,Y] = meshgrid(xl(1,1):0.1:xl(1,2), xl(2,1):0.1:xl(2,2));
Z = 100*(Y-X.^2).^2+(1-X).^2;
surf(X,Y,Z)
hold on

for j = 1:n
        for i = 1:2
            x(i,j) = rand*(xl(i,2)-xl(i,1))+xl(i,1);
            v(i,j) = 0;
            xlbest(i,j) = x(i,j);
        end

        if f(xlbest(:,j))<f(xgbest(:))
            xgbest(:) = xlbest(:,j);
        end
end

for k = 1:50
    for j = 1:n
            for i = 1:2
                  
                if rest(x(:,j))>= 1.5
                    f = @(x) f(x)+ fp(x);
                end
                if f(x(:,j))<f(xlbest(:,j))
                    xlbest(:,j) = x(:,j);
                end 
                if f(xlbest(:,j))<f(xgbest(:))
                    xgbest(:) = xlbest(:,j);
                end
            end
    end
   
    for j = 1:n
        for i = 1:2
          
            v(i,j) = w*v(j)+lambda1*rand*(xlbest(i,j)-x(i,j))+lambda2*rand*(xgbest(i)-x(i,j));
            x(i,j) = x(i,j)+v(i,j)
            
            %if x(i,j) < xl(1,1)
            %    x(i,j) = xl(1,1)
            %end
            %if x(i,j) > xl(1,2)
            %    x(i,j) = xl(1,2)
            %end    
        end
    end
    
    fmin(k) = f(xgbest);
end

plot3(xgbest(1), xgbest(2), fmin(k-1), 'r')

xgbest
fmin(k-1)

%resultado com restrição esperado: f(0.907, 0.823) = 0.009

