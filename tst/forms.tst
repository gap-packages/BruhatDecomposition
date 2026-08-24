#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# What the LGO standard generators actually generate. GAP's classical groups
# use a different form, so this needs the forms package to bridge the two;
# without it BruhatGensLieIn passes and these checks say nothing.
#
gap> START_TEST("forms.tst");
gap> Read(Filename(DirectoriesPackageLibrary("BruhatDecomposition","tst"),
>                  "testfunctions.g"));

# SL needs no bridge, it is written in the same basis as GAP's.
gap> ForAll( [ [6,5], [7,4], [8,2] ],
>            p -> IsSubset( SL(p[1],p[2]), LGOStandardGensSL(p[1],p[2]) ) );
true

# Sp and SU, in both characteristics.
gap> BruhatGensLieIn( LGOStandardGensSp(8,5), Sp(8,5) );
true
gap> BruhatGensLieIn( LGOStandardGensSp(8,4), Sp(8,4) );
true
gap> BruhatGensLieIn( LGOStandardGensSU(8,5), SU(8,5) );
true
gap> BruhatGensLieIn( LGOStandardGensSU(7,4), SU(7,4) );
true

# SO, all three types.
gap> BruhatGensLieIn( LGOStandardGensSO(1,8,5), SO(1,8,5) );
true
gap> BruhatGensLieIn( LGOStandardGensSO(0,7,5), SO(0,7,5) );
true
gap> BruhatGensLieIn( LGOStandardGensSO(-1,8,5), SO(-1,8,5) );
true

# Omega, where it is right: plus type in either characteristic, and minus
# type in even characteristic.
gap> BruhatGensLieIn( LGOStandardGensOmega(1,6,3), Omega(1,6,3) );
true
gap> BruhatGensLieIn( LGOStandardGensOmega(1,6,4), Omega(1,6,4) );
true
gap> BruhatGensLieIn( LGOStandardGensOmega(-1,8,2), Omega(-1,8,2) );
true
gap> BruhatGensLieIn( LGOStandardGensOmega(-1,8,4), Omega(-1,8,4) );
true

# Omega, where it is not: in odd characteristic circle and minus type return
# generators that lie in GO but not in SO, one of them having determinant -1.
# All that can be asserted here is the GO part. See issue #25.
gap> ForAll( [ [0,7,3], [0,9,3], [-1,8,3], [-1,8,5] ],
>            p -> BruhatGensLieIn( LGOStandardGensOmega(p[1],p[2],p[3]),
>                                  GO(p[1],p[2],p[3]) ) );
true

#
gap> STOP_TEST("forms.tst");
