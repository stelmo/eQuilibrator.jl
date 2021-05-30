"""
    struct System

A struct used to reference the `equilibrator_api` object.
"""
struct System
    eq :: PyObject
    cc :: PyObject
end

function Base.show(io::IO, ::MIME"text/plain", sys::System)
    println(crayon"blue bold", "eQuilibrator System", crayon"default !bold")
    println(crayon"yellow","Temperature:\t", crayon"default", temperature(sys))
    println(crayon"yellow","Ionic strength: ", crayon"default", ionic_strength(sys))
    println(crayon"yellow","pH:\t\t", crayon"default", pH(sys))
    println(crayon"yellow","pMg:\t\t", crayon"default", pMg(sys))
end

"""
    System(;ph=7.0, pMg = 3.0, ionic_strength = 0.25M, temperature=298.15K)

A constructor for `System`. Keyword arguments `ionic_strength` and `temperature` have units.
Any appropriate unit may be used, the conversion is handled internally.

Note: use floating point numbers and not integers when specifying the units of a system.

# Example
```
using eQuilibrator
using Unitful

sys = System(ph=6.0, pMg = 2.5, ionic_strength=250.0u"mM", temperature=30.0u"°C")
```
"""
function System(;ph=7.0, pMg = 3.0, ionic_strength = 0.25u"M", temperature=298.15u"K")
    eq = pyimport("equilibrator_api")
    cc = eq.ComponentContribution()

    cc.p_h = eq.Q_(ph)
    cc.p_mg = eq.Q_(pMg)
    
    _ionic_strength = uconvert(u"M", float(ionic_strength))
    cc.ionic_strength = eq.Q_(string(_ionic_strength))

    _temperature = uconvert(u"K", float(temperature))
    cc.temperature = eq.Q_(string(_temperature))
    return System(eq, cc)
end

"""
    temperature(sys::System)

Get the temperature of `sys`.

# Example
```
temperature(sys)
```
"""
function temperature(sys::System)
    units = uparse(_parse_units(py"str"(sys.cc.temperature.units)))
    (sys.cc.temperature.m)units
end

"""
    temperature(sys::System, x)

Set the temperature of `sys` to `x`.

# Example
```
temperature(sys, 40u"°C")
```
"""
function temperature(sys::System, x)
    _temperature = uconvert(u"K", float(x))
    sys.cc.temperature = sys.eq.Q_(string(_temperature))
    return nothing
end

"""
    ionic_strength(sys::System)

Get the ionic strength of `sys`.

# Example
```
ionic_strength(sys)
```
"""
function ionic_strength(sys::System)
    units = uparse(_parse_units(py"str"(sys.cc.ionic_strength.units)))
    (sys.cc.ionic_strength.m)units
end

"""
    ionic_strength(sys::System, x)

Set the ionic strength of `sys` to `x`.

# Example
```
ionic_strength(sys, 100u"mM")
```
"""
function ionic_strength(sys::System, x)
    _ionic_strength = uconvert(u"M", float(x))
    sys.cc.ionic_strength = sys.eq.Q_(string(_ionic_strength))
    return nothing
end

"""
    pH(sys::System)

Get the pH from `sys`.

# Example
```
pH(sys)
```
"""
function pH(sys::System)
    sys.cc.p_h.m
end

"""
    pH(sys::System, x)

Set pH of `sys` to `x`.

# Example
```
pH(sys, 3.5)
```
"""
function pH(sys::System, x)
    sys.cc.p_h = sys.eq.Q_(float(x))
    return nothing
end

"""
    pMg(sys::System)

Get pMg from `sys`.
# Example
```
pMg(sys)
```
"""
function pMg(sys::System)
    sys.cc.p_mg.m
end

"""
    pMg(sys::System, x)

Set pMg of `sys` to `x`.
# Example
```
pMg(sys, 1.2)
```
"""
function pMg(sys::System, x)
    sys.cc.p_mg = sys.eq.Q_(float(x))
    return nothing
end
