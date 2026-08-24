######################################
# BruhatDecomposition.gi
######################################

#####
# Deciding which classical group g belongs to
#####
#
# The LGO standard generators are written with respect to a different form
# than GAP's Sp, SU and SO, so membership in those groups says nothing about
# whether the corresponding decomposition applies. These test the LGO form
# instead. SL needs no such test, it is the same group either way.
#
# The field is whatever the entries of g span, which is all a single matrix
# offers: an element that happens to have all its entries in a proper
# subfield is treated as living over that subfield.

#####
# __BruhatIsSymplectic()
#####

BindGlobal( "__BruhatIsSymplectic",
function( g, fld )
    local d, J, k;

    d := NrRows( g );

    if IsOddInt( d ) then
        return false;
    fi;

    # The LGO form, antidiagonal with 1 above and -1 below the middle.
    J := NullMat( d, d, fld );
    for k in [ 1 .. d/2 ] do
        J[k,d-k+1] := One( fld );
        J[d-k+1,k] := -One( fld );
    od;

    return g * J * TransposedMat( g ) = J;
end );

#####
# __BruhatIsUnitary()
#####

BindGlobal( "__BruhatIsUnitary",
function( g, fld )
    local d, q, J, k, conjugate;

    # A hermitian form needs a subfield of index 2 to conjugate over.
    if not IsEvenInt( DegreeOverPrimeField( fld ) ) then
        return false;
    fi;

    d := NrRows( g );
    q := RootInt( Size( fld ) );

    J := NullMat( d, d, fld );
    for k in [ 1 .. d ] do
        J[k,d-k+1] := One( fld );
    od;

    conjugate := List( g, row -> List( row, x -> x^q ) );

    return g * J * TransposedMat( conjugate ) = J
           and DeterminantMat( g ) = One( fld );
end );


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
        if __BruhatIsSymplectic(g,fld) then
            Print("Element g in contained in Sp(", d, ", ", q, ") \n");
            return BruhatDecompositionSp(LGOStandardGensSp(d,fld),g);
        elif __BruhatIsUnitary(g,fld) then
            Print("Element g in contained in SU(", d, ", ", RootInt(q), ") \n");
            return BruhatDecompositionSU(LGOStandardGensSU(d,RootInt(q)),g);
        elif IsOddInt(q) and d >= 6 and g in MSO(1,d,fld) then
            Print("Element g in contained in SO(+, ", d, ", ", q, ") \n");
            return BruhatDecompositionSO(LGOStandardGensSO(1,d,q),g);
        elif IsOddInt(q) and d >= 8 and g in MSO(-1,d,fld) then
            Print("Element g in contained in SO(-, ", d, ", ", q, ") \n");
            return BruhatDecompositionSOMinus(LGOStandardGensSO(-1,d,q),g);
        elif g in SL(d,q) then
            Print("Element g in contained in SL(", d, ", ", q, ") \n");
            return BruhatDecompositionSL(LGOStandardGensSL(d,q),g);
        else
            Print("The element g is not an element of one of the classical groups in their natural representation. \n");
            Print("Abort.");
        fi;
    else
        if __BruhatIsUnitary(g,fld) then
            Print("Element g in contained in SU(", d, ", ", RootInt(q), ") \n");
            return BruhatDecompositionSU(LGOStandardGensSU(d,RootInt(q)),g);
        elif IsOddInt(q) and d >= 7 and g in MSO(0,d,fld) then
            Print("Element g in contained in SO(o, ", d, ", ", q, ") \n");
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
