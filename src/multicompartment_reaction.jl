"""
    $(SIGNATURES)

Calculate ΔG'⁰ for a multicompartment reaction. Assume that `equilibrator` corresponds to
the thermodynamic conditions of the inner reaction. The `potential_difference` across
the membrane, as well as the `pH_outer`, `pMg_outer`, and `ionic_strength_outer` can be set.
The `tolerance` sets the allowed imbalance between the `rxn_inner` and `rxn_outer`.

# Example
```
equilibrator = Equilibrator()

cyto_rxn = bigg("adp + pi + 2 h = h2o + atp")
peri_rxn = bigg(" = 2 h")

ψ = 0.17u"V"
peri_ionic = 0.2u"M"
peri_pMg = 3.0
peri_pH = 6.5

set_ionic_strength(eq, 250u"mM")
set_pH(eq, 7.4)
set_pMg(eq, 3.0)

dg = multi_compartmental_standard_dg_prime(
    eq,
    cyto_rxn,
    peri_rxn;
    e_potential_difference = ψ,
    pH_outer = peri_pH,
    pMg_outer = peri_pMg,
    ionic_strength_outer = peri_ionic,
    tolerance=2.0,
)
```
"""
function multi_compartmental_standard_dg_prime(
    equilibrator::Equilibrator,
    rxn_inner::String,
    rxn_outer::String;
    potential_difference = 0.2u"V",
    pH_outer = 7.0,
    pMg_outer = 3.0,
    ionic_strength_outer = 0.25u"M",
    tolerance=0.0,
)

    e_potential_difference = equilibrator.eq.Q_(string(uconvert(u"V", potential_difference)))

    outer_pH = equilibrator.eq.Q_(pH_outer)
    outer_pMg = equilibrator.eq.Q_(pMg_outer)
    outer_ionic_strength = equilibrator.eq.Q_(string(uconvert(u"M", float(ionic_strength_outer))))

    inner_rxn = equilibrator.cc.parse_reaction_formula(rxn_inner)
    outer_rxn = equilibrator.cc.parse_reaction_formula(rxn_outer)

    standard_dg_prime = equilibrator.cc.multicompartmental_standard_dg_prime(
        reaction_inner=inner_rxn,
        reaction_outer=outer_rxn,
        e_potential_difference=e_potential_difference,
        p_h_outer=outer_pH,
        ionic_strength_outer=outer_ionic_strength,
        p_mg_outer=outer_pMg,
        tolerance=tolerance,
    )

    return (standard_dg_prime.value.m_as("kJ/mol") ± standard_dg_prime.error.m_as("kJ/mol"))u"kJ/mol"
end
