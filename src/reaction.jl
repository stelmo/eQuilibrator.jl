"""
dg_prime(sys, rxn_string; concentrations=Dict{String, Any}())

Get ΔG' of a reaction described by `rxn_string` using the settings in `sys`.
Optionally, set the concentrations (abundances) of the species involved in the reaction
through `concentration`.

# Example
```
```
"""
function dg_prime(sys, rxn_string; concentrations=Dict{String, Any}())
    rxn = sys.cc.parse_reaction_formula(rxn_string)
    bal = rxn.is_balanced()
    for (k, v) in concentrations
        _has_float_value(v, "species concentration")
        val = uconvert(u"M", v)
        rxn.set_abundance(sys.cc.get_compound(k), sys.eq.Q_(string(val)))
    end
    pydg = sys.cc.dg_prime(rxn)
    dg = pydg.value.magnitude ± pydg.error.magnitude
    units = uparse(_parse_units(py"str"(pydg.units)))
    return (dg)units
end
