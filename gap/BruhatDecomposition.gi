######################################
# BruhatDecomposition.gi
######################################

#####
# BruhatDecomposition()
#####

InstallGlobalFunction(  BruhatDecomposition,
function(g)

    local d, fld, q;

    d := NrRows( g );
    fld := FieldOfMatrixList( [g] );
    q := Size(fld);

    if d <= 6 then
        Print("This code tries to predict to which classical group g belongs. \n ");
        Print("Since d is smaller or equal than 6, \n some classical groups are isomorphic to each other and \n the wrong subfunction may be called. \n ");
        Print("To make sure that the correct subfunction is used, \n please call it directly. \n");
        Print("\n");
    fi;

    if IsEvenInt(d) then
        if g in Sp(d,q) then
            Print("Element g in contained in Sp(", d, ", ", q, ") \n");
            return BruhatDecompositionSp(LGOStandardGensSp(d,fld),g);
        elif g in SU(d,q) then
            Print("Element g in contained in SU(", d, ", ", q, ") \n");
            return BruhatDecompositionSU(LGOStandardGensSU(d,q),g);
        elif g in SO(1,d,q) then
            Print("Element g in contained in SO(+, ", d, ", ", q, ") \n");
            return BruhatDecompositionSO(LGOStandardGensSO(1,d,q),g);
        elif g in SO(-1,d,q) then
            Print("Element g in contained in SO(-, ", d, ", ", q, ") \n");
            return BruhatDecompositionSO(LGOStandardGensSO(-1,d,q),g);
        elif g in SL(d,q) then
            Print("Element g in contained in SL(", d, ", ", q, ") \n");
            return BruhatDecompositionSL(LGOStandardGensSL(d,q),g);
        else
            Print("The element g is not an element of one of the classical groups in their natural representation. \n");
            Print("Abort.");
        fi;
    else
        if g in SU(d,q) then
            Print("Element g in contained in SU(", d, ", ", q, ") \n");
            return BruhatDecompositionSU(LGOStandardGensSU(d,q),g);
        elif g in SO(0,d,q) then
            Print("Element g in contained in Sp(o, ", d, ", ", q, ") \n");
            return BruhatDecompositionSO(LGOStandardGensSO(0,d,q),g);
        elif g in SL(d,q) then
            Print("Element g in contained in SL(", d, ", ", q, ") \n");
            return BruhatDecompositionSL(LGOStandardGensSL(d,q),g);
        else
            Print("The element g is not an element of one of the classical groups in their natural representation. \n");
            Print("Abort.");
        fi;
    fi;

end);
