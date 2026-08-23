#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
# For a far more thorough run, see tst/testallmain.g.
#
LoadPackage( "BruhatDecomposition" );

TestDirectory(DirectoriesPackageLibrary( "BruhatDecomposition", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
