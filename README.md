# The GAP package BruhatDecomposition

## Introduction

This package can be used to compute the Bruhat decomposition of elements in their natural representation in classical groups. Moreover, the elements can also be expressed as words in specific generators, namely the Leedham-Green and O'Brien generators, as MSLPs.

## Installation

 * unpack `BruhatDecomposition-<version_number>.zip` in the `pkg` subdirectory of the GAP root directory.
 * From within GAP load the package with:

        gap> LoadPackage("BruhatDecomposition");
        true

 * The file manual.pdf is in the `doc` subdirectory.

## Tests

From the package directory:

    gap tst/testall.g       # a few seconds, every family over small groups
    gap tst/testallmain.g   # several minutes, many dimensions and field sizes

Both check that the straight-line program and the matrices returned by each
decomposition reproduce the input. The parameters of the thorough run can be
set beforehand, e.g.

    gap -c 'BruhatTestDims := [6..9];; BruhatTestRandomElements := 10;;' tst/testallmain.g

## Contact

If you have a question relating to `BruhatDecomposition`, encounter any problems, or have a suggestion for extending the package in any way, please
 * email: <daniel.rademacher@rwth-aachen.de>
 * or report an issue at: [issue tracker](https://github.com/gap-packages/BruhatDecomposition/issues)

## License

`BruhatDecomposition` is free software you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

For details, see <https://www.gnu.org/licenses/gpl.html>.
