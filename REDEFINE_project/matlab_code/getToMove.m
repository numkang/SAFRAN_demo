function appToMove = getToMove(toKill,CRT)
% Returns which app must move if a router or a CR was killed and a
% reconfiguration is needed

global startApp
appToMove=[];

task=find(CRT(toKill,:));

for k = 1:length(startApp)-1
    if ismember(task,startApp(k)+1:startApp(k+1))
        appToMove=k;
        break;
    end
end

end

