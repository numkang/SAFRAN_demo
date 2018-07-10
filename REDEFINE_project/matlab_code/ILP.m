function [CRT,Af,cvx_status,cvx_cputime,t1] = ILP(nMesh,structure,faultyCRs,faultyRouters,apps,priority,oldCRT,appToMove)

global nbCR nbPaths listCRs G linkMap startApp

tic;
T = createGraph(apps);

nbTasks=size(T,1);
nbTaskPaths=size(T,2);
nbApps = length(priority);
trueNodes = getTrueNodes(apps);

frozenTasks=[];

% only move the affected app
appsToKeep=setdiff((1:nbApps),appToMove);


if isempty(appToMove)
    movePriority = max(priority)+1;
else
    movePriority = min(priority(appToMove));
end
if movePriority == min(priority)
    movePriority = movePriority + 1;
end

iCanDrop = find(priority >= movePriority);
%iCantDrop = setdiff((1:nbApps),iCanDrop);
nbDrop = length(iCanDrop);
[~,iP] = sort(priority(iCanDrop));

%%%%%%% to put in a function DONE
startApp = zeros(1,nbApps+1);
for k = 2:nbApps+1
    startApp(k) = length(getAllNodes(apps(:,k-1)));
end
if nbApps > 2
    for k = 3:nbApps+1
        startApp(k) = startApp(k-1)+startApp(k);
    end
end


% TODO
%%%%%%% to put in a function
linksApp = zeros(1,nbApps+1);
for k = 2:nbApps+1
    linksApp(k) = length(getAllLinks(apps(:,k-1),linkMap));
end
if nbApps > 2
    for k = 3:nbApps+1
        linksApp(k) = linksApp(k-1)+linksApp(k);
    end
end

for k = 1:length(appsToKeep)
    frozenTasks=[frozenTasks startApp(appsToKeep(k))+getAllNodes(apps(:,appsToKeep(k)))];
end

[A_geom,b_geom,dec] = createGeomConst(apps,linkMap);
if strcmp(structure,'toroid')
    b_tor = -b_geom * (nMesh-1);
end


%tic
cvx_begin quiet

variable CRT(nbCR,nbTasks) binary
variable CD(nbPaths,nbTaskPaths) binary
variable DN(1,nbDrop) binary
variable M(nbTasks) binary
variable A(nbDrop) binary

if strcmp(structure,'toroid')
    variable Y(2,nbTaskPaths) binary
end

maximize sum(A) - sum(M)/nbCR

subject to

% define which variables can be modified if it's not the first execution
if ~isempty(oldCRT)
    for i=frozenTasks
        k = find(startApp <= i,1,'last');
        if i == startApp(k)
            k = k-1;
        end
        [dropMe,kd] = ismember(k,iCanDrop);
        j = find(oldCRT(:,i),1);
        if dropMe
            CRT(j,i) + DN(kd) + M(i) >= oldCRT(j,i);
        else
            CRT(j,i) + M(i) >= oldCRT(j,i);
        end
    end
end

% failure

% there are faulty routers - do not use the corresponding node at all
if ~isempty(faultyRouters)
    for i=1:length(faultyRouters)
        sum(CRT(faultyRouters(i),:))==0;
    end
end

% there are faulty CRs - we can still use the corresponding router for
% ghost tasks
if ~isempty(faultyCRs)
    for i=1:length(faultyCRs)
        sum(CRT(faultyCRs(i),trueNodes))==0;
    end
end

% one CR can execute one task maximum
for i=1:size(CRT,1)
    sum(CRT(i,:))<=1;
end

% every task must be executed by one CR
for k = 1:nbApps
    [dropMe,kd] = ismember(k,iCanDrop);
    for i=startApp(k)+1:startApp(k+1)
        if dropMe
            sum(CRT(:,i))==1 - DN(kd);
        else
            sum(CRT(:,i))==1;
        end
    end
end

% one NoC path can be mapped to one app link maximum
for i=1:size(CD,1)
    sum(CD(i,:))<=1;
end

% every app link must be mapped to one NoC path
for k=1:nbApps
    [dropMe,kd] = ismember(k,iCanDrop);
    for i=linksApp(k)+1:linksApp(k+1)
        if dropMe
            sum(CD(:,i))==1 - DN(kd);
        else
            sum(CD(:,i))==1;
        end
    end
end


% link between CRs and paths / apps and links
CRT*T==G*CD;

% Geometry constraints
if (strcmp(structure,'mesh'))
    for k = 1:nbApps
        [dropMe,kd] = ismember(k,iCanDrop);
        if dropMe
            listCRs*CRT(:,startApp(k)+1:startApp(k+1))*A_geom(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b_geom(dec(k)+1:dec(k+1))'*(1-DN(kd));
        else
            listCRs*CRT(:,startApp(k)+1:startApp(k+1))*A_geom(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b_geom(dec(k)+1:dec(k+1))';
        end
    end
else
    %listCRs*CRT*A_geom == b_geom'.*Y(1,:)+b_tor'.*Y(2,:);
    for k = 1:nbApps
        listCRs*CRT(:,startApp(k)+1:startApp(k+1))*A_geom(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b_geom(dec(k)+1:dec(k+1))'.*Y(1,(dec(k)+1:dec(k+1)))+b_tor(dec(k)+1:dec(k+1))'.*Y(2,(dec(k)+1:dec(k+1)));
        [dropMe,kd] = ismember(k,iCanDrop);
        if dropMe
            Y(1,dec(k)+1:dec(k+1)) + Y(2,dec(k)+1:dec(k+1)) == A(kd);
        else
            Y(1,dec(k)+1:dec(k+1)) + Y(2,dec(k)+1:dec(k+1)) == 1;
        end
    end
end

%Priority constraints
for k = 2:nbDrop
    A(iP(k)) <= A(iP(k-1));
end

for k = 1:nbDrop
    A(k) == 1 - DN(k);
end

t1=toc;
cvx_end

Af = ones(nbApps,1);
Af(iCanDrop) = A;

end