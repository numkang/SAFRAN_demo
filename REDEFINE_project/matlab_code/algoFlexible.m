function algoFlexible(inputs,oldCRT,solver,fig,delay,verb)

global faultyRouters faultyCRs apps priority structure nMesh

appToMove=1;
trueNodes = getTrueNodes(apps);
faultyCR = [];
faultyRouter = [];

% stat = [length(apps(1,:)); length(getAllNodes(apps)); length(getTrueNodes(apps))];
% Initial configuration
if solver == 1
    [CRT,A,solver_status,solver_cputime,solver_writeTime] = ILP_sat(1,1,nMesh,structure,faultyCRs,faultyRouters,faultyCR,faultyRouter,apps,priority,oldCRT,appToMove);
else
    [CRT,A,solver_status,solver_cputime,solver_writeTime]=ILP(nMesh,structure,faultyCRs,faultyRouters,apps,priority,oldCRT,appToMove);
end
% t = [solver_cputime;solver_writeTime];

 
if (strcmp(solver_status,'Infeasible'))
    error('No feasible solution with these initial conditions.')
end

% Remove apps that will never be used anyways and solve again if necessary
% nInit = find(A>0,1,'last');
% if nInit < length(priority)
%     nDrop = length(priority) - nInit;
%     priority = priority(1:nInit);
%     apps = apps(:,1:nInit);
%     appToMove=1;
%     trueNodes = getTrueNodes(apps);
%     faultyCR = [];
%     faultyRouter = [];
%     
%     if solver == 1
%         [CRT,A,solver_status,solver_cputime,solver_writeTime] = ILP_sat(1,1,nMesh,structure,faultyCRs,faultyRouters,faultyCR,faultyRouter,apps,priority,oldCRT,appToMove);
%     else
%         [CRT,A,solver_status,solver_cputime,solver_writeTime]=ILP(nMesh,structure,faultyCRs,faultyRouters,apps,priority,oldCRT,appToMove);
%     end
%     %t = t+[solver_cputime;solver_writeTime];
% 
% end

% % plot the NoC
% p=plotNoC(solver_status,CRT,A,fig);
% drawnow;

prompt = 'What do we do now? ';
if isempty(inputs)
    str = input(prompt,'s');
else
    str = inputs(1,:);
end

i = 2;
faultyCR = [];
faultyRouter = [];


while(~strcmp(str(1:4),'exit'))
    pause(delay);
    if isempty(find(isnan(A),1))
%         appsAlloc =  find(A==1);
%         stat(:,i) = [length(appsAlloc);length(getAllNodes(apps(:,appsAlloc))); length(getTrueNodes(apps(:,appsAlloc)))];
    else
%         stat(:,i) = [0; 0; 0];
    end
    
%     solver_cputime = 0;
%     solver_writeTime = 0;
    [answer,toKill]=readInput(str,verb);%%%%%%%%%% will be replaced by health monitoring
    
    if ~(strcmp(answer,'false'))
        % if the input is valid
        if (strcmp(answer,'cr'))
            if verb
                disp(['Killing CR #',num2str(toKill),'.'])
            end
            faultyCRs=[faultyCRs toKill];
            faultyCR = [faultyCR toKill];
        elseif (strcmp(answer,'ro'))
            if verb
                disp(['Killing router #',num2str(toKill),'.'])
            end
            faultyRouters=[faultyRouters toKill];
            faultyRouter = [faultyRouter toKill];
        end
        if (strcmp(answer,'cr') && sum(CRT(toKill,trueNodes))==0)
%             if (~ismember(toKill,faultyRouters))
%                 highlight(p,toKill,'Marker','s','NodeColor',[0.8392 0.0157 0.0157]); drawnow;
%             end
            if verb
                disp('No reconfiguration needed.')
            end
%             title({'\vspace{0.2cm}','Faulty CRs: ' num2str(faultyCRs),'Faulty routers: ' num2str(faultyRouters),'Remaining apps: ' num2str(priority),'\textbf{Solution found.}'},'Interpreter','LaTeX')
        elseif (strcmp(answer,'ro') && sum(CRT(toKill,:))==0)
%             highlight(p,toKill,'Marker','h','NodeColor',[0.8392 0.0157 0.0157]); drawnow;
%             title({'\vspace{0.2cm}','Faulty CRs: ' num2str(faultyCRs),'Faulty routers: ' num2str(faultyRouters),'Remaining apps: ' num2str(priority),'\textbf{Solution found.}'},'Interpreter','LaTeX')
            if verb
                disp('No reconfiguration needed.')
            end
        else
            % here we have to reconfigure
%             if strcmp(answer,'cr')
%                 highlight(p,toKill,'Marker','s','NodeColor',[0.8392 0.0157 0.0157]); drawnow;
%             else
%                 highlight(p,toKill,'Marker','h','NodeColor',[0.8392 0.0157 0.0157]); drawnow;
%             end
            oldCRT=CRT;
            appToMove=getToMove(toKill,CRT);
            if verb
                disp(['App #',num2str(appToMove),' must be reconfigured']);
            end
            if solver == 0
                [CRT,A,solver_status,solver_cputime,solver_writeTime]=ILP(nMesh,structure,faultyCRs,faultyRouters,apps,priority,oldCRT,appToMove);
            else
                [CRT,A,solver_status,solver_cputime,solver_writeTime]=ILP_sat(0,1,nMesh,structure,faultyCRs,faultyRouters,faultyCR,faultyRouter,apps,priority,oldCRT,appToMove);
            end
            faultyCR = [];
            faultyRouter = [];
            
            if (~strcmp(solver_status,'Infeasible'))
                if verb
                    disp(['Solution found. The reconfiguration took ',num2str(solver_cputime),' seconds.']);
                end
            else
                if verb
                    disp('Reconfiguration impossible. Change your hardware!');
                    disp(['The attempt took ',num2str(solver_cputime),' seconds.']);
                end
                str = 'exit';
            end
            
        end
    end
    % Going to the next failure
    if ~strcmp(str,'exit')
        if isempty(inputs)
            str = input(prompt,'s');
        elseif i > length(inputs(:,1))
            str = 'exit';
        else
            str = inputs(i,:);
        end
    end
%     t(1,i) = solver_cputime;
%     t(2,i) = solver_writeTime;
    i = i+1;
end

% if isempty(find(isnan(A),1))
%     appsAlloc =  find(A==1);
%     stat(:,i) = [length(appsAlloc);length(getAllNodes(apps(:,appsAlloc))); length(getTrueNodes(apps(:,appsAlloc)))];
% else
%     stat(:,i) = [0; 0; 0];
% end


% fclose('all');

end