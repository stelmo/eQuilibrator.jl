"""
    $(SIGNATURES)

Calculate ΔG'⁰ for each `rxn_string` in `rxn_strings`. The `uncertainty_representation` can
be either `fullrank`, `cov`, or `sqrt`, and is used to represent the uncertainties. Specifically,
`cov` returns a full covariance matrix, `precision` returna the precision matrix (i.e.
the inverse of the covariance matrix), `sqrt` returns the square root of the covariance,
based on the uncertainty vectors, and `fullrank` returns a full-rank square root of the
covariance that is a compressed form of the sqrt result. If `minimize_norm` is  `true`,
an orthogonal projection is used to minimize the Euclidian norm of the result vector. If
`balance_warn` is true, emit a warning if any reaction is unbalanced, if `skip_unbalanced`
is true, return `nothing` if an unbalanced reaction is found.

# Example
```
equilibrator = Equilibrator()

ntp3 = "gtp + h2o = gdp + pi"
adk3 = "adp + gdp = amp + gtp"

μ, Q = standard_dg_prime_multi(eq, bigg.([ntp3, adk3]); uncertainty_representation="fullrank")
```
"""
function standard_dg_prime_multi(
    equilibrator::Equilibrator,
    rxn_strings::Vector{String};
    balance_warn = true,
    skip_unbalanced = false,
    uncertainty_representation = "cov",
    minimize_norm = false,
)
    rxns =
        [equilibrator.cc.parse_reaction_formula(rxn_string) for rxn_string in rxn_strings]

    if balance_warn && any(!rxn.is_balanced() for rxn in rxns)
        for (k, rxn) in enumerate(rxns)
            if !rxn.is_balanced
                @warn "Reaction at index $k is unbalanced."
            end
        end
        skip_unbalanced && return nothing
    end

    pymeans, pyQ = equilibrator.cc.standard_dg_prime_multi(
        rxns,
        uncertainty_representation = uncertainty_representation,
        minimize_norm = minimize_norm,
    )

    if uncertainty_representation == "cov"
        Q = pyQ.m_as("kJ^2/mol^2")u"kJ^2/mol^2"
    elseif uncertainty_representation == "fullrank"
        Q = pyQ.m_as("kJ/mol")u"kJ/mol"
    elseif uncertainty_representation == "precision"
        Q = pyQ.m_as("mol/kJ")u"mol/kJ"
    elseif uncertainty_representation == "sqrt"
        Q = pyQ.m_as("kJ/mol")u"kJ/mol"
    end
    return pymeans.m_as("kJ/mol")u"kJ/mol", Q
end
