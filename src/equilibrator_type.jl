"""
    struct Equilibrator

A struct used to reference the `equilibrator_api` object.
"""
struct Equilibrator
    eq :: PyObject
    cc :: PyObject
end

function Base.show(io::IO, ::MIME"text/plain", equilibrator::Equilibrator)
    println(crayon"blue bold", "eQuilibrator system", crayon"default !bold")
    println(crayon"yellow","Temperature:\t", crayon"default", temperature(equilibrator))
    println(crayon"yellow","Ionic strength: ", crayon"default", ionic_strength(equilibrator))
    println(crayon"yellow","pH:\t\t", crayon"default", pH(equilibrator))
    println(crayon"yellow","pMg:\t\t", crayon"default", pMg(equilibrator))
end

"""
    Equilibrator(; ph=7.0, pMg = 3.0, ionic_strength = 0.25M, temperature=298.15K)

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
function Equilibrator(;pH=7.0, pMg = 3.0, ionic_strength = 0.25u"M", temperature=298.15u"K")
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
reset(equilibrator:Equilibrator)

Reset `equilibrator` back to the default starting state with `pH = 7.0`,
`pMg = 3.0`, `temperature = 298 K` and `ionic_strength = 0.25 M`.
"""
function reset(equilibrator::Equilibrator)
    temperature(equilibrator, 298.15u"K")
    pH(equilibrator, 7.0)
    pMg(equilibrator, 3.0)
    ionic_strength(equilibrator, 0.25u"M")
end

"""
    temperature(equilibrator::Equilibrator)

Get the temperature of `equilibrator`.

# Example
```
temperature(equilibrator)
```
"""
function temperature(equilibrator::Equilibrator)
    units = uparse(_parse_units(py"str"(equilibrator.cc.temperature.units)))
    (equilibrator.cc.temperature.m)units
end

"""
    temperature(equilibrator::Equilibrator, x)

Set the temperature of `equilibrator` to `x`.

# Example
```
temperature(equilibrator, 40u"°C")
```
"""
function temperature(equilibrator::Equilibrator, x)
    _temperature = uconvert(u"K", float(x))
    equilibrator.cc.temperature = equilibrator.eq.Q_(string(_temperature))
    return nothing
end

"""
    ionic_strength(equilibrator::Equilibrator)

Get the ionic strength of `equilibrator`.

# Example
```
ionic_strength(equilibrator)
```
"""
function ionic_strength(equilibrator::Equilibrator)
    units = uparse(_parse_units(py"str"(equilibrator.cc.ionic_strength.units)))
    (equilibrator.cc.ionic_strength.m)units
end

"""
    ionic_strength(equilibrator::Equilibrator, x)

Set the ionic strength of `equilibrator` to `x`.

# Example
```
ionic_strength(equilibrator, 100u"mM")
```
"""
function ionic_strength(equilibrator::Equilibrator, x)
    _ionic_strength = uconvert(u"M", float(x))
    equilibrator.cc.ionic_strength = equilibrator.eq.Q_(string(_ionic_strength))
    return nothing
end

"""
    pH(equilibrator::Equilibrator)

Get the pH from `equilibrator`.

# Example
```
pH(equilibrator)
```
"""
function pH(equilibrator::Equilibrator)
    equilibrator.cc.p_h.m
end

"""
    pH(equilibrator::Equilibrator, x)

Set pH of `equilibrator` to `x`.

# Example
```
pH(equilibrator, 3.5)
```
"""
function pH(equilibrator::Equilibrator, x)
    equilibrator.cc.p_h = equilibrator.eq.Q_(float(x))
    return nothing
end

"""
    pMg(equilibrator::Equilibrator)

Get pMg from `equilibrator`.
# Example
```
pMg(equilibrator)
```
"""
function pMg(equilibrator::Equilibrator)
    equilibrator.cc.p_mg.m
end

"""
    pMg(equilibrator::Equilibrator, x)

Set pMg of `equilibrator` to `x`.
# Example
```
pMg(equilibrator, 1.2)
```
"""
function pMg(equilibrator::Equilibrator, x)
    equilibrator.cc.p_mg = equilibrator.eq.Q_(float(x))
    return nothing
end
