P = [0,   15,  inf, inf, 9,   inf;
     inf, 0,   35,  3,   inf, inf;
     inf, 16,  0,   6,   inf, 21 ;
     inf, inf, inf, 0,   2,   7  ;
     inf, 4,   inf, 2,   0,   inf;
     inf, inf, 5,   inf, inf,   0];
 
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
  

 
 
 