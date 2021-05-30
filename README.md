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

[![docs-img]][docs-url] [![][license-img]][license-url] [![contributions welcome][contrib]](https://github.com/stelmo/eQuilibrator.jl/issues)

## Installation

To install this package: `] add https://github.com/stelmo/eQuilibrator.jl`. See the documentation for more information.

## Quick Example
```julia
using eQuilibrator

system = eQuilibrator.System(ionic_strength=150.0u"mM")
rxn_string = "bigg.metabolite:atp + bigg.metabolite:h2o = bigg.metabolite:adp + bigg.metabolite:pi"

dg_prime(system, rxn_string) # -26.88 ± 0.3 kJ mol^-1
```
