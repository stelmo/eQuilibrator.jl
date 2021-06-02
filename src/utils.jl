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
    nospace_str = replace(str, "*" => " ") # get rid of * if present
    mets = split(nospace_str, r"\+")
    parsed_str = String[]
    for met in mets
        met = replace(met, r"\s+$"=>"")
        ind = findfirst(r"(\d+\s)|(\d+\.\s)|(\d+\.\d+\s)|(\.\d+\s)", met)
        if isnothing(ind)
            push!(parsed_str, prefix*replace(met," "=>""))
        else
            stoich = met[ind]
            push!(parsed_str, stoich*prefix*replace(met[ind[end]+1:end]," "=>""))
        end
    end
    return parsed_str
end

"""
    bigg(str)

Return a reaction string that has "bigg.metabolite:" appended in front of each metabolite.
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.
A string literal version also exists: `bigg"..."`

See also [`kegg`](@ref), [`metanetx`](@ref), [`chebi`][@ref].

# Example
```
bigg("atp + h2o = adp + pi")
bigg("atp + h2o = adp + 2*pi")
bigg("atp + h2o = adp + 2 pi")
```
"""
function bigg(str)
   _parse_reaction_string(str, "bigg.metabolite")
end

"""
    @bigg_str(str)

Return a reaction string that has "bigg.metabolite:" appended in front of each metabolite.
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.

See also [`kegg`](@ref), [`metanetx`](@ref), [`chebi`][@ref].

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
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.
A string literal version also exists: `kegg"..."`

See also [`bigg`](@ref), [`metanetx`](@ref), [`chebi`][@ref].

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
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.

See also [`bigg`](@ref), [`metanetx`](@ref), [`chebi`][@ref].

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
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.
A string literal version also exists: `metanetx"..."`

See also [`bigg`](@ref), [`kegg`](@ref), [`chebi`][@ref].

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
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.

See also [`bigg`](@ref), [`kegg`](@ref), [`chebi`][@ref].

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

"""
    chebi(str)

Return a reaction string that has "CHEBI:" appended in front of each metabolite.
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.
A string literal version also exists: `chebi"..."`

See also [`bigg`](@ref), [`metanetx`](@ref), [`kegg`](@ref).

# Example
```
chebi(30616 + 33813 = 456216 + 43474")
chebi(30616 + 33813 = 456216 + 2*43474")
chebi(30616 + 33813 = 456216 + 2 43474")
```
"""
function chebi(str::String)
    _parse_reaction_string(str, "CHEBI")
 end

"""
    @chebi_str(str)

Return a reaction string that has "chebi:" appended in front of each metabolite.
Respects stoichiometric coefficients. "*" in front of metabolites do not matter, but spaces do matter. 
So 13pgm is different from 13 pgm but 13*pgm is the same as 13 pgm.

See also [`bigg`](@ref), [`metanetx`](@ref), [`kegg`](@ref).

# Example
```
chebi"30616 + 33813 = 456216 + 43474"
chebi"30616 + 33813 = 456216 + 2*43474"
chebi"30616 + 33813 = 456216 + 2 43474"
```
"""
macro chebi_str(str::String)
    return :(chebi($str))
end
