function [A,b,dec] = createGeomConst(apps,linkMap)


nApp = length(apps(1,:));

allNodes = getAllNodes(apps);
nN = length(allNodes);

A = zeros(nN);
b = zeros(nN,1);
prev = 0;
a = 1;
dec = 0;

for k = 1:nApp
    i = 1;
    while apps(i+1,k) ~= 0
        j = i+1;
        while apps(j,k) ~= 0
            if linkMap(abs(apps(i,k)),abs(apps(j,k)))
                A(a,prev+i) = -1;
                A(a,prev+j) = 1;
                b(a) = abs(apps(j,k)) - abs(apps(i,k));
                a = a+1;
            end
            j = j+1;
        end
        i = i+1;
    end
    dec = [dec a-1];
    prev = prev+ i;
end
dec = [dec a-1];

A = A(1:a-1,:)';
b = b(1:a-1);
% A = sparse(A);
% b = sparse(b);

end
            