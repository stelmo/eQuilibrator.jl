module eQuilibrator

using Measurements: length
using PyCall
using Unitful
using Measurements
using Crayons

include("utils.jl")
include("equilibrator_type.jl")
include("reaction.jl")

export Equilibrator,
       temperature,
       ionic_strength,
       pH,
       pMg,
       standard_dg_prime,
       physiological_dg_prime,
       dg_prime,
       ln_reversibility_index,
       bigg,
       @bigg_str,
       kegg,
       @kegg_str,
       chebi,
       @chebi_str,
       metanetx,
       @metanetx_str

end # module
