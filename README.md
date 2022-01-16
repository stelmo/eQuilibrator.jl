<br>
<div align="center">
    <img src="docs/src/assets/header.svg?maxAge=0" width="50%">
</div>

[docs-img]:https://img.shields.io/badge/docs-latest-blue.svg
[docs-url]: https://stelmo.github.io/eQuilibrator.jl/dev

[ci-img]: https://github.com/stelmo/eQuilibrator.jl/actions/workflows/ci.yml/badge.svg?branch=main
[ci-url]: https://github.com/stelmo/eQuilibrator.jl/actions/workflows/ci.yml

[cov-img]: https://codecov.io/gh/stelmo/eQuilibrator.jl/branch/main/graph/badge.svg?token=WIQVsI0ZGJ
[cov-url]: https://codecov.io/gh/stelmo/eQuilibrator.jl

[contrib]: https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat

[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat
[license-url]: LICENSE

[![docs-img]][docs-url] [![][license-img]][license-url] [![contributions welcome][contrib]](https://github.com/stelmo/eQuilibrator.jl/issues) [![eQuilibrator Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/eQuilibrator)](https://pkgs.genieframework.com?packages=eQuilibrator)

A lightweight interface to [eQuilibrator](https://equilibrator.weizmann.ac.il/) and [equilibrator_api](https://gitlab.com/equilibrator/equilibrator-api) through Julia.

## Installation

To install this package: `] add eQuilibrator`. See the [documentation](https://stelmo.github.io/eQuilibrator.jl/dev/) for more information.

## Quick Example
```julia
using eQuilibrator
using Unitful, Measurements

equilibrator = eQuilibrator.Equilibrator(ionic_strength=150.0u"mM")

rxn_string = bigg"atp + h2o = adp + pi"

ΔrG = dg_prime(equilibrator, rxn_string) # -26.88 ± 0.3 kJ mol^-1

no_units_ΔrG = ustrip(u"kJ/mol", ΔrG) # -26.88 ± 0.3

no_units_nominal_ΔrG = no_units_ΔrG.val # -26.877081724713634
```

## Contributions
Please feel free to file an issue or submit a PR!
