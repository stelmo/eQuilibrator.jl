module eQuilibrator

using PyCall
using Unitful
using Measurements
using Crayons
using DocStringExtensions

include("utils.jl")
include("equilibrator_type.jl")
include("univariate_reaction.jl")
include("multivariate_reaction.jl")
include("multicompartment_reaction.jl")
include("formation.jl")

# export everything that isn't prefixed with _ (inspired by JuMP.jl, thanks!)
for sym in names(@__MODULE__, all = true)
    if sym in [Symbol(@__MODULE__), :eval, :include] || startswith(string(sym), ['_', '#'])
        continue
    end
    @eval export $sym
end

end # module
