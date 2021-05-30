"""
    _parse_units(x)

Converts units like kilojoule / mole into kJ/mol. This function is not exported.
"""
function _parse_units(x)
    unit_conversions = ["kilo"=>"k", "joule"=>"J", "mole"=>"mol", "milli"=>"m", "kelvin" => "K", "molar" => "M"]
    return foldl(replace, unit_conversions; init=x)
end
