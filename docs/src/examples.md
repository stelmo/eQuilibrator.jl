# Example usage

The following examples follow closely the [example usage](https://equilibrator.readthedocs.io/en/latest/equilibrator_examples.html#Code-examples) 
documented in `equilibrator_api`. Try running these examples!

# Basic ΔG' calculations
Load `eQuilibrator.jl` and `Unitful`. Then initialize the thermodynamic `system` as shown below.
```
using eQuilibrator
using Unitful

temp = 30u"°C"
i_strength = 150.0u"mM"
ph=7.9
pmg = 2.0

system = eQuilibrator.System(pH=ph, pMg=pmg, temperature=temp, ionic_strength=i_strength)
```
!!! note "Take care of units"
    Units for temperature and ionic strength are required (pH and pMg are
    unitless floats). However, any suitable unit may be used, they are internally
    converted into Kelvin and molar respectively.

!!! warning "Variable names"
    While it is tempting to name a variable `temperature` or `ionic_strength`,
    these are exported functions and will be over-written if you assigned that
    name to a variable.

It is possible to change the state of the system after initialization.
```
temperature(system, 298.15u"K")
ionic_strength(system, 0.25u"M")
pH(system, 7.4)
pMg(system, 3.0)
```

It is necessary to supply a reaction string.
```
rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
```

After specifying the reaction string, it is a simple matter of calling the appropriate function 
to get the ΔG values. 
```
physiological_dg_prime(system, rxn_string)

standard_dg_prime(system, rxn_string)

concens = Dict("bigg.metabolite:atp"=>1u"mM", "bigg.metabolite:adp"=>100u"μM", "bigg.metabolite:pi"=>0.005u"M")
dg_prime(system, rxn_string; concentrations=concens)

ln_reversibility_index(system, rxn_string)
```
!!! tip "Errors are shown using `Measurements.jl`
    [eQuilibrator](https://equilibrator.weizmann.ac.il/static/classic_rxns/faq.html#how-do-you-calculate-the-uncertainty-for-each-estimation) 
    supplies estimates with uncertainties, these are reflected by the use of `a ± b` with `b` being the uncertainty, assumed to be
    one standard deviation here.
