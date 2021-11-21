"""
    $(SIGNATURES)

Calculate ΔG' of a reaction described by `rxn_string` using the settings in
`equilibrator`. Optionally, set the concentrations (abundances) of the species involved
in the reaction through `concentration`. If `skip_unbalanced` is true then
return `nothing` if the reaction is unbalanced. If `balance_warn` is false
then do not emit a warning when the reaction is unbalanced. Note, concentrations
that are smaller than 0.001 mM are capped at 0.001 mM (an eQuilibrator/equilibrator_api)
restriction.

# Example
```
equilibrator = Equilibrator()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
concens = Dict("bigg.metabolite:atp"=>1u"mM", "bigg.metabolite:adp"=>100u"μM", "bigg.metabolite:pi"=>0.003u"M")
dg_prime(equilibrator, rxn_string; concentrations=concens)
```
"""
function dg_prime(
    equilibrator::Equilibrator,
    rxn_string::String;
    concentrations = Dict{String,Real}(),
    balance_warn = true,
    skip_unbalanced = false,
)
    rxn = equilibrator.cc.parse_reaction_formula(rxn_string)

    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end

    for (k, v) in concentrations
        val = uconvert(u"M", _lower_bound(float(v)))
        rxn.set_abundance(equilibrator.cc.get_compound(k), equilibrator.eq.Q_(string(val)))
    end
    pydg = equilibrator.cc.dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
    $(SIGNATURES)

Calculate ΔG' at physiological conditions (all concentrations set to 1 mM, 1mbar) of a reaction
described by `rxn_string` using the settings in `equilibrator`. If `skip_unbalanced` is true
then return `nothing` if the reaction is unbalanced. If `balance_warn` is false then do not
emit a warning when the reaction is unbalanced.

# Example
```
equilibrator = Equilibrator()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
physiological_dg_prime(equilibrator, rxn_string)
```
"""
function physiological_dg_prime(
    equilibrator::Equilibrator,
    rxn_string::String;
    balance_warn = true,
    skip_unbalanced = false,
)
    rxn = equilibrator.cc.parse_reaction_formula(rxn_string)

    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end

    pydg = equilibrator.cc.physiological_dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
    $(SIGNATURES)

Calculate ΔG⁰ at standard conditons of a reaction described by `rxn_string` using
the settings in `equilibrator`. If `skip_unbalanced` is true then return `nothing` if the
reaction is unbalanced. If `balance_warn` is false then do not emit a warning
when the reaction is unbalanced.

Note, standard conditions means that all concentrations are set at 1 M.

# Example
```
equilibrator = Equilibrator()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
standard_dg_prime(equilibrator, rxn_string)
```
"""
function standard_dg_prime(
    equilibrator::Equilibrator,
    rxn_string::String;
    balance_warn = true,
    skip_unbalanced = false,
)
    rxn = equilibrator.cc.parse_reaction_formula(rxn_string)

    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end

    pydg = equilibrator.cc.standard_dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
    $(SIGNATURES)

Calculate the log of the reversibility index of a reaction described by `rxn_string`
using settings in `equilibrator`. If `skip_unbalanced` is true then return `nothing` if the reaction is
unbalanced. If `balance_warn` is false then do not emit a warning when the
reaction is unbalanced.

# Example
```
equilibrator = Equilibrator()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
ln_reversibility_index(equilibrator, rxn_string)
```
"""
function ln_reversibility_index(
    equilibrator::Equilibrator,
    rxn_string::String;
    balance_warn = true,
    skip_unbalanced = false,
)
    rxn = equilibrator.cc.parse_reaction_formula(rxn_string)

    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end

    rev_obj = equilibrator.cc.ln_reversibility_index(rxn)
    return rev_obj.value.magnitude ± rev_obj.error.magnitude
end
