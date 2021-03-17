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

deploydocs(
    repo = "github.com/stelmo/Equilibrator.jl.git",
    target = "build",
    branch = "gh-pages",
    devbranch = "main",
    push_preview = true,
)
