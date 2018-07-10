function [CRT,Af,sat_status,sat_cputime] = readSATresult(fichierRes,iCanDrop)

global apps

nbApps = length(apps(1,:));
fRes = fopen(fichierRes,'r');

line = fgetl(fRes);

while (line(1) ~= 's')
    line = fgetl(fRes);
end

sat_status = line(3:end);

CRT = [];
A = [];
if strcmp(sat_status,'OPTIMUM FOUND') || strcmp(sat_status,'SATISFIABLE')
    sat_status = 'Solved';
else
    sat_status = 'Infeasible';
end

if strcmp(sat_status,'Solved')
    line = fgetl(fRes);
else
    line = [];
end

c = 1;

while c < length(line)-3
    if line(c) == 'A'
        c1 = min(c+10,length(line));
        i = sscanf(line(c+2:c1),'%d_%d ');
        if line(c-1) == '-'
            val = 0;
        else
            val = 1;
        end
        A(i(1),i(2)) = val;
    elseif strcmp(line(c:c+2),'CRT')
        c1 = min(c+12,length(line));
        i = sscanf(line(c+4:c+12),'%d_%d ');
        if line(c-1) == '-'
            val = 0;
        else
            val = 1;
        end
        CRT(i(1),i(2)) = val;
    end
    c = c+1;
end

if strcmp(sat_status,'Solved')
    Af = ones(nbApps,1);
    Af(iCanDrop) = A;
else
    Af = zeros(1,nbApps);
end


for i = 1:7
    fgetl(fRes);
end

line = fgetl(fRes);
c = 1;
while ~isstrprop(line(c), 'digit')
    c = c+1;
end

c1 = c+1;
while (isstrprop(line(c1), 'digit') || line(c1) == '.')
    c1 = c1+1;
end
sat_cputime = sscanf(line(c:c1),'%f');
