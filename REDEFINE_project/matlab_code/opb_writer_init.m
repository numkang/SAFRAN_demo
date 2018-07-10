function [iCanDrop,t] = opb_writer_init(nMesh,structure,faultyCRs,faultyRouters,apps,priority,oldCRT,appToMove)

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


movePriority = min(priority)+1;

iCanDrop = find(priority >= movePriority);
nbDrop = length(iCanDrop);
[~,iP] = sort(priority(iCanDrop));

startApp = zeros(1,nbApps+1);
for k = 2:nbApps+1
    startApp(k) = length(getAllNodes(apps(:,k-1)));
end
if nbApps >= 2
    for k = 3:nbApps+1
        startApp(k) = startApp(k-1)+startApp(k);
    end
end

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

%% String variables

CRT = strings(nbCR,nbTasks);
for i=1:nbCR
    for j=1:nbTasks
        CRT(i,j) = strcat('CRT_', int2str(i), '_', int2str(j) );
    end
end

CD = strings(nbPaths,nbTaskPaths);
for i=1:nbPaths
    for j=1:nbTaskPaths
        CD(i,j) = strcat('CD_', int2str(i), '_', int2str(j) );
    end
end

DN = strings(1,nbDrop);
for i=1:nbDrop
    DN(1,i) = strcat('DN_1_', int2str(i) );
end

M = strings(1,nbApps);
for j=1:nbApps
    M(1,j) = strcat('M_1_', int2str(j) );
end

A = strings(1,nbDrop);
for j=1:nbDrop
    A(1,j) = strcat('A_1_', int2str(j) );
end

if strcmp(structure,'toroid')
    Y = strings(2,nbTaskPaths);
    for i=1:2
        for j=1:nbTaskPaths
            Y(i,j) = strcat('Y_', int2str(i), '_', int2str(j));
        end
    end
end

%% Writing in the opb file
fVar = fopen('sat_variable.opb','w');
fConst = fopen('sat_constant.opb','w');

% objective function
fprintf(fConst, '* OBJECTIVE FUNCTION\n');
fprintf(fConst, 'min:'); % sat works only with minimization and integer coefficients

for j=1:nbDrop
    fprintf(fConst, strcat(' -', num2str(nbApps), '*', A(1,j)) );
end

for j=1:nbApps
    fprintf(fConst, strcat(' +1*', M(1,j)) );
end

fprintf(fConst, ' ;\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTRAINTS
fprintf(fVar, '* VARIABLE CONSTRAINTS\n');
fprintf(fConst, '* CONSTANT CONSTRAINTS\n');
% Objective Bound
for j=1:nbDrop
    fprintf(fConst, strcat(' -', num2str(nbApps), '*', A(1,j)) );
end

for j=1:nbApps
    fprintf(fConst, strcat(' +1*', M(1,j)) );
end
fprintf(fConst,' <= 0;\n');

% define which variables can be modified if it's not the first execution
fprintf(fVar, '* DEFINE WHICH VARIABLES CAN BE MODIFIED IF IT IS NOT THE FIRST EXECUTION\n');
if ~isempty(oldCRT)
    for i=frozenTasks
        k = find(startApp <= i,1,'last');
        if i == startApp(k)
            k = k-1;
        end
        [dropMe,kd] = ismember(k,iCanDrop);
        j = find(oldCRT(:,i),1);
        if ~isempty(j)
            if dropMe
                fprintf(fVar, strcat('+1*', CRT(j,i), ' +1*', DN(kd), ' +1*', M(k), ' >= ', int2str(oldCRT(j,i)), ';\n') );
            else
                fprintf(fVar, strcat('+1*', CRT(j,i), ' +1*', M(k), ' >= ', int2str(oldCRT(j,i)), ';\n' ) );
            end
        end
    end
end

% failure

% there are faulty routers - do not use the corresponding node at all
if ~isempty(faultyRouters)
    for i=1:length(faultyRouters)
        for j=1:nbTasks
            fprintf(fConst, strcat(' +1*', CRT(faultyRouters(i),j)) );
        end
        fprintf(fConst, ' = 0;\n');
    end
end

% there are faulty CRs - we can still use the corresponding router for
% ghost tasks
if ~isempty(faultyCRs)
    for i=1:length(faultyCRs)
        for j=trueNodes
            fprintf(fConst, strcat(' +1*', CRT(faultyCRs(i),j)) );
        end
        fprintf(fConst, ' = 0;\n');
    end
end

% one CR can execute one task maximum
fprintf(fConst, '* ONE CR CAN EXECUTE ONE TASK MAXIMUM\n');
for i=1:size(CRT,1)
    for j=1:nbTasks
        fprintf(fConst, strcat(' +1*', CRT(i,j)) );
    end
    fprintf(fConst, ' <= 1;\n');
end

% every task must be executed by one CR
fprintf(fConst, '* EVERY TASK MUST BE EXECUTED BY ONE CR\n');
for k = 1:nbApps
    [dropMe,kd] = ismember(k,iCanDrop);
    for i=startApp(k)+1:startApp(k+1)
        if dropMe
            for j=1:nbCR
                fprintf(fConst, strcat(' +1*', CRT(j,i)) );
            end
            fprintf(fConst, strcat('+1*', DN(kd), ' = 1;\n'));
        else
            for j=1:nbCR
                fprintf(fConst, strcat(' +1*', CRT(j,i)) );
            end
            fprintf(fConst, ' = 1;\n');
        end
    end
end

% one NoC path can be mapped to one app link maximum
fprintf(fConst, '* ONE NOC PATH CAN BE MAPPED TO ONE APP LINK MAXIMUM\n');
for i=1:size(CD,1)
    for j=1:nbTaskPaths
        fprintf(fConst, strcat(' +1*', CD(i,j)) );
    end
    fprintf(fConst, ' <= 1;\n');
end

% every app link must be mapped to one NoC path
fprintf(fConst, '* EVERY APP LINK MUST BE MAPPED TO ONE NOC PATH\n');
for k=1:nbApps
    [dropMe,kd] = ismember(k,iCanDrop);
    for i=linksApp(k)+1:linksApp(k+1)
        if dropMe
            for j=1:nbPaths
                fprintf(fConst, strcat(' +1*', CD(j,i)) );
            end
            fprintf(fConst, strcat('+1*', DN(kd), ' = 1;\n'));
        else
            for j=1:nbPaths
                fprintf(fConst, strcat(' +1*', CD(j,i)) );
            end
            fprintf(fConst, ' = 1;\n');
        end
    end
end


% link between CRs and paths / apps and links
fprintf(fConst, '* LINK BETWEEN CRS AND PATH / APPS AND LINKS\n');
for i=1:nbCR
    for j=1:nbTaskPaths
        K = find(T(:,j)'>0);
        for k=K
            fprintf(fConst, strcat(' +', int2str(T(k,j)), '*', CRT(i,k) ) );
        end
        Mm = find(G(i,:)>0);
        for m=Mm
            fprintf(fConst, strcat(' -', int2str(G(i,m)), '*', CD(m,j) ) );
        end
        fprintf(fConst, ' = 0;\n');
    end
end

% Geometry constraints
fprintf(fConst, '* GEOMETRY CONSTRAINTS\n');
if (strcmp(structure,'mesh'))
    for k = 1:nbApps
        [dropMe,kd] = ismember(k,iCanDrop);
        if dropMe
            for j=dec(k)+1:dec(k+1)
                for n=1:nbCR
                    for m=startApp(k)+1:startApp(k+1)
                        val = listCRs(1,n)*A_geom(m,j);
                        if val > 0
                            fprintf(fConst, strcat(' +', int2str(val), '*', CRT(n,m) ) );
                        elseif val < 0
                            fprintf(fConst, strcat(int2str(val), '*', CRT(n,m) ) );
                        end
                    end
                end
                val = b_geom(j);
                if val > 0
                    fprintf(fConst, strcat(' +', int2str(val), '*', DN(kd), ' = ', int2str(val), ';\n') );
                elseif val < 0
                    fprintf(fConst, strcat(int2str(val), '*', DN(kd), ' = ', int2str(val), ';\n') );
                end
            end
            % listCRs*CRT(:,startApp(k)+1:startApp(k+1))*A_geom(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b_geom(dec(k)+1:dec(k+1))'*(1-DN(kd));
        else
            for j=dec(k)+1:dec(k+1)
                for n=1:nbCR
                    for m=startApp(k)+1:startApp(k+1)
                        val = listCRs(1,n)*A_geom(m,j);
                        if val > 0
                            fprintf(fConst, strcat(' +', int2str(val), '*', CRT(n,m) ) );
                        elseif val < 0
                            fprintf(fConst, strcat(int2str(val), '*', CRT(n,m) ) );
                        end
                    end
                end
                fprintf(fConst, strcat(' = ', int2str(b_geom(j)), ';\n') );
            end
            % listCRs*CRT(:,startApp(k)+1:startApp(k+1))*A_geom(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b_geom(dec(k)+1:dec(k+1))';
        end
    end
else
    %listCRs*CRT*A_geom == b_geom'.*Y(1,:)+b_tor'.*Y(2,:);
    for k = 1:nbApps
        for j=dec(k)+1:dec(k+1)
            for n=1:nbCR
                for m=startApp(k)+1:startApp(k+1)
                    val = listCRs(1,n)*A_geom(m,j);
                    if val > 0
                        fprintf(fConst, strcat(' +', int2str(val), '*', CRT(n,m) ) );
                    elseif val < 0
                        fprintf(fConst, strcat(int2str(val), '*', CRT(n,m) ) );
                    end
                end
            end
            
            val = b_geom(j);
            if val > 0
                fprintf(fConst, strcat(' -', int2str(val), '*', Y(1,j)) );
            elseif val < 0
                fprintf(fConst, strcat(' +', int2str(-val), '*', Y(1,j)) );
            end
            
            val = b_tor(j);
            if val > 0
                fprintf(fConst, strcat(' -', int2str(val), '*', Y(2,j)) );
            elseif val < 0
                fprintf(fConst, strcat(' +', int2str(-val), '*', Y(2,j)) );
            end
            
            fprintf(fConst, ' = 0;\n');
        end
        %listCRs*CRT(:,startApp(k)+1:startApp(k+1))*A_geom(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b_geom(dec(k)+1:dec(k+1))'.*Y(1,(dec(k)+1:dec(k+1)))+b_tor(dec(k)+1:dec(k+1))'.*Y(2,(dec(k)+1:dec(k+1)));
        
        [dropMe,kd] = ismember(k,iCanDrop);
        if dropMe
            for j=dec(k)+1:dec(k+1)
                fprintf(fConst, strcat('+1*', Y(1,j), ' +1*', Y(2,j), '-1*', A(kd), ' = 0;\n') );
            end
        else
            for j=dec(k)+1:dec(k+1)
                fprintf(fConst, strcat('+1*', Y(1,j), ' +1*', Y(2,j), ' = 1;\n') );
            end
        end
    end
end

%Priority constraints
fprintf(fConst, '* PRIORITY CONSTRAINTS\n');
for k = 2:nbDrop
    fprintf(fConst, strcat('+1*', A(iP(k)), '-1*', A(iP(k-1)), ' <= 0;\n')); 
end

for k = 1:nbDrop
    fprintf(fConst, strcat('+1*', A(k), '+1*', DN(k), ' = 1;\n'));
end


%%

fclose(fVar);
fclose(fConst);

system('cat sat_constant.opb > sat_total.opb');
system('cat sat_variable.opb >> sat_total.opb');

t=toc;
end