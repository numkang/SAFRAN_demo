function t = getAllLinks(apps,linkMap)

t = []; prev = 0;
for k = 1:length(apps(1,:))
    i = 1;
    n = 1;
    while apps(i+1,k) ~=0
        j = i+1;
        while apps(j,k) ~= 0
            if linkMap(abs(apps(i,k)),abs(apps(j,k)))
                t = [t n+prev];
                n = n+1;
            end
            j = j+1;
        end
        i = i+1;
    end
    prev = prev + n;
end

end