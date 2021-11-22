# Installation instructions

`eQuilibrator.jl` uses [PyCall.jl](https://github.com/JuliaPy/PyCall.jl) and
[Conda.jl](https://github.com/JuliaPy/Conda.jl) to access `equilibrator_api`
functions. First, ensure that you have installed both `PyCall.jl` and `Conda.jl`
using Julia's package manager:

```
] add PyCall
] add Conda
```

Next, install `equilibrator_api` through `Conda.jl`:

```
using Conda

Conda.add("equilibrator-api"; channel="conda-forge") # note: use a dash and not an underscore in "equilibrator-api"
```

Then test if you can import `equilibrator_api` using `PyCall.jl`:

```
using PyCall

eq = pyimport("equilibrator_api") # note: use an underscore and not a dash in "equilibrator_api"
```

If no errors occur, and the last command return something like `PyObject <module 'equilibrator_api' from...`
then you will be able to use `eQuilibrator.jl` after installing it:

```
] add eQuilibrator
```

Finally, test if everything works as expected:
```
] test eQuilibrator
```
