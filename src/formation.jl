"""
    $(SIGNATURES)

Calculate the ΔG'⁰ of formation for all `mets`, as well as the covariance matrix of the
errors.

# Example
```
equilibrator = Equilibrator()

mets = bigg.(["atp", "adp", "amp", "pi", "h2o"])

standard_dgf_prime_mu, standard_dgf_cov = standard_dg_formation(eq, mets)
```
"""
function standard_dg_formation(equilibrator::Equilibrator, mets::Vector{String})

    pymets = [equilibrator.cc.get_compound(cname) for cname in mets]

    met_formations = [equilibrator.cc.standard_dg_formation(met) for met in pymets]
    dgs = [met_formation[1] for met_formation in met_formations]

    sigmas_fin = hcat([met_formation[2] for met_formation in met_formations]...)
    sigmas_inf = hcat([met_formation[3] for met_formation in met_formations]...)

    leg_trans = [
        pymet.transform(
            equilibrator.cc.p_h,
            equilibrator.cc.ionic_strength,
            equilibrator.cc.temperature,
            equilibrator.cc.p_mg,
        ).m_as(
            "kJ/mol",
        ) for pymet in pymets
    ]

    standard_dgf_prime_mu = dgs + leg_trans
    standard_dgf_cov = sigmas_fin' * sigmas_fin + 1e6 .* sigmas_inf' * sigmas_inf

    return (standard_dgf_prime_mu)u"kJ/mol", (standard_dgf_cov)u"kJ/mol"
end
