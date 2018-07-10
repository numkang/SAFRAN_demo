clear
%close all
clc

global linkMap nMesh structure nbCR listCRs faultyRouters faultyCRs apps priority nAppsInit

%% Choose the algorithm

% if strcmp(str,'flex')
    alg = 1;
% elseif strcmp(str,'tom')
%     alg = 2;
% else
%     disp('Wrong input, default algorithm set to Flexible');
%     alg = 1;
% end

%% Choose the solver

% if strcmp(str,'cvx')
    % solver = 0; % Working on Windows
% elseif strcmp(str,'sat')
    solver = 1; % The one intended to be used, not working yet on my Windows laptop
                % change the path to Minisat in the readSATresult.m file
% else
%     disp('Wrong input, default solver set to cvx');
%     solver = 0;
% end


%% Choose and build the structure

nMesh = 4;
structure = 'mesh';
default = 1;
str = 'exit';

nbCR = nMesh*nMesh;
listCRs = 1:nbCR;
linkMap = createLinkMap();
createNoC(structure,nMesh);

faultyCRs=[];
faultyRouters=[];

%% Load the apps
apps = [];
priority = [];

oldCRT = setDefault();

% apps = sparse(apps);
nAppsInit = length(apps(1,:));

%% Launch the algorithm
algoFlexible('',oldCRT,solver,1,0,1);
