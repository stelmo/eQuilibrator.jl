using Documenter, Equilibrator

makedocs(
    modules = [Equilibrator],
    clean = false,
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        assets = ["assets/favicon.ico"],
    ),
    sitename = "eQuilibrator.jl",
    authors = "The developers of eQuilibrator.jl",
    linkcheck = !("skiplinks" in ARGS),
    pages = ["Documentation" => "index.md"],
)

deploydocs(
    repo = "github.com/stelmo/eQuilibrator.jl.git",
    target = "build",
    branch = "gh-pages",
    devbranch = "main",
    push_preview = true,
)
