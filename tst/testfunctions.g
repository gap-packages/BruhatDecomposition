#
# BruhatDecomposition: Computes the Bruhat Decomposition of matrices of the classical groups.
#
# Shared machinery for the tests. Every function here returns a list of
# strings describing what went wrong, empty if nothing did, so that a test
# file can just compare against [].
#
LoadPackage( "BruhatDecomposition" );

# One family of classical groups: how to build the LGO standard generators,
# which decomposition to apply, and which d and q it is defined for.
BruhatFamilies :=
[
  rec( name := "SL",
       gens := function(d,q) return LGOStandardGensSL(d,q); end,
       decomp := BruhatDecompositionSL,
       ok := function(d,q) return d >= 6; end ),
  rec( name := "SL (NC)",
       gens := function(d,q) return LGOStandardGensSL(d,q); end,
       decomp := BruhatDecompositionSLNC,
       ok := function(d,q) return d >= 6; end ),
  rec( name := "SL (WithTi)",
       gens := function(d,q) return LGOStandardGensSL(d,q); end,
       decomp := BruhatDecompositionSLWithTi,
       ok := function(d,q) return d >= 6; end ),
  rec( name := "SL (WithTi, NC)",
       gens := function(d,q) return LGOStandardGensSL(d,q); end,
       decomp := BruhatDecompositionSLWithTiNC,
       ok := function(d,q) return d >= 6; end ),
  rec( name := "Sp",
       gens := function(d,q) return LGOStandardGensSp(d,q); end,
       decomp := BruhatDecompositionSp,
       ok := function(d,q) return d >= 6 and IsEvenInt(d); end ),
  rec( name := "SU",
       gens := function(d,q) return LGOStandardGensSU(d,q); end,
       decomp := BruhatDecompositionSU,
       ok := function(d,q) return d >= 6; end ),
  rec( name := "SO+",
       gens := function(d,q) return LGOStandardGensSO(1,d,q); end,
       decomp := BruhatDecompositionSO,
       ok := function(d,q) return d >= 6 and IsEvenInt(d) and IsOddInt(q); end ),
  rec( name := "SO0",
       gens := function(d,q) return LGOStandardGensSO(0,d,q); end,
       decomp := BruhatDecompositionSO,
       ok := function(d,q) return d >= 7 and IsOddInt(d) and IsOddInt(q); end ),
  rec( name := "SO-",
       gens := function(d,q) return LGOStandardGensSO(-1,d,q); end,
       decomp := BruhatDecompositionSOMinus,
       ok := function(d,q) return d >= 8 and IsEvenInt(d) and IsOddInt(q); end ),
];

# Decompose g and check both halves of the promise: the SLP evaluates to
# u1, u2, p_sign, diag with u1^-1 p_sign diag u2^-1 = g, and the matrices
# returned alongside it are those same four.
BruhatCheckElement := function( fam, stdgens, g, label )
    local res, mats, slp, breakOnError;

    # An error in the decomposition is a test failure, not a reason to drop
    # into the break loop and hang a batch run.
    breakOnError := BreakOnError;
    BreakOnError := false;
    res := CALL_WITH_CATCH( fam.decomp, [ stdgens, g ] );
    BreakOnError := breakOnError;
    if not res[1] then
        return [ Concatenation( label, ": the decomposition raised an error" ) ];
    fi;
    res := res[2];
    if res[1] = fail then
        return [ Concatenation( label, ": no SLP was built" ) ];
    fi;

    mats := res[2];
    slp := ResultOfStraightLineProgram( res[1], stdgens );
    if slp[1]^-1 * slp[3] * slp[4] * slp[2]^-1 <> g then
        return [ Concatenation( label, ": the SLP does not reproduce g" ) ];
    fi;
    if slp{[1..4]} <> mats{[1..4]} then
        return [ Concatenation( label, ": the returned matrices differ from the SLP result" ) ];
    fi;
    return [];
end;

# True if calling func with args raises an error, which is what every one of
# these functions is supposed to do on input it cannot use.
BruhatRejects := function( func, args )
    local res, breakOnError, errorOutput;

    breakOnError := BreakOnError;
    BreakOnError := false;
    # The error message is the point of the call, not something to print.
    MakeReadWriteGlobal( "ERROR_OUTPUT" );
    errorOutput := ERROR_OUTPUT;
    ERROR_OUTPUT := OutputTextString( "", false );
    res := CALL_WITH_CATCH( func, args );
    ERROR_OUTPUT := errorOutput;
    MakeReadOnlyGlobal( "ERROR_OUTPUT" );
    BreakOnError := breakOnError;
    return not res[1];
end;

# Monomial elements, which take a different path through the decomposition
# than a generic one: products of the monomial standard generators. Searching
# for them at random is hopeless, they are a vanishing fraction of the group.
BruhatMonomialElements := function( stdgens )
    local mon, out, a, b, g;

    mon := Filtered( stdgens, TestIfMonomial );
    out := ShallowCopy( mon );
    for a in mon do
        for b in mon do
            g := a*b;
            if TestIfMonomial(g) and not g in out then
                Add( out, g );
            fi;
        od;
    od;
    return out;
end;

# All of one family over one group: the identity, the monomial elements, and
# nrand pseudo-random ones.
BruhatCheckGroup := function( fam, d, q, nrand )
    local stdgens, G, problems, tag, i, g;

    stdgens := fam.gens( d, q );
    G := Group( stdgens );
    problems := [];
    tag := Concatenation( fam.name, "(", String(d), ",", String(q), ")" );

    Append( problems, BruhatCheckElement( fam, stdgens, One(G),
                                          Concatenation(tag, " identity") ) );
    for g in BruhatMonomialElements( stdgens ) do
        Append( problems, BruhatCheckElement( fam, stdgens, g,
                                              Concatenation(tag, " monomial") ) );
    od;
    for i in [ 1 .. nrand ] do
        g := PseudoRandom( G );
        Append( problems, BruhatCheckElement( fam, stdgens, g,
                                              Concatenation(tag, " random") ) );
    od;
    return problems;
end;

# Every family over every dimension in dims and field size in qs it is
# defined for. Pass verbose := true to see progress on a long run.
BruhatTest := function( dims, qs, nrand, verbose )
    local problems, fam, d, q;

    problems := [];
    for fam in BruhatFamilies do
        for d in dims do
            for q in qs do
                if fam.ok( d, q ) then
                    if verbose then
                        Print( fam.name, "(", d, ",", q, ")\n" );
                    fi;
                    Append( problems, BruhatCheckGroup( fam, d, q, nrand ) );
                fi;
            od;
        od;
    od;
    return problems;
end;
