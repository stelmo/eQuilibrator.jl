using Documenter, eQuilibrator

makedocs(
    modules = [eQuilibrator],
    clean = false,
    sitename = "eQuilibrator.jl",
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        assets = ["assets/favicon.ico"],
    ),
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
