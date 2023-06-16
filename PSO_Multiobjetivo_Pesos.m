clear; clc; rng(1);

%funções a serem otimizadas
J1 = @(x) 3*(1-x(1))^2*exp(-x(1)^2 - (x(2)+1)^2) - 10*(x(1)/5 - x(1)^3 - x(2)^5)*exp(-x(1)^2 - x(2)^2) - 3*exp(-(x(1)+2)^2 - x(2)^2) + 0.5*(2*x(1) + x(2));
J2 = @(x) 3*(1+x(2))^2*exp(-x(2)^2 - (-x(1)+1)^2) - 10*(-x(2)/5 + x(2)^3 + x(1)^5)*exp(-x(2)^2 - x(1)^2) - 3*exp(-(2-x(2))^2 - x(1)^2);

%parâmetros
xl = [-3 3; -3 3];  %limites
n = 100;            %população
w = 0.5;            %inércia
lambda1 = 0.1;
lambda2 = 0.2;
xgbest = [0,0];
m = 1;

F = @(x) J1(x)+J2(x);

for a = 0:0.01:1
    
    J = @(x) a*J1(x)+(1-a)*J2(x);
    
    %posicões, velocidades e xbests iniciais
    for j = 1:n
        for i = 1:2
            x(i,j) = rand*(xl(i,2)-xl(i,1))+xl(i,1);
            v(i,j) = 0;
            xlbest(i,j) = x(i,j);
        end
        
        if F(xlbest(:,j))>F(xgbest(:))
            xgbest(:) = xlbest(:,j);
        end
    end
    
    for r = 1:150
        
        %novos xbests
        for j = 1:n
            if J(x(:,j))>J(xlbest(:,j))
                xlbest(:,j) = x(:,j);
            end 
            if J(xlbest(:,j))>J(xgbest(:))
                xgbest(:) = xlbest(:,j);
            end
        end

        %novas posições e velocidades
        for j = 1:n
            for i = 1:2
                v(i,j) = w*v(j)+lambda1*rand*(xlbest(i,j)-x(i,j))+lambda2*rand*(xgbest(i)-x(i,j));
                x(i,j) = x(i,j)+v(i,j);
            end 
            
            if x(:,j) < xl(:,1)
                x(:,j) = xl(:,1);
            end
            if x(:,j) > xl(:,2)
                x(:,j) = xl(:,2);
            end       
        end
    end
    
    %pontos de fronteira
    front(:,m) = xgbest(:)
    m = m+1;
    
end

%------------------------------plots----------------------------

x1 = [-3:.1:3];x2 = [-3:.1:3];[xx1,xx2] = meshgrid(x1,x2);

%objective space
figure(1)
for i = 1:length(x1)
    for j = 1:length(x2)
        fJ1(i,j) = J1([xx1(i,j),xx2(i,j)]);
        fJ2(i,j) = J2([xx1(i,j),xx2(i,j)]);
        fJ(i,j) = F([xx1(i,j),xx2(i,j)]);
        plot(fJ1(i,j),fJ2(i,j),'k.');hold on
    end
end
xlabel('J1');ylabel('J2');
title('Objective Space (J_1, J_2)')
hold on
for i = 1:length(front) 
    plot(J1(front(:,i)),J2(front(:,i)), 'r.')
    hold on;
end

%otimizações de x1 e x2 separadas
figure(2)

subplot(1,2,1)
pcolor(x1,x2,fJ1);
colormap(jet)
shading interp
xlabel('x1');ylabel('x2');
title('Objective J_1(x_1, x_2)')
hold on
for i = 1:length(front) 
    plot(front(1,i),front(2,i), 'k.')
    hold on;
end

axis equal
subplot(1,2,2)
pcolor(x1,x2,fJ2);
colormap(jet)
shading interp
xlabel('x1');ylabel('x2');
title('Objective J_2(x_1, x_2)')
hold on
for i = 1:length(front) 
    plot(front(1,i),front(2,i), 'k.')
    hold on;
end
axis equal

%superfície
F1 = 3*(1-xx1).^2.*exp(-xx1.^2 - (xx2+1).^2) - 10*(xx1/5 - xx1.^3 - xx2.^5).*exp(-xx1.^2 - xx2.^2) - 3*exp(-(xx1+2).^2 - xx2.^2) + 0.5*(2*xx1 + xx2);
figure(3)
surf(xx1,xx2,F1)
title('Objective J(x_1, x_2)')
hold on
for i = 1:length(front) 
    plot3(front(1,i),front(2,i),J(front(:,i)),'k.')
    hold on;
end
