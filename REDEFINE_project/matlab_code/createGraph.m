function T = createGraph(apps)

global linkMap

T = graph();
for k = 1:length(apps(1,:))
    i = 1;
    c = []; d = [];
    while apps(i+1,k) ~= 0
        j = i+1;
        while apps(j,k) ~= 0
            if linkMap(abs(apps(i,k)),abs(apps(j,k)))
                c = [c i];
                d = [d j];
            end
            j = j+1;
        end
        i = i+1;
    end
    T1 = full(abs(incidence(graph(c,d))));
    if k > 1
        T = blkdiag(T,T1);
    else
        T = blkdiag(T1);
    end
end

end