function L = createLinkMap()
%compute L(i,j) = 1 if i -> j is possible with structure

global structure nMesh

L = zeros(nMesh*nMesh);
for i = 1:nMesh*nMesh
    if mod(i,nMesh) ~= 0 %not on last column
        L(i,i+1) = 1;
%     elseif strcmp(structure,'toroid') == 1
%         L(i,1) = 1;
    end
    
    if floor((i-1)/nMesh) ~= nMesh-1 %not on last row
        L(i,i+nMesh) = 1;
%     elseif strcmp(structure,'toroid') == 1
%         if mod(i,nMesh) ~= 0
%             L(i,mod(i,nMesh)) = 1;
%         else
%             L(i,nMesh) = 1;
%         end
    end
end

%L = sparse(L); %economy of size

end


