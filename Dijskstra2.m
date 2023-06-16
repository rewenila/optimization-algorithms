P = [0,   60,  73,  inf, inf, inf;
     66,  0,   77,  26,  41,  inf;
     70,  77,  0,   inf, 22,  inf;
     inf, 28,  inf, 0,   35,  38 ;
     inf, 43,  27,  36,  0,   61 ;
     inf, inf, inf, 31,  53,  0 ];
 
Flag = [1, 0, 0, 0, 0, 0];
Rot  = [0,   inf, inf, inf, inf, inf];
Perm =  0;
A    = [inf, inf, inf, inf, inf, inf];
k    =  1;
 
while Flag(6) == 0
    for i=1:6
        for j=1:6
            if (Flag(j) == 0)
                Rot(j) = min(Rot(j), Perm+P(k,j));
                A(j) = Rot(j);
            end
        end
        if(Flag(i)==0 || i==1)
            Perm = min(A);
            k = find(A==Perm);
            Flag(k) = 1;
            A = [inf, inf, inf, inf, inf, inf];
        end
    end
    Rot
end