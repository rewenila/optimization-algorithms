%-----------------------------NBI------------------------------

%Passos:
%1) ponto �timo (m�ximo) individual de cada fun��o 
%2) ponto de utopia (vetor com os m�ximos de cada fun��o)
%3) ponto de nadir (vetor com os m�nimos de cada fun��o)
%4) dist�ncia entre os pontos nadir-utopia
%5) normaliza��o

%1)
%ponto �timo de J1
%posic�es, velocidades e xbests iniciais
for j = 1:n
    for i = 1:2
        x(i,j) = rand*(xl(i,2)-xl(i,1))+xl(i,1);
        v(i,j) = 0;
        xlbest(i,j) = x(i,j);
    end
    
    if J1(xlbest(:,j))>J1(xgbest1(:))
        xgbest1(:) = xlbest(:,j);
    end
end
    
for r = 1:150
    
    %novos xbests
    for j = 1:n
        if J1(x(:,j))>J1(xlbest(:,j))
            xlbest(:,j) = x(:,j);
        end 
        if J1(xlbest(:,j))>J1(xgbest1(:))
            xgbest1(:) = xlbest(:,j);
        end
    end
    %novas posi��es e velocidades
    for j = 1:n
        for i = 1:2
            v(i,j) = w*v(j)+lambda1*rand*(xlbest(i,j)-x(i,j))+lambda2*rand*(xgbest1(i)-x(i,j));
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

%ponto �timo de J2
%posic�es, velocidades e xbests iniciais
for j = 1:n
    for i = 1:2
        x(i,j) = rand*(xl(i,2)-xl(i,1))+xl(i,1);
        v(i,j) = 0;
        xlbest(i,j) = x(i,j);
    end
    
    if J2(xlbest(:,j))>J2(xgbest2(:))
        xgbest2(:) = xlbest(:,j);
    end
end
    
for r = 1:150
    
    %novos xbests
    for j = 1:n
        if J2(x(:,j))>J2(xlbest(:,j))
            xlbest(:,j) = x(:,j);
        end 
        if J2(xlbest(:,j))>J2(xgbest2(:))
            xgbest2(:) = xlbest(:,j);
        end
    end
    %novas posi��es e velocidades
    for j = 1:n
        for i = 1:2
            v(i,j) = w*v(j)+lambda1*rand*(xlbest(i,j)-x(i,j))+lambda2*rand*(xgbest2(i)-x(i,j));
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

%2) ponto de utopia
JU = [J1(xgbest1), J2(xgbest2)];

%3) ponto de nadir
JN = [min(J1(xgbest1),J1(xgbest2)), min(J2(xgbest1),J2(xgbest2))];

%4) dist�ncia
L = JN - JU;

%5) normaliza��o
nJ1 = @(x) (J1(x) - J1(xgbest1))/L(1);
nJ2 = @(x) (J2(x) - J2(xgbest2))/L(2);

%------------------------------Plots----------------------------

x1 = [-3:.1:3];x2 = [-3:.1:3];[xx1,xx2] = meshgrid(x1,x2);

%objective space
figure(1)
for i = 1:length(x1)
    for j = 1:length(x2)
        fJ1(i,j) = nJ1([xx1(i,j),xx2(i,j)]);
        fJ2(i,j) = nJ2([xx1(i,j),xx2(i,j)]);
        %fJ(i,j) = F([xx1(i,j),xx2(i,j)]);
        plot(fJ1(i,j),fJ2(i,j),'k.');hold on
    end
end
xlabel('nJ_1');ylabel('nJ_2');
title('Objective Space (nJ_1, nJ_2)')