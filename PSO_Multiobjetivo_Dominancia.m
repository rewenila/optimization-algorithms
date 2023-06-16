clear all; clc; rng(10);

%funções a serem otimizadas
J1 = @(x) 3*(1-x(1))^2*exp(-x(1)^2 - (x(2)+1)^2) - 10*(x(1)/5 - x(1)^3 - x(2)^5)*exp(-x(1)^2 - x(2)^2) - 3*exp(-(x(1)+2)^2 - x(2)^2) + 0.5*(2*x(1) + x(2));
J2 = @(x) 3*(1+x(2))^2*exp(-x(2)^2 - (-x(1)+1)^2) - 10*(-x(2)/5 + x(2)^3 + x(1)^5)*exp(-x(2)^2 - x(1)^2) - 3*exp(-(2-x(2))^2 - x(1)^2);

%parâmetros
xl = [-3 3; -3 3];  %limites
n = 100;            %população
w = 0.1;            %inércia
lambda1 = 0.9; 
lambda2 = 0.1; 
xgbest = [0,0];
m = 1;
k = 1;
k1 = 1;
z = 2;

%-----------------------PSO com dominância------------------------

%posicões, velocidades e xbests iniciais
J = @(x) J1(x) + J2(x);
for j = 1:n
    for i = 1:2
        x(i,j) = rand*(xl(i,2)-xl(i,1))+xl(i,1);
        v(i,j) = 0;
        xlbest(i,j) = x(i,j);
    end
    
    if J(xlbest(:,j))>J(xgbest(:))
        xgbest(:) = xlbest(:,j);
    end
end

%soluções não-dominadas iniciais
for ind1 = 1:(n-1)
    for ind2 = (ind1+1):n
        Ja = [J1(x(:,ind1)),J2(x(:,ind1))];
        Jb = [J1(x(:,ind2)),J2(x(:,ind2))];
        scorea = 0; scoreb = 0;
        for indz = 1:z
            if Ja(indz)>Jb(indz)
                scorea = scorea+1;
            elseif Ja(indz)<Jb(indz)
                scoreb = scoreb+1;
            else
            end
        end
        if scoreb == 0 && scorea ~= 0
            dmatrix(ind1,ind2) = 1;
        elseif scorea == 0 && scoreb ~= 0
            dmatrix(ind2,ind1) = 1;
        else
        end
    end
end
soma = sum(dmatrix);
for j1 = 1:length(soma)
    if soma(j1) == 0           %ponto não dominado
        front(:,k) = x(:,j1);  %é armazenado
        k = k+1;
    end
end
    

for r = 1:1000
        
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
    
    %novas soluções não dominadas baseadas nos novos pontos
    for ind1 = 1:(n-1)
        for ind2 = (ind1+1):n
            Ja = [J1(x(:,ind1)),J2(x(:,ind1))];
            Jb = [J1(x(:,ind2)),J2(x(:,ind2))];
            scorea = 0; scoreb = 0;
            for indz = 1:z
                if Ja(indz)>Jb(indz)
                    scorea = scorea+1;
                elseif Ja(indz)<Jb(indz)
                    scoreb = scoreb+1;
                else
                end
            end
            if scoreb == 0 && scorea ~= 0
                dmatrix(ind1,ind2) = 1;
            elseif scorea == 0 && scoreb ~= 0
                dmatrix(ind2,ind1) = 1;
            else
            end
        end
    end
    soma = sum(dmatrix);
    for j1 = 1:length(soma)
        if soma(j1) == 0           %ponto não dominado
            front(:,k) = x(:,j1)   %é armazenado
            k = k+1;
        end
    end
end 

%remoção das soluções dominadas dentre as encontradas
for ind1 = 1:(length(front)-1)
    for ind2 = (ind1+1):length(front)
        Ja = [J1(front(:,ind1)),J2(front(:,ind1))];
        Jb = [J1(front(:,ind2)),J2(front(:,ind2))];
        scorea = 0; scoreb = 0;
        for indz = 1:z
            if Ja(indz)>Jb(indz)
                scorea = scorea+1;
            elseif Ja(indz)<Jb(indz)
                scoreb = scoreb+1;
            else
            end
        end
        if scoreb == 0 && scorea ~= 0
            dmatrix(ind1,ind2) = 1;
        elseif scorea == 0 && scoreb ~= 0
            dmatrix(ind2,ind1) = 1;
        else
        end
    end
end
soma = sum(dmatrix);
for j2 = 1:length(soma)
    if soma(j2) == 0                %ponto não dominado
        nfront(:,k1) = front(:,j2)  %é armazenado
        k1 = k1+1;
    end
end

%----------------------------Plots------------------------------

x1 = [-3:.1:3];x2 = [-3:.1:3];[xx1,xx2] = meshgrid(x1,x2);
for i = 1:length(x1)
    for j = 1:length(x2)
        fJ1(i,j) = J1([xx1(i,j),xx2(i,j)]);
        fJ2(i,j) = J2([xx1(i,j),xx2(i,j)]);
        plot(fJ1(i,j),fJ2(i,j),'k.');hold on
    end
end
xlabel('J1');ylabel('J2');
title('Objective Space (J_1, J_2)')
hold on
for i = 1:length(nfront) 
    plot(J1(nfront(:,i)),J2(nfront(:,i)), 'r.')
    hold on;
end



