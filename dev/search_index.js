var documenterSearchIndex = {"docs":
[{"location":"functions/#Function-reference","page":"Function reference","title":"Function reference","text":"","category":"section"},{"location":"functions/","page":"Function reference","title":"Function reference","text":"Modules=[eQuilibrator]\nPages=[\"equilibrator_type.jl\", \"univariate_reaction.jl\", \"multivariate_reaction.jl\", \"multicompartment_reaction.jl\", \"formation.jl\", \"utils.jl\"]\nDepth = 2","category":"page"},{"location":"functions/#eQuilibrator.Equilibrator","page":"Function reference","title":"eQuilibrator.Equilibrator","text":"struct Equilibrator\n\nA struct used to reference the equilibrator_api object.\n\neq\ncc\n\n\n\n\n\n","category":"type"},{"location":"functions/#eQuilibrator.Equilibrator-Tuple{}","page":"Function reference","title":"eQuilibrator.Equilibrator","text":"Equilibrator(; pH, pMg, ionic_strength, temperature)\n\n\nA constructor for Equilibrator. Keyword arguments ionic_strength and temperature have units. Any appropriate unit may be used, the conversion is handled internally. This is typically slow to load, ~ 30 seconds, since all the thermodynamic data needs to be loaded into memory.\n\nExample\n\nusing eQuilibrator\nusing Unitful\n\nequilibrator = Equilibrator(pH=6.0, pMg = 2.5, ionic_strength=250.0u\"mM\", temperature=30.0u\"°C\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.get_ionic_strength-Tuple{Equilibrator}","page":"Function reference","title":"eQuilibrator.get_ionic_strength","text":"get_ionic_strength(equilibrator)\n\n\nGet the ionic strength of equilibrator.\n\nExample\n\nget_ionic_strength(equilibrator)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.get_pH-Tuple{Equilibrator}","page":"Function reference","title":"eQuilibrator.get_pH","text":"get_pH(equilibrator)\n\n\nGet the pH from equilibrator.\n\nExample\n\nget_pH(equilibrator)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.get_pMg-Tuple{Equilibrator}","page":"Function reference","title":"eQuilibrator.get_pMg","text":"get_pMg(equilibrator)\n\n\nGet pMg from equilibrator.\n\nExample\n\nget_pMg(equilibrator)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.get_temperature-Tuple{Equilibrator}","page":"Function reference","title":"eQuilibrator.get_temperature","text":"get_temperature(equilibrator)\n\n\nGet the temperature of equilibrator.\n\nExample\n\nget_temperature(equilibrator)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.reset_equilibrator-Tuple{Equilibrator}","page":"Function reference","title":"eQuilibrator.reset_equilibrator","text":"reset_equilibrator(equilibrator)\n\n\nReset equilibrator back to the default starting state with pH = 7.5, pMg = 3.0, temperature = 298 K and ionic_strength = 0.25 M.\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.set_ionic_strength-Tuple{Equilibrator, Any}","page":"Function reference","title":"eQuilibrator.set_ionic_strength","text":"set_ionic_strength(equilibrator, x)\n\n\nSet the ionic strength of equilibrator to x.\n\nExample\n\nset_ionic_strength(equilibrator, 100u\"mM\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.set_pH-Tuple{Equilibrator, Any}","page":"Function reference","title":"eQuilibrator.set_pH","text":"set_pH(equilibrator, x)\n\n\nSet pH of equilibrator to x.\n\nExample\n\nset_pH(equilibrator, 3.5)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.set_pMg-Tuple{Equilibrator, Any}","page":"Function reference","title":"eQuilibrator.set_pMg","text":"set_pMg(equilibrator, x)\n\n\nSet pMg of equilibrator to x.\n\nExample\n\nset_pMg(equilibrator, 1.2)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.set_temperature-Tuple{Equilibrator, Any}","page":"Function reference","title":"eQuilibrator.set_temperature","text":"set_temperature(equilibrator, x)\n\n\nSet the temperature of equilibrator to x.\n\nExample\n\nset_temperature(equilibrator, 40u\"°C\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.dg_prime-Tuple{Equilibrator, String}","page":"Function reference","title":"eQuilibrator.dg_prime","text":"dg_prime(equilibrator, rxn_string; concentrations, balance_warn, skip_unbalanced)\n\n\nCalculate ΔG' of a reaction described by rxn_string using the settings in equilibrator. Optionally, set the concentrations (abundances) of the species involved in the reaction through concentration. If skip_unbalanced is true then return nothing if the reaction is unbalanced. If balance_warn is false then do not emit a warning when the reaction is unbalanced. Note, concentrations that are smaller than 0.001 mM are capped at 0.001 mM (an eQuilibrator/equilibrator_api) restriction.\n\nExample\n\nequilibrator = Equilibrator()\n\nrxn_string = \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi\"\nconcens = Dict(\"bigg.metabolite:atp\"=>1u\"mM\", \"bigg.metabolite:adp\"=>100u\"μM\", \"bigg.metabolite:pi\"=>0.003u\"M\")\ndg_prime(equilibrator, rxn_string; concentrations=concens)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.ln_reversibility_index-Tuple{Equilibrator, String}","page":"Function reference","title":"eQuilibrator.ln_reversibility_index","text":"ln_reversibility_index(equilibrator, rxn_string; balance_warn, skip_unbalanced)\n\n\nCalculate the log of the reversibility index of a reaction described by rxn_string using settings in equilibrator. If skip_unbalanced is true then return nothing if the reaction is unbalanced. If balance_warn is false then do not emit a warning when the reaction is unbalanced.\n\nExample\n\nequilibrator = Equilibrator()\n\nrxn_string = \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi\"\nln_reversibility_index(equilibrator, rxn_string)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.physiological_dg_prime-Tuple{Equilibrator, String}","page":"Function reference","title":"eQuilibrator.physiological_dg_prime","text":"physiological_dg_prime(equilibrator, rxn_string; balance_warn, skip_unbalanced)\n\n\nCalculate ΔG' at physiological conditions (all concentrations set to 1 mM, 1mbar) of a reaction described by rxn_string using the settings in equilibrator. If skip_unbalanced is true then return nothing if the reaction is unbalanced. If balance_warn is false then do not emit a warning when the reaction is unbalanced.\n\nExample\n\nequilibrator = Equilibrator()\n\nrxn_string = \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi\"\nphysiological_dg_prime(equilibrator, rxn_string)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.standard_dg_prime-Tuple{Equilibrator, String}","page":"Function reference","title":"eQuilibrator.standard_dg_prime","text":"standard_dg_prime(equilibrator, rxn_string; balance_warn, skip_unbalanced)\n\n\nCalculate ΔG⁰ at standard conditons of a reaction described by rxn_string using the settings in equilibrator. If skip_unbalanced is true then return nothing if the reaction is unbalanced. If balance_warn is false then do not emit a warning when the reaction is unbalanced.\n\nNote, standard conditions means that all concentrations are set at 1 M.\n\nExample\n\nequilibrator = Equilibrator()\n\nrxn_string = \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi\"\nstandard_dg_prime(equilibrator, rxn_string)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.standard_dg_prime_multi-Tuple{Equilibrator, Vector{String}}","page":"Function reference","title":"eQuilibrator.standard_dg_prime_multi","text":"standard_dg_prime_multi(equilibrator, rxn_strings; balance_warn, skip_unbalanced, uncertainty_representation, minimize_norm)\n\n\nCalculate ΔG'⁰ for each rxn_string in rxn_strings. The uncertainty_representation can be either fullrank, cov, or sqrt, and is used to represent the uncertainties. Specifically, cov returns a full covariance matrix, precision returna the precision matrix (i.e. the inverse of the covariance matrix), sqrt returns the square root of the covariance, based on the uncertainty vectors, and fullrank returns a full-rank square root of the covariance that is a compressed form of the sqrt result. If minimize_norm is  true, an orthogonal projection is used to minimize the Euclidian norm of the result vector. If balance_warn is true, emit a warning if any reaction is unbalanced, if skip_unbalanced is true, return nothing if an unbalanced reaction is found.\n\nExample\n\nequilibrator = Equilibrator()\n\nntp3 = \"gtp + h2o = gdp + pi\"\nadk3 = \"adp + gdp = amp + gtp\"\n\nμ, Q = standard_dg_prime_multi(eq, bigg.([ntp3, adk3]); uncertainty_representation=\"fullrank\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.multi_compartmental_standard_dg_prime-Tuple{Equilibrator, String, String}","page":"Function reference","title":"eQuilibrator.multi_compartmental_standard_dg_prime","text":"multi_compartmental_standard_dg_prime(equilibrator, rxn_inner, rxn_outer; potential_difference, pH_outer, pMg_outer, ionic_strength_outer, tolerance)\n\n\nCalculate ΔG'⁰ for a multicompartment reaction. Assume that equilibrator corresponds to the thermodynamic conditions of the inner reaction. The potential_difference across the membrane, as well as the pH_outer, pMg_outer, and ionic_strength_outer can be set. The tolerance sets the allowed imbalance between the rxn_inner and rxn_outer.\n\nExample\n\nequilibrator = Equilibrator()\n\ncyto_rxn = bigg(\"adp + pi + 2 h = h2o + atp\")\nperi_rxn = bigg(\" = 2 h\")\n\nψ = 0.17u\"V\"\nperi_ionic = 0.2u\"M\"\nperi_pMg = 3.0\nperi_pH = 6.5\n\nset_ionic_strength(eq, 250u\"mM\")\nset_pH(eq, 7.4)\nset_pMg(eq, 3.0)\n\ndg = multi_compartmental_standard_dg_prime(\n    eq,\n    cyto_rxn,\n    peri_rxn;\n    e_potential_difference = ψ,\n    pH_outer = peri_pH,\n    pMg_outer = peri_pMg,\n    ionic_strength_outer = peri_ionic,\n    tolerance=2.0,\n)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.standard_dg_formation-Tuple{Equilibrator, Vector{String}}","page":"Function reference","title":"eQuilibrator.standard_dg_formation","text":"standard_dg_formation(equilibrator, mets)\n\n\nCalculate the ΔG'⁰ of formation for all mets, as well as the covariance matrix of the errors.\n\nExample\n\nequilibrator = Equilibrator()\n\nmets = bigg.([\"atp\", \"adp\", \"amp\", \"pi\", \"h2o\"])\n\nstandard_dgf_prime_mu, standard_dgf_cov = standard_dg_formation(eq, mets)\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator._lower_bound","page":"Function reference","title":"eQuilibrator._lower_bound","text":"_lower_bound(x)\n_lower_bound(x, ϵ)\n\n\nCaps the lower bound of a concentration to ϵ. Return ϵ if x is less than ϵ, otherwise x. This function is not exported.\n\n\n\n\n\n","category":"function"},{"location":"functions/#eQuilibrator._parse_reaction_part-Tuple{String, String}","page":"Function reference","title":"eQuilibrator._parse_reaction_part","text":"_parse_reaction_part(str, prefix)\n\n\nHelper function for _parse_reaction_string. This function is not exported.\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator._parse_reaction_string-Tuple{String, String}","page":"Function reference","title":"eQuilibrator._parse_reaction_string","text":"_parse_reaction_string(str, prefix)\n\n\nParse a reaction string and insert the prefix in front of each metabolite. This function is not exported.\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator._parse_units-Tuple{Any}","page":"Function reference","title":"eQuilibrator._parse_units","text":"_parse_units(x)\n\n\nConverts units like kilojoule / mole into kJ/mol. This function is not exported.\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.bigg-Tuple{Any}","page":"Function reference","title":"eQuilibrator.bigg","text":"bigg(str)\n\n\nReturn a reaction string that has \"bigg.metabolite:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm. A string literal version also exists: bigg\"...\"\n\nSee also kegg, metanetx, chebi.\n\nExample\n\nbigg(\"atp + h2o = adp + pi\")\nbigg(\"atp + h2o = adp + 2*pi\")\nbigg(\"atp + h2o = adp + 2 pi\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.chebi-Tuple{String}","page":"Function reference","title":"eQuilibrator.chebi","text":"chebi(str)\n\n\nReturn a reaction string that has \"CHEBI:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm. A string literal version also exists: chebi\"...\"\n\nSee also bigg, metanetx, kegg.\n\nExample\n\nchebi(30616 + 33813 = 456216 + 43474\")\nchebi(30616 + 33813 = 456216 + 2*43474\")\nchebi(30616 + 33813 = 456216 + 2 43474\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.kegg-Tuple{String}","page":"Function reference","title":"eQuilibrator.kegg","text":"kegg(str)\n\n\nReturn a reaction string that has \"kegg:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm. A string literal version also exists: kegg\"...\"\n\nSee also bigg, metanetx, chebi.\n\nExample\n\nkegg(\"C00002 + C00001 = C00008 + C00009\")\nkegg(\"C00002 + C00001 = C00008 + 2*C00009\")\nkegg(\"C00002 + C00001 = C00008 + 2 C00009\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.metanetx-Tuple{String}","page":"Function reference","title":"eQuilibrator.metanetx","text":"metanetx(str)\n\n\nReturn a reaction string that has \"metanetx.chemical:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm. A string literal version also exists: metanetx\"...\"\n\nSee also bigg, kegg, chebi\n\nExample\n\nmetanetx(\"MNXM3 + MNXM2 = MNXM7 + MNXM9\")\nmetanetx(\"MNXM3 + MNXM2 = MNXM7 + 2 MNXM9\")\nmetanetx(\"MNXM3 + MNXM2 = MNXM7 + 2*MNXM9\")\n\n\n\n\n\n","category":"method"},{"location":"functions/#eQuilibrator.@bigg_str-Tuple{Any}","page":"Function reference","title":"eQuilibrator.@bigg_str","text":"Return a reaction string that has \"bigg.metabolite:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.\n\nSee also kegg, metanetx, chebi.\n\nExample\n\nbigg\"atp + h2o = adp + pi\"\nbigg\"atp + h2o = adp + 2*pi\"\nbigg\"atp + h2o = adp + 2 pi\"\n\n\n\n\n\n","category":"macro"},{"location":"functions/#eQuilibrator.@chebi_str-Tuple{String}","page":"Function reference","title":"eQuilibrator.@chebi_str","text":"Return a reaction string that has \"CHEBI:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.\n\nSee also bigg, metanetx, kegg.\n\nExample\n\nchebi\"30616 + 33813 = 456216 + 43474\"\nchebi\"30616 + 33813 = 456216 + 2*43474\"\nchebi\"30616 + 33813 = 456216 + 2 43474\"\n\n\n\n\n\n","category":"macro"},{"location":"functions/#eQuilibrator.@kegg_str-Tuple{String}","page":"Function reference","title":"eQuilibrator.@kegg_str","text":"Return a reaction string that has \"kegg:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.\n\nSee also bigg, metanetx, chebi.\n\nExample\n\nkegg\"C00002 + C00001 = C00008 + C00009\"\nkegg\"C00002 + C00001 = C00008 + 2*C00009\"\nkegg\"C00002 + C00001 = C00008 + 2 C00009\"\n\n\n\n\n\n","category":"macro"},{"location":"functions/#eQuilibrator.@metanetx_str-Tuple{String}","page":"Function reference","title":"eQuilibrator.@metanetx_str","text":"Return a reaction string that has \"metanetx.chemical:\" appended in front of each metabolite. Respects stoichiometric coefficients. \"*\" in front of metabolites do not matter, but spaces do matter. So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.\n\nSee also bigg, kegg, chebi.\n\nExample\n\nmetanetx\"MNXM3 + MNXM2 = MNXM7 + MNXM9\"\nmetanetx\"MNXM3 + MNXM2 = MNXM7 + 2 MNXM9\"\nmetanetx\"MNXM3 + MNXM2 = MNXM7 + 2*MNXM9\"\n\n\n\n\n\n","category":"macro"},{"location":"examples/#Example-usage","page":"Example usage","title":"Example usage","text":"","category":"section"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"The following examples follow closely the example usage documented in equilibrator_api. Try running these examples!","category":"page"},{"location":"examples/#Basic-ΔG'-calculations","page":"Example usage","title":"Basic ΔG' calculations","text":"","category":"section"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"Load eQuilibrator.jl and Unitful. Then initialize the thermodynamic equilibrator as shown below.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"using eQuilibrator\nusing Unitful\n\ntemp = 30u\"°C\"\ni_strength = 150.0u\"mM\"\nph = 7.9\npmg = 2.0\n\nequilibrator = eQuilibrator.Equilibrator(pH=ph, pMg=pmg, temperature=temp, ionic_strength=i_strength)","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"note: Take care of units\nUnits for temperature and ionic strength are required (pH and pMg are unitless floats). However, any suitable unit may be used, they are internally converted into Kelvin and molar respectively.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"warning: Temperature\nPlease see the documentation of eQuilibrator or equilibrator-api about changing the temperature.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"It is possible to change the state of the equilibrator after initialization.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"set_temperature(equilibrator, 298.15u\"K\")\nset_ionic_strength(equilibrator, 0.25u\"M\")\nset_pH(equilibrator, 7.4)\nset_pMg(equilibrator, 3.0)","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"An eQuilibrator.jl Equilibrator has pretty printing:","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"equilibrator\n# eQuilibrator Equilibrator\n# Temperature:    298.15 K\n# Ionic strength: 0.25 M\n# pH:             7.4\n# pMg:            3.0","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"It is necessary to supply a reaction string.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"rxn_string = \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi\"","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"After specifying the reaction string, it is a simple matter of calling the appropriate function to get the ΔG values.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"physiological_dg_prime(equilibrator, rxn_string)\n# -46.26 ± 0.3 kJ mol^-1\n\nstandard_dg_prime(equilibrator, rxn_string)\n# -29.14 ± 0.3 kJ mol^-1\n\ndg_prime(equilibrator, rxn_string) # equilibrator_api default abundances/concentrations\n# -29.14 ± 0.3 kJ mol^-1\n\nconcens = Dict(\"bigg.metabolite:atp\"=>1u\"mM\", \"bigg.metabolite:adp\"=>100u\"μM\", \"bigg.metabolite:pi\"=>0.005u\"M\")\ndg_prime(equilibrator, rxn_string; concentrations=concens) # user specified concentrations\n# -47.98 ± 0.3 kJ mol^-1\n\nln_reversibility_index(equilibrator, rxn_string)\n# -12.447 ± 0.082","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"tip: Errors are shown using `Measurements.jl`\neQuilibrator supplies estimates with uncertainties, these are reflected by the use of a ± b with b being the uncertainty, assumed to be one standard deviation here. The nominal value of a Gibbs energy estimate may be found by using Measurements.value(...).","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"tip: Units are shown using `Unitful.jl`\nUnits are associated with each Gibbs energy estimate. To remove the units, use Unitful.ustrip(...).","category":"page"},{"location":"examples/#Reaction-parsing","page":"Example usage","title":"Reaction parsing","text":"","category":"section"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"It is possible to mix and match metabolite identifiers, exactly like in equilibrator_api, with the associated warnings. In short, the reaction string is directly passed to equilibrator_api, so whatever strings works for it, will also work here.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"equilibrator = eQuilibrator.Equilibrator()\natpase_rxn_string_2 = \"kegg:C00002 + CHEBI:15377 = metanetx.chemical:MNXM7 + bigg.metabolite:pi\"\ndg_prime(equilibrator, atpase_rxn_string_2)\n# -27.37 ± 0.3 kJ mol^-1","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"Convenience functions for reaction string processing are also made available. These functions insert the appropriate identifier in front of each metabolite while respecting the associated stoichiometric coefficient. Note, these functions insert the exact same prefix before each metabolite.","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"bigg(\"atp + h2o = adp + pi\")\n# \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + 2 bigg.metabolite:pi\"\n\nbigg\"atp + h2o = adp + pi\"\n# \"bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + 2 bigg.metabolite:pi\"\n\nkegg(\"C00002 + C00001 = C00008 + C00009\")\n# \"kegg:C00002 + kegg:C00001 = kegg:C00008 + kegg:C00009\"\n\nkegg\"C00002 + C00001 = C00008 + C00009\"\n# \"kegg:C00002 + kegg:C00001 = kegg:C00008 + kegg:C00009\"\n\nmetanetx(\"MNXM3 + MNXM2 = MNXM7 + MNXM9\")\n# \"metanetx.chemical:MNXM3 + metanetx.chemical:MNXM2 = metanetx.chemical:MNXM7 + metanetx.chemical:MNXM9\"\n\nmetanetx\"MNXM3 + MNXM2 = MNXM7 + MNXM9\"\n# \"metanetx.chemical:MNXM3 + metanetx.chemical:MNXM2 = metanetx.chemical:MNXM7 + metanetx.chemical:MNXM9\"\n\nchebi(\"30616 + 33813 = 456216 + 43474\")\n# \"CHEBI:30616 + CHEBI:33813 = CHEBI:456216 + CHEBI:43474\"\n\nchebi\"30616 + 33813 = 456216 + 43474\"\n# \"CHEBI:30616 + CHEBI:33813 = CHEBI:456216 + CHEBI:43474\"","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"To use this functionality:","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"equilibrator = eQuilibrator.Equilibrator()\nr_str = bigg\"atp + h2o = adp + pi\"\ndg_prime(equilibrator, r_str)\n# -27.37 ± 0.3 kJ mol^-1","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"Note, these convenience functions may also be used on single metabolites to simplify the specification of metabolite concentrations for dg_prime:","category":"page"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"equilibrator = eQuilibrator.Equilibrator()\nr_string = bigg\"atp + h2o = adp + pi\"\nconcens = [bigg\"atp\"=>1u\"mM\", bigg\"adp\"=>100u\"μM\", bigg\"pi\"=>0.005u\"M\"]\ndg_prime(equilibrator, r_string; concentrations=concens) # user specified concentrations\n# -46.2 ± 0.3 kJ mol^-1","category":"page"},{"location":"examples/#Advanced-functionality","page":"Example usage","title":"Advanced functionality","text":"","category":"section"},{"location":"examples/","page":"Example usage","title":"Example usage","text":"This API is relatively complete, see the test directory for all the implemented functionality.","category":"page"},{"location":"installation/#Installation-instructions","page":"Installation","title":"Installation instructions","text":"","category":"section"},{"location":"installation/","page":"Installation","title":"Installation","text":"eQuilibrator.jl uses PyCall.jl and Conda.jl to access equilibrator_api functions. First, ensure that you have installed both PyCall.jl and Conda.jl using Julia's package manager:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"] add PyCall\n] add Conda","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"Next, install equilibrator_api through Conda.jl:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"using Conda\n\nConda.add(\"equilibrator-api\"; channel=\"conda-forge\") # note: use a dash and not an underscore in \"equilibrator-api\"","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"Then test if you can import equilibrator_api using PyCall.jl:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"using PyCall\n\neq = pyimport(\"equilibrator_api\") # note: use an underscore and not a dash in \"equilibrator_api\"","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"If no errors occur, and the last command return something like PyObject <module 'equilibrator_api' from... then you will be able to use eQuilibrator.jl after installing it:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"] add eQuilibrator","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"Finally, test if everything works as expected:","category":"page"},{"location":"installation/","page":"Installation","title":"Installation","text":"] test eQuilibrator","category":"page"},{"location":"#eQuilibrator.jl","page":"Home","title":"eQuilibrator.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"eQuilibrator.jl is a lightweight interface to the Python package equilibrator_api, which provides a programmatic way to make use of the functionality of eQuilibrator. This is particularly useful when one needs access to thermodynamic information about reactions or compounds. ","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\"installation.md\", \"examples.md\", \"functions.md\"]\nDepth = 1","category":"page"}]
}
