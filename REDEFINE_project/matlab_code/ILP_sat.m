function [CRT,A,sat_status,sat_cputime,sat_writeTime] = ILP_sat(init,alg,nMesh,structure,faultyCRs,faultyRouters,faultyCR,faultyRouter,apps,priority,oldCRT,appToMove)

if init
    if alg
        [toDrop,sat_writeTime] = opb_writer_init(nMesh,structure,faultyCRs,faultyRouters,apps,priority,oldCRT,appToMove);
%     else
%         sat_writeTime = opb_writer_init_noDrop(nMesh,structure,faultyCRs,faultyRouters,apps,oldCRT,appToMove);
%         toDrop = [];
    end
else
    if alg
        [toDrop,sat_writeTime]=opb_writer_add(faultyCR,faultyRouter,apps,priority,oldCRT,appToMove);
%     else
%         sat_writeTime = opb_writer_add_noDrop(faultyCR,faultyRouter,apps,oldCRT,appToMove);
%         toDrop = [];
    end
end

system('C:/Users/PaulLouis/Documents/0Louis_doc/Louis_GT/GRA/SAT/minisat+/minisat+_64-bit_static sat_total.opb > result.txt');
[CRT,A,sat_status,sat_cputime]=readSATresult('result.txt',toDrop);

end
