# Equilibrator.jl
*A lighweight interface to eQuilibrator through Julia.*

[docs-img]:https://img.shields.io/badge/docs-latest-blue.svg
[docs-url]: https://stelmo.github.io/CobraTools.jl/dev
 
[ci-img]: https://github.com/stelmo/CobraTools.jl/actions/workflows/ci.yml/badge.svg?branch=master&event=push
[ci-url]: https://github.com/stelmo/CobraTools.jl/actions/workflows/ci.yml

[cov-img]: https://codecov.io/gh/stelmo/CobraTools.jl/branch/master/graph/badge.svg?token=3AE3ZDCJJG
[cov-url]: https://codecov.io/gh/stelmo/CobraTools.jl

[contrib]: https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat

[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat
[license-url]: LICENSE.md

[![][license-img]][license-url] [![contributions welcome][contrib]](https://github.com/stelmo/CobraTools.jl/issues)

| **Documentation** | **Tests** | **Coverage** |
|:--------------:|:-------:|:---------:|
| [![docs-img]][docs-url] | [![CI][ci-img]][ci-url] | [![codecov][cov-img]][cov-url] |

This package provides basic convenience functions, e.g. model IO, construction, modification, and FBA, pFBA, sampling, etc. It can also be used to interface with [Equilibrator](http://equilibrator.weizmann.ac.il/) and [BRENDA](https://www.brenda-enzymes.org/).

## Installation

To install this package: `] add https://github.com/stelmo/Equilibrator.jl`. See the documentation for more information.

## Quick Example
Let's use `Equilibrator.jl` to perform classic flux balance analysis on an *E. coli* genome-scale metabolic model.
```julia
using CobraTools
using JuMP
using Tulip # pick any solver supported by JuMP

# Import E. coli model (models have pretty printing)
model = read_model("iJO1366.json") 

# Choose objective to maximize (biomass is a reaction struct, which also has pretty printing)
biomass = findfirst(model.reactions, "BIOMASS_Ec_iJO1366_WT_53p95M")

# FBA - use convenience function
sol = fba(model, biomass, Tulip.Optimizer)
```
