function [] = createNoC(structure,nMesh)

global nbPaths G NoC

a = []; b = [];

for n = 1:nMesh-1
	a = [a ((n-1)*nMesh+1:n*nMesh-1) ((n-1)*nMesh+1:n*nMesh)];
	b = [b ((n-1)*nMesh+2:n*nMesh) (n*nMesh+1:(n+1)*nMesh)];
end
    a = [a ((nMesh-1)*nMesh+1:nMesh*nMesh-1)];
    b = [b ((nMesh-1)*nMesh+2:nMesh*nMesh)];


NoC = graph(a,b);
G=full(abs(incidence(NoC)));

nbPaths=size(G,2);

end