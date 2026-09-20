#!/usr/bin/env julia

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using Literate

const PROJECT_DIRECTORY = normpath(joinpath(@__DIR__, ".."))
const SOURCE_FILE = joinpath(@__DIR__, "lab02_literate.jl")
const OUTPUT_DIRECTORY = joinpath(PROJECT_DIRECTORY, "generated")
const QUARTO_HEADER = """---
title: "Лабораторная работа № 2. Структуры данных"
format: html
execute:
  enabled: false
  echo: true
---

"""

mkpath(OUTPUT_DIRECTORY)

script_path = Literate.script(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab02_code",
    credit=false,
)

notebook_path = Literate.notebook(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab02_notebook",
    execute=true,
    credit=false,
)

quarto_path = Literate.markdown(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab02_quarto",
    flavor=Literate.QuartoFlavor(),
    postprocess=content -> QUARTO_HEADER * content,
    credit=false,
)

quarto = Sys.which("quarto")
isnothing(quarto) && error("Quarto не найден в PATH")
run(`$quarto render $quarto_path --to html`)

println("Сгенерирован чистый код: ", script_path)
println("Сгенерирован notebook: ", notebook_path)
println("Сгенерирован Quarto-документ: ", quarto_path)
println("Сгенерирован HTML: ", replace(quarto_path, r"\.qmd$" => ".html"))

