# Example usage

The following examples follow closely the [example usage](https://equilibrator.readthedocs.io/en/latest/equilibrator_examples.html#)
documented in `equilibrator_api`. Try running these examples!

## Basic ΔG' calculations
Load `eQuilibrator.jl` and `Unitful`. Then initialize the thermodynamic `equilibrator` as shown below.
```
using eQuilibrator
using Unitful

temp = 30u"°C"
i_strength = 150.0u"mM"
ph = 7.9
pmg = 2.0

equilibrator = eQuilibrator.Equilibrator(pH=ph, pMg=pmg, temperature=temp, ionic_strength=i_strength)
```
!!! note "Take care of units"
    Units for temperature and ionic strength are required (pH and pMg are
    unitless floats). However, any suitable unit may be used, they are internally
    converted into Kelvin and molar respectively.

!!! warning "Temperature"
    Please see the documentation of `eQuilibrator` or `equilibrator-api` about changing the
    temperature.


It is possible to change the state of the equilibrator after initialization.
```
set_temperature(equilibrator, 298.15u"K")
set_ionic_strength(equilibrator, 0.25u"M")
set_pH(equilibrator, 7.4)
set_pMg(equilibrator, 3.0)
```
An eQuilibrator.jl `Equilibrator` has pretty printing:
```
julia> eq
Interface to equilibrator_api v0.4.5.1
Temperature:    298.15 K
Ionic strength: 0.25 M
pH:             7.5
pMg:            3.0
```

It is necessary to supply a reaction string.
```
rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"
```

After specifying the reaction string, it is a simple matter of calling the appropriate function
to get the ΔG values.
```
physiological_dg_prime(equilibrator, rxn_string)
# -46.26 ± 0.3 kJ mol^-1

standard_dg_prime(equilibrator, rxn_string)
# -29.14 ± 0.3 kJ mol^-1

dg_prime(equilibrator, rxn_string) # equilibrator_api default abundances/concentrations
# -29.14 ± 0.3 kJ mol^-1

concens = Dict("bigg.metabolite:atp"=>1u"mM", "bigg.metabolite:adp"=>100u"μM", "bigg.metabolite:pi"=>0.005u"M")
dg_prime(equilibrator, rxn_string; concentrations=concens) # user specified concentrations
# -47.98 ± 0.3 kJ mol^-1

ln_reversibility_index(equilibrator, rxn_string)
# -12.447 ± 0.082
```
!!! tip "Errors are shown using `Measurements.jl`"
    [eQuilibrator](https://equilibrator.weizmann.ac.il/static/classic_rxns/faq.html#how-do-you-calculate-the-uncertainty-for-each-estimation)
    supplies estimates with uncertainties, these are reflected by the use of `a ± b` with `b` being the uncertainty, assumed to be
    one standard deviation here. The nominal value of a Gibbs energy estimate may be found by using `Measurements.value(...)`.

!!! tip "Units are shown using `Unitful.jl`"
    Units are associated with each Gibbs energy estimate. To remove the units, use `Unitful.ustrip(...)`.

## Reaction parsing
It is possible to mix and match metabolite identifiers, exactly like in
`equilibrator_api`, with the associated warnings. In short, the reaction string
is directly passed to `equilibrator_api`, so whatever strings works for it, will
also work here.
```
equilibrator = eQuilibrator.Equilibrator()
atpase_rxn_string_2 = "kegg:C00002 + CHEBI:15377 = metanetx.chemical:MNXM7 + bigg.metabolite:pi"
dg_prime(equilibrator, atpase_rxn_string_2)
# -27.37 ± 0.3 kJ mol^-1
```
Convenience functions for reaction string processing are also made available. These
functions insert the appropriate identifier in front of each metabolite while respecting
the associated stoichiometric coefficient. Note, these functions insert the exact same
prefix before each metabolite.
```
bigg("atp + h2o = adp + pi")
# "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + 2 bigg.metabolite:pi"

bigg"atp + h2o = adp + pi"
# "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + 2 bigg.metabolite:pi"

kegg("C00002 + C00001 = C00008 + C00009")
# "kegg:C00002 + kegg:C00001 = kegg:C00008 + kegg:C00009"

kegg"C00002 + C00001 = C00008 + C00009"
# "kegg:C00002 + kegg:C00001 = kegg:C00008 + kegg:C00009"

metanetx("MNXM3 + MNXM2 = MNXM7 + MNXM9")
# "metanetx.chemical:MNXM3 + metanetx.chemical:MNXM2 = metanetx.chemical:MNXM7 + metanetx.chemical:MNXM9"

metanetx"MNXM3 + MNXM2 = MNXM7 + MNXM9"
# "metanetx.chemical:MNXM3 + metanetx.chemical:MNXM2 = metanetx.chemical:MNXM7 + metanetx.chemical:MNXM9"

chebi("30616 + 33813 = 456216 + 43474")
# "CHEBI:30616 + CHEBI:33813 = CHEBI:456216 + CHEBI:43474"

chebi"30616 + 33813 = 456216 + 43474"
# "CHEBI:30616 + CHEBI:33813 = CHEBI:456216 + CHEBI:43474"
```
To use this functionality:
```
equilibrator = eQuilibrator.Equilibrator()
r_str = bigg"atp + h2o = adp + pi"
dg_prime(equilibrator, r_str)
# -27.37 ± 0.3 kJ mol^-1
```
Note, these convenience functions may also be used on single metabolites to simplify the
specification of metabolite concentrations for `dg_prime`:
```
equilibrator = eQuilibrator.Equilibrator()
r_string = bigg"atp + h2o = adp + pi"
concens = [bigg"atp"=>1u"mM", bigg"adp"=>100u"μM", bigg"pi"=>0.005u"M"]
dg_prime(equilibrator, r_string; concentrations=concens) # user specified concentrations
# -46.2 ± 0.3 kJ mol^-1
```

## Advanced functionality
This API is relatively complete, see the `test` directory for all the implemented functionality.
In short, multi-compartment and multi-reaction functionality is implemented, as well as limited
Gibbs energy of formation support.
