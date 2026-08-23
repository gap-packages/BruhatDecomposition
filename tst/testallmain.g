#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# The thorough test suite, over many dimensions and field sizes. It runs for
# a long time; the fast one is tst/bruhat.tst, which is what `make test` and
# the CI test job use.
#
# This file is a script and quits GAP when it is done:
#
#     gap tst/testallmain.g
#
# The three parameters can be set beforehand to run something in between,
#
#     gap -c 'BruhatTestDims := [6..9];; BruhatTestRandomElements := 10;;' tst/testallmain.g
#
# To use the checks interactively instead, read tst/testfunctions.g and call
# BruhatTest or BruhatCheckGroup yourself.
#
Read(Filename(DirectoriesPackageLibrary("BruhatDecomposition","tst"),
              "testfunctions.g"));

if not IsBound( BruhatTestDims ) then
    BruhatTestDims := [ 6 .. 13 ];
fi;
if not IsBound( BruhatTestFieldSizes ) then
    BruhatTestFieldSizes := [ 2, 4, 8, 16, 32, 3, 9, 27, 5, 25, 7, 49, 11, 13, 17, 121 ];
fi;
if not IsBound( BruhatTestRandomElements ) then
    BruhatTestRandomElements := 100;
fi;

SetInfoLevel( InfoBruhat, 0 );

BruhatTestProblems := BruhatTest( BruhatTestDims, BruhatTestFieldSizes,
                                  BruhatTestRandomElements, true );

if IsEmpty( BruhatTestProblems ) then
    Print( "Everything worked! Congrats!\n" );
    ForceQuitGap( true );
else
    Print( Length(BruhatTestProblems), " problems:\n" );
    for BruhatTestProblem in BruhatTestProblems do
        Print( "  ", BruhatTestProblem, "\n" );
    od;
    ForceQuitGap( false );
fi;
