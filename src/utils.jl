"""
    _parse_units(x)

Converts units like kilojoule / mole into kJ/mol.
This function is not exported.
"""
function _parse_units(x)
    unit_conversions = ["kilo"=>"k", "joule"=>"J", "mole"=>"mol", "milli"=>"m", "kelvin" => "K", "molar" => "M"]
    return foldl(replace, unit_conversions; init=x)
end

"""
    _parse_reaction_string(str::String, prefix::String)

Parse a reaction string and insert the prefix in front of each metabolite.
This function is not exported.
"""
function _parse_reaction_string(str::String, prefix::String)
    rxn_string_reagents_products = split(str, "=")
    reagents = string(rxn_string_reagents_products[1])
    products = string(rxn_string_reagents_products[2])
    parsed_reagents = join(_parse_reaction_part(reagents, prefix*":"), " + ")
    parsed_products = join(_parse_reaction_part(products, prefix*":"), " + ")
    return parsed_reagents*" = "*parsed_products
end

"""
    _parse_reaction_part(str::String, prefix::String)

Helper function for `_parse_reaction_string`.
This function is not exported.
"""
function _parse_reaction_part(str::String, prefix::String)
    nospace_str = replace(replace(str, " "=>""), "*"=>"") # get rid of spaces and *
    mets = split(nospace_str, r"\+")
    parsed_str = String[]
    for met in mets
        ind = findfirst(isletter, met)
        if ind == 1
            push!(parsed_str, prefix*met)
        else
            push!(parsed_str, met[1:ind-1]*" "*prefix*met[ind:end])
        end
    end
    return parsed_str
end

"""
    bigg(str)

Return a reaction string that has "bigg.metabolite:" appended in front of each metabolite.
Respects stoichiometric coefficients. Spaces and "*" in front of metabolites do not matter.
A string literal version also exists: `bigg"..."`

See also [`kegg`](@ref), [`metanetx`](@ref).

# Example
```
bigg("atp + h2o = adp + pi")

```
"""
function bigg(str)
   _parse_reaction_string(str, "bigg.metabolite")
end

"""
    @bigg_str(str)

Return a reaction string that has "bigg.metabolite:" appended in front of each metabolite.
Respects stoichiometric coefficients. Spaces and "*" in front of metabolites do not matter.

See also [`kegg`](@ref), [`metanetx`](@ref).

# Example
```
bigg"atp + h2o = adp + pi"
bigg"atp + h2o = adp + 2*pi"
bigg"atp + h2o = adp + 2 pi"
```
"""
macro bigg_str(str)
    return :(bigg($str))
end

"""
    kegg(str)

Return a reaction string that has "kegg:" appended in front of each metabolite.
Respects stoichiometric coefficients. Spaces and "*" in front of metabolites do not matter.
A string literal version also exists: `kegg"..."`

See also [`bigg`](@ref), [`metanetx`](@ref).

# Example
```
kegg("C00002 + C00001 = C00008 + C00009")
kegg("C00002 + C00001 = C00008 + 2*C00009")
kegg("C00002 + C00001 = C00008 + 2 C00009")
```
"""
function kegg(str::String)
    _parse_reaction_string(str, "kegg")
 end

"""
    @kegg_str(str)

Return a reaction string that has "kegg:" appended in front of each metabolite.
Respects stoichiometric coefficients. Spaces and "*" in front of metabolites do not matter.

See also [`bigg`](@ref), [`metanetx`](@ref).

# Example
```
kegg"C00002 + C00001 = C00008 + C00009"
kegg"C00002 + C00001 = C00008 + 2*C00009"
kegg"C00002 + C00001 = C00008 + 2 C00009"
```
"""
macro kegg_str(str::String)
    return :(kegg($str))
end

"""
    metanetx(str::String)

Return a reaction string that has "metanetx.chemical:" appended in front of each metabolite.
Respects stoichiometric coefficients. Spaces and "*" in front of metabolites do not matter.
A string literal version also exists: `metanetx"..."`

See also [`bigg`](@ref), [`kegg`](@ref).

# Example
```
metanetx("MNXM3 + MNXM2 = MNXM7 + MNXM9")
metanetx("MNXM3 + MNXM2 = MNXM7 + 2 MNXM9")
metanetx("MNXM3 + MNXM2 = MNXM7 + 2*MNXM9")
```
"""
function metanetx(str::String)
_parse_reaction_string(str, "metanetx.chemical")
end

"""
    @metanetx_str(str::String)

Return a reaction string that has "metanetx.chemical:" appended in front of each metabolite.
Respects stoichiometric coefficients. Spaces and "*" in front of metabolites do not matter.

See also [`bigg`](@ref), [`kegg`](@ref).

# Example
```
metanetx"MNXM3 + MNXM2 = MNXM7 + MNXM9"
metanetx"MNXM3 + MNXM2 = MNXM7 + 2 MNXM9"
metanetx"MNXM3 + MNXM2 = MNXM7 + 2*MNXM9"
```
"""
macro metanetx_str(str::String)
    return :(metanetx($str))
end
