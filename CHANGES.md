This file describes changes in the BruhatDecomposition package.

## Unreleased

- Fix `BruhatDecomposition` not recognising elements of SU and SO given by the
  package's own standard generators, so these were treated as SL (#26, #29)
- Fix `UnitriangularDecompositionSU` and `DiagSLPSU`, which never worked, and
  dispatch them to the even characteristic variants
- Fix several bugs in the SU and SO decompositions: errors for already monomial
  or diagonal input (#14), errors for elements of SU over a proper subfield, and
  a wrong sign in the monomial part for SO of circle type
- Fix the dimension checks in `LGOStandardGensSO`; minus type in dimension 6
  returned wrong generators
- Accept a field instead of a field size in `LGOStandardGensSp` and
  `LGOStandardGensSpEvenChar` (#22)
- Remove `LGOStandardGensSLNC`, `MyPermutationMat`, `MyPermutationMatNC` and
  `MakePermutationMat` (#21)
- Require GAP >= 4.10

## 0.1 (2024-03-12)

- Initial release
