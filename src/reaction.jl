"""
    dg_prime(sys, rxn_string; concentrations=Dict{String, Any}(), skip_unbalanced=false, balance_warn=true)

Calculate ΔG' of a reaction described by `rxn_string` using the settings in
`sys`. Optionally, set the concentrations (abundances) of the species involved
in the reaction through `concentration`. If `skip_unbalanced` is true then
return `nothing` if the reaction is unbalanced. If `balance_warn` is false
then do not emit a warning when the reaction is unbalanced.

# Example
```
sys = System()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
concens = Dict("bigg.metabolite:atp"=>1u"mM", "bigg.metabolite:adp"=>100u"μM", "bigg.metabolite:pi"=>0.003u"M")
dg_prime(sys, rxn_string; concentrations=concens)
```
"""
function dg_prime(sys, rxn_string; concentrations=Dict{String, Any}(), balance_warn=true, skip_unbalanced=false)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        balance_warn && @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end

    for (k, v) in concentrations
        val = uconvert(u"M", float(v))
        rxn.set_abundance(sys.cc.get_compound(k), sys.eq.Q_(string(val)))
    end
    pydg = sys.cc.dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
    physiological_dg_prime(sys, rxn_string; balance_warn=true, skip_unbalanced=false)

Calculate ΔG' at physiological conditions of a reaction described by
`rxn_string` using the settings in `sys`. If `skip_unbalanced` is true then
return `nothing` if the reaction is unbalanced. If `balance_warn` is false
then do not emit a warning when the reaction is unbalanced.

# Example
```
sys = System()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
physiological_dg_prime(sys, rxn_string)
```
"""
function physiological_dg_prime(sys, rxn_string; balance_warn=true, skip_unbalanced=false)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        balance_warn && @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end
    
    pydg = sys.cc.physiological_dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
    standard_dg_prime(sys, rxn_string; balance_warn=true, skip_unbalanced=false)

Calculate ΔG⁰ at standard conditons of a reaction described by `rxn_string` using
the settings in `sys`. If `skip_unbalanced` is true then return `nothing` if the
reaction is unbalanced. If `balance_warn` is false then do not emit a warning
when the reaction is unbalanced.

Note, standard conditions means that all concentrations are set at 1 M. 

# Example
```
sys = System()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
standard_dg_prime(sys, rxn_string)
```
"""
function standard_dg_prime(sys, rxn_string; balance_warn=true, skip_unbalanced=false)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        balance_warn && @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end
    
    pydg = sys.cc.standard_dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
    ln_reversibility_index(sys, rxn_string; balance_warn=true, skip_unbalanced=false)

Calculate the log of the reversibility index of a reaction described by `rxn_string`
using settings in `sys`. If `skip_unbalanced` is true then return `nothing` if the reaction is
unbalanced. If `balance_warn` is false then do not emit a warning when the
reaction is unbalanced.

# Example
```
sys = System()

rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
ln_reversibility_index(sys, rxn_string)
```
"""
function ln_reversibility_index(sys, rxn_string; balance_warn=true, skip_unbalanced=false)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        balance_warn && @warn "Reaction unbalanced."
        skip_unbalanced && return nothing
    end

    rev_obj = sys.cc.ln_reversibility_index(rxn)
    return rev_obj.value.magnitude ± rev_obj.error.magnitude
end