function [answer,toKill] = readInput(str,verb)
% Reads the input to filter it.
% answer: false if the input is not valid or element already killed.
% answer: 'cr' or 'ro' if the input is valid.
% toKill: number of the element to kill if input is valid.
% toKill: 0 if input is not valid.

global nMesh faultyRouters faultyCRs

maxNB = nMesh*nMesh;
toKill = 0;

error=['Wrong command. Use kill [cr/ro]<number>, where <number> is between 1 and ' int2str(maxNB) '.'];

if (length(str)>=8)
    if ((strcmp(str(1:7),'kill cr')) || (strcmp(str(1:7),'kill ro')))
        i = 8;
        while (i <= length(str) && isstrprop(str(i), 'digit'))
            toKill = toKill*10 + str2double(str(i));
            i = i+1;
        end
        if toKill > maxNB || toKill <= 0
            disp(error);
            answer = false;
            toKill = 0;
        elseif strcmp(str(1:7),'kill ro') 
            if ~ismember(toKill,faultyRouters)
                answer = 'ro';
            else
                if verb
                    disp(['You already killed router #',num2str(toKill),'!'])
                end
                answer='false';
                toKill=0;
            end
        else
            if (~ismember(toKill,faultyCRs) && ~ismember(toKill,faultyRouters))
                answer='cr';
            else
                if verb
                    disp(['You already killed CR #',num2str(toKill),'!'])
                end
                answer='false';
                toKill=0;
            end
        end
    else
        disp(error)
        answer='false';
        toKill=0;
    end
else
    disp(error)
    answer='false';
    toKill=0;
end

end