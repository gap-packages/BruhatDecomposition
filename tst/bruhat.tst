#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# The fast test suite: every family, small dimensions, small fields. For a
# thorough run use tst/testallmain.g.
#
gap> START_TEST("bruhat.tst");
gap> Read(Filename(DirectoriesPackageLibrary("BruhatDecomposition","tst"),
>                  "testfunctions.g"));
gap> SetInfoLevel(InfoBruhat, 0);

# Every family, over every dimension and field size below that it accepts.
# Each group is checked on the identity, on its monomial elements and on
# three random ones.
gap> BruhatTest([6..9], [2,3,4,5], 3, false);
[  ]

# One larger field per family, where the standard generators involve a
# primitive element that is not in the prime field.
gap> BruhatTest([6..9], [9,25], 2, false);
[  ]

# Issue #14. Both matrices are monomial, so they take the shortcut through
# the unitriangular decomposition, and both are below the dimensions the
# sweep above covers.
gap> fam := First(BruhatFamilies, f -> f.name = "Sp");;
gap> m := [[0,0,1,0],[1,0,0,0],[0,0,0,1],[0,1,0,0]]*Z(2);;
gap> BruhatCheckElement(fam, LGOStandardGensSpEvenChar(4,2), m, "issue14");
[  ]
gap> m := [[0,0,0,1,0,0],[1,0,0,0,0,0],[0,1,0,0,0,0],
>          [0,0,0,0,1,0],[0,0,0,0,0,1],[0,0,1,0,0,0]]*Z(2);;
gap> BruhatCheckElement(fam, LGOStandardGensSpEvenChar(6,2), m, "issue14");
[  ]

# The generic entry point picks the right family.
gap> g := PseudoRandom(Group(LGOStandardGensSp(8,5)));;
gap> res := BruhatDecomposition(g);;
Element g in contained in Sp(8, 5) 
gap> res[2][1]^-1 * res[2][3] * res[2][4] * res[2][2]^-1 = g;
true

#
gap> STOP_TEST("bruhat.tst");
