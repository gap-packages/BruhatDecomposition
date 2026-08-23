#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# Corners the sweep in bruhat.tst does not reach: the input checking, the
# LGO standard generators for Omega, and the generic entry point.
#
gap> START_TEST("coverage.tst");
gap> Read(Filename(DirectoriesPackageLibrary("BruhatDecomposition","tst"),
>                  "testfunctions.g"));
gap> SetInfoLevel(InfoBruhat, 0);

# Dimensions the standard generators do not exist for, and a type that is
# neither plus, minus nor circle.
gap> ForAll( [ [LGOStandardGensSL, [2,5]], [LGOStandardGensSp, [4,5]],
>              [LGOStandardGensSU, [4,5]], [LGOStandardGensSO, [1,4,5]],
>              [LGOStandardGensSO, [-1,6,5]], [LGOStandardGensSO, [0,5,5]],
>              [LGOStandardGensSO, [2,8,5]], [LGOStandardGensOmega, [2,8,5]] ],
>            p -> BruhatRejects(p[1], p[2]) );
true

# Input that is not a pair of LGO standard generators and a matrix, and a
# third argument that is not a list of SLP lines.
gap> gens := LGOStandardGensSL(6,5);;
gap> sp := LGOStandardGensSp(6,5);;
gap> mat := IdentityMat(6,GF(5));;
gap> diag := DiagonalMat( [1,1,1,1,1,1] * Z(5)^0 );;
gap> takeMatrix := [ UnipotentDecomposition, UnipotentDecompositionNC,
>       UnipotentDecompositionWithTi, UnipotentDecompositionWithTiNC,
>       UnitriangularDecompositionSp, UnitriangularDecompositionSpEvenChar,
>       UnitriangularDecompositionSUEven, UnitriangularDecompositionSUEvenAndEvenChar,
>       UnitriangularDecompositionSUOdd, UnitriangularDecompositionSUOddAndEvenChar,
>       UnitriangularDecompositionSOPlus, UnitriangularDecompositionSOCircle,
>       UnitriangularDecompositionSOMinus,
>       PermSLP, PermSLPNC, MonomialSLPSp,
>       MonomialSLPSUEven, MonomialSLPSUEvenAndEvenChar,
>       MonomialSLPSUOdd, MonomialSLPSUOddAndEvenChar,
>       MonomialSLPSOPlus, MonomialSLPSOCircle, MonomialSLPSOMinus ];;
gap> ForAll( takeMatrix,
>            f -> ForAll( [ [], [1, mat], [gens, 1], [gens, mat, 1] ],
>                         a -> BruhatRejects(f, a) ) );
true
gap> takeDiagonal := [ DiagonalDecomposition, DiagonalDecompositionNC, DiagSLPSp,
>       DiagSLPSUEven, DiagSLPSUEvenAndEvenChar, DiagSLPSUOdd, DiagSLPSUOddAndEvenChar,
>       DiagSLPSOPlus, DiagSLPSOCircle, DiagSLPSOMinus ];;
gap> ForAll( takeDiagonal,
>            f -> ForAll( [ [], [1, diag], [gens, sp[1]], [gens, diag, 1] ],
>                         a -> BruhatRejects(f, a) ) );
true

# The LGO standard generators for Omega. Nothing else in the package uses
# them, so this is all the cover they get.
gap> gens := LGOStandardGensOmega(1,8,3);;
gap> Size( Group( gens ) ) = Size( Omega(1,8,3) );
true
gap> gens := LGOStandardGensOmega(1,6,4);;
gap> Size( Group( gens ) ) = Size( Omega(1,6,4) );
true
gap> gens := LGOStandardGensOmega(-1,8,2);;
gap> Size( Group( gens ) ) = Size( Omega(-1,8,2) );
true
gap> gens := LGOStandardGensOmega(0,7,4);;
gap> Size( Group( gens ) ) = Size( Omega(0,7,4) );
true

# Odd characteristic circle and minus type only get called, not checked:
# they return generators of SO rather than of Omega. See issue #25.
gap> ForAll( [ LGOStandardGensOmega(0,7,3), LGOStandardGensOmega(0,9,3),
>              LGOStandardGensOmega(-1,8,3), LGOStandardGensOmega(-1,8,5) ],
>            g -> ForAll( g, IsMatrix ) );
true

# The two SU dispatchers, which nothing else calls. Each has to reach all
# four variants: even and odd dimension, even and odd characteristic.
gap> CheckSUDispatch := function( d, q, mono, dia )
>     local stdgens, g, res, slp, w, diag;
>     stdgens := LGOStandardGensSU(d,q);
>     g := PseudoRandom( Group( stdgens ) );
>     res := UnitriangularDecompositionSU( stdgens, g );
>     if res[2][2]^-1 * res[2][1] * res[2][3]^-1 <> g then
>         return "wrong unitriangular decomposition";
>     fi;
>     slp := ShallowCopy( res[1] );
>     Remove( slp );
>     w := mono( stdgens, res[2][1], slp );
>     diag := w[2][2];
>     if DiagSLPSU( stdgens, diag, ShallowCopy(w[1]), res[3]+10 )
>        <> dia( stdgens, diag, ShallowCopy(w[1]), res[3]+10 ) then
>         return "DiagSLPSU dispatched to the wrong function";
>     fi;
>     return true;
> end;;
gap> CheckSUDispatch( 6, 3, MonomialSLPSUEven, DiagSLPSUEven );
true
gap> CheckSUDispatch( 7, 5, MonomialSLPSUOdd, DiagSLPSUOdd );
true
gap> CheckSUDispatch( 6, 4, MonomialSLPSUEvenAndEvenChar, DiagSLPSUEvenAndEvenChar );
true
gap> CheckSUDispatch( 7, 2, MonomialSLPSUOddAndEvenChar, DiagSLPSUOddAndEvenChar );
true
gap> BruhatRejects( DiagSLPSU, [] );
true

# CoefficientsPrimitiveElement over a field too big for the internal
# representation.
gap> fld := GF(3,20);;
gap> Size(fld) > MAXSIZE_GF_INTERNAL;
true
gap> c := CoefficientsPrimitiveElement( fld, PrimitiveRoot(fld) );;
gap> Sum( [1..Length(c)], i -> c[i] * PrimitiveRoot(fld)^0 * Z(3)^0 ) <> fail;
true

# The generic entry point, on the two families it does recognise. It decides
# by testing membership in GAP's own classical groups, which use a different
# form than the LGO standard generators, so SU and SO elements are announced
# and decomposed as SL. See issue #26.
gap> CheckGeneric := function( stdgens )
>     local g, res, m;
>     g := PseudoRandom( Group( stdgens ) );
>     res := BruhatDecomposition( g );
>     m := res[2];
>     return m[1]^-1 * m[3] * m[4] * m[2]^-1 = g;
> end;;
gap> CheckGeneric( LGOStandardGensSL(8,5) );
Element g in contained in SL(8, 5) 
true
gap> CheckGeneric( LGOStandardGensSL(9,5) );
Element g in contained in SL(9, 5) 
true
gap> CheckGeneric( LGOStandardGensSp(8,5) );
Element g in contained in Sp(8, 5) 
true
gap> CheckGeneric( LGOStandardGensSU(8,5) );
Element g in contained in SL(8, 25) 
true

# A matrix in none of them: the determinant is not 1.
gap> BruhatDecomposition( DiagonalMat( [ Z(5) ] + List([1..7], i -> Z(5)^0) ) );; Print("\n");
The element g is not an element of one of the classical groups in their natura\
l representation. 
Abort.

#
gap> STOP_TEST("coverage.tst");
