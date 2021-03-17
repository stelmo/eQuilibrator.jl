using Documenter, Equilibrator

makedocs(
    modules = [Equilibrator],
    clean = false,
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical = "https://stelmo.github.io/Equilibrator.jl/stable/",
    ),
    sitename = "Equilibrator.jl",
    authors = "The developers of Equilibrator.jl",
    linkcheck = !("skiplinks" in ARGS),
    pages = ["Documentation" => "index.md"],
)

deploydocs(repo = "github.com/USER_NAME/PACKAGE_NAME.jl.git")
