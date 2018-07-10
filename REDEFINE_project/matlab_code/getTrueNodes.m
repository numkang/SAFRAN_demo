function t = getTrueNodes(apps)

t = []; prev = 0;
for k = 1:length(apps(1,:))
    i = 1;
    while apps(i,k) ~=0
        if apps(i,k) > 0
            t = [t i+prev];
        end
        i = i+1;
    end
    prev = prev + i-1;
end

end