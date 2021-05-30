"""
dg_prime(sys, rxn_string; concentrations=Dict{String, Any}())

Get ΔG' of a reaction described by `rxn_string` using the settings in `sys`.
Optionally, set the concentrations (abundances) of the species involved in the reaction
through `concentration`.

# Example
```
```
"""
function dg_prime(sys, rxn_string; concentrations=Dict{String, Any}(), balance_warn=true)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
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
physiological_dg_prime(sys, rxn_string; balance_warn=true)

"""
function physiological_dg_prime(sys, rxn_string; balance_warn=true)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
    end
    
    pydg = sys.cc.physiological_dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end

"""
(sys, rxn_string; balance_warn=true)

"""
function standard_dg_prime(sys, rxn_string; balance_warn=true)
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    
    if balance_warn && !rxn.is_balanced()
        @warn "Reaction unbalanced."
    end
    
    pydg = sys.cc.physiological_dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end
