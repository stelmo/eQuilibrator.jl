"""
    $(TYPEDEF)

A struct used to reference the `equilibrator_api` object.

$(FIELDS)
"""
struct Equilibrator
    eq::PyObject
    cc::PyObject
end

function Base.show(io::IO, ::MIME"text/plain", equilibrator::Equilibrator)
    v = string(equilibrator.eq.__version__)
    println(crayon"blue bold", "Interface to equilibrator_api v$v", crayon"default !bold")
    println(
        crayon"yellow",
        "Temperature:\t",
        crayon"default",
        get_temperature(equilibrator),
    )
    println(
        crayon"yellow",
        "Ionic strength: ",
        crayon"default",
        get_ionic_strength(equilibrator),
    )
    println(crayon"yellow", "pH:\t\t", crayon"default", get_pH(equilibrator))
    println(crayon"yellow", "pMg:\t\t", crayon"default", get_pMg(equilibrator))
end

"""
    $(SIGNATURES)

A constructor for `Equilibrator`. Keyword arguments `ionic_strength` and `temperature` have units.
Any appropriate unit may be used, the conversion is handled internally. This is typically
slow to load, ~ 30 seconds, since all the thermodynamic data needs to be loaded into memory.

# Example
```
using eQuilibrator
using Unitful

equilibrator = Equilibrator(pH=6.0, pMg = 2.5, ionic_strength=250.0u"mM", temperature=30.0u"°C")
```
"""
function Equilibrator(;
    pH = 7.5,
    pMg = 3.0,
    ionic_strength = 0.25u"M",
    temperature = 298.15u"K",
)
    eq = pyimport("equilibrator_api")
    cc = eq.ComponentContribution()

    cc.p_h = eq.Q_(pH)
    cc.p_mg = eq.Q_(pMg)

    _ionic_strength = uconvert(u"M", float(ionic_strength))
    cc.ionic_strength = eq.Q_(string(_ionic_strength))

    _temperature = uconvert(u"K", float(temperature))
    cc.temperature = eq.Q_(string(_temperature))
    return Equilibrator(eq, cc)
end

"""
    $(SIGNATURES)

Reset `equilibrator` back to the default starting state with `pH = 7.5`,
`pMg = 3.0`, `temperature = 298 K` and `ionic_strength = 0.25 M`.
"""
function reset_equilibrator(equilibrator::Equilibrator)
    set_temperature(equilibrator, 298.15u"K")
    set_pH(equilibrator, 7.5)
    set_pMg(equilibrator, 3.0)
    set_ionic_strength(equilibrator, 0.25u"M")
end

"""
    $(SIGNATURES)

Get the temperature of `equilibrator`.

# Example
```
get_temperature(equilibrator)
```
"""
function get_temperature(equilibrator::Equilibrator)
    units = uparse(_parse_units(py"str"(equilibrator.cc.temperature.units)))
    (equilibrator.cc.temperature.m)units
end

"""
    $(SIGNATURES)

Set the temperature of `equilibrator` to `x`.

# Example
```
set_temperature(equilibrator, 40u"°C")
```
"""
function set_temperature(equilibrator::Equilibrator, x)
    _temperature = uconvert(u"K", float(x))
    equilibrator.cc.temperature = equilibrator.eq.Q_(string(_temperature))
    return nothing
end

"""
    $(SIGNATURES)

Get the ionic strength of `equilibrator`.

# Example
```
get_ionic_strength(equilibrator)
```
"""
function get_ionic_strength(equilibrator::Equilibrator)
    units = uparse(_parse_units(py"str"(equilibrator.cc.ionic_strength.units)))
    (equilibrator.cc.ionic_strength.m)units
end

"""
    $(SIGNATURES)

Set the ionic strength of `equilibrator` to `x`.

# Example
```
set_ionic_strength(equilibrator, 100u"mM")
```
"""
function set_ionic_strength(equilibrator::Equilibrator, x)
    _ionic_strength = uconvert(u"M", float(x))
    equilibrator.cc.ionic_strength = equilibrator.eq.Q_(string(_ionic_strength))
    return nothing
end

"""
    $(SIGNATURES)

Get the pH from `equilibrator`.

# Example
```
get_pH(equilibrator)
```
"""
function get_pH(equilibrator::Equilibrator)
    equilibrator.cc.p_h.m
end

"""
    $(SIGNATURES)

Set pH of `equilibrator` to `x`.

# Example
```
set_pH(equilibrator, 3.5)
```
"""
function set_pH(equilibrator::Equilibrator, x)
    equilibrator.cc.p_h = equilibrator.eq.Q_(float(x))
    return nothing
end

"""
    $(SIGNATURES)

Get pMg from `equilibrator`.

# Example
```
get_pMg(equilibrator)
```
"""
function get_pMg(equilibrator::Equilibrator)
    equilibrator.cc.p_mg.m
end

"""
    $(SIGNATURES)

Set pMg of `equilibrator` to `x`.

# Example
```
set_pMg(equilibrator, 1.2)
```
"""
function set_pMg(equilibrator::Equilibrator, x)
    equilibrator.cc.p_mg = equilibrator.eq.Q_(float(x))
    return nothing
end
