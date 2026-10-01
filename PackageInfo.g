#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(
PackageName := "BruhatDecomposition",
Subtitle := "Computes the Bruhat decomposition of matrices in classical groups.",
Version := "0.1",
Date := "12/03/2024", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Daniel",
    LastName := "Rademacher",
    #WWWHome := TODO,
    Email := "rademacher@art.rwth-aachen.de",
    IsAuthor := true,
    IsMaintainer := false,
    PostalAddress := Concatenation(
               "Daniel Rademacher\n",
               "Chair of Algebra and Representation Theory\n",
               "RWTH Aachen\n",
               "Pontdriesch 10/16\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "Chair of Algebra and Representation Theory, RWTH Aachen",
  ),
  rec(
    FirstNames := "Alice",
    LastName := "Niemeyer",
    WWWHome := "http://www.math.rwth-aachen.de/~Alice.Niemeyer/",
    Email := "alice.niemeyer@mathb.rwth-aachen.de",
    IsAuthor := true,
    IsMaintainer := false,
    PostalAddress := Concatenation(
               "Alice Niemeyer\n",
               "Chair of Algebra and Representation Theory\n",
               "RWTH Aachen\n",
               "Pontdriesch 10/16\n",
               "52062 Aachen\n",
               "Germany" ),
    Place := "Aachen",
    Institution := "Chair of Algebra and Representation Theory, RWTH Aachen",
  ),
  rec(
    LastName      := "Horn",
    FirstNames    := "Max",
    IsAuthor      := false,
    IsMaintainer  := true,
    Email         := "mhorn@rptu.de",
    WWWHome       := "https://www.quendi.de/math",
    GitHubUsername:= "fingolfin",
    PostalAddress := Concatenation(
                       "Fachbereich Mathematik\n",
                       "RPTU Kaiserslautern-Landau\n",
                       "Gottlieb-Daimler-Straße 48\n",
                       "67663 Kaiserslautern\n",
                       "Germany" ),
    Place         := "Kaiserslautern, Germany",
    Institution   := "RPTU Kaiserslautern-Landau"
  ),
],

SourceRepository := rec( Type := "git", URL := "https://github.com/gap-packages/BruhatDecomposition" ),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome := "https://github.com/gap-packages/BruhatDecomposition",
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL     := Concatenation( ~.PackageWWWHome,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := ~.PackageName,
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := ~.Subtitle,
),

Dependencies := rec(
  GAP := ">= 4.10",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ ],
  TestPackages := [ [ "forms", ">= 1.2" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
