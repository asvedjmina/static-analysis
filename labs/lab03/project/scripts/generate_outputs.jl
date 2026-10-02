#!/usr/bin/env julia

using DrWatson
@quickactivate "Lab03ControlStructures"

using Literate

const PROJECT_DIRECTORY = projectdir()
const SOURCE_FILE = scriptsdir("lab03_literate.jl")
const OUTPUT_DIRECTORY = projectdir("generated")
const QUARTO_HEADER = """---
title: "Лабораторная работа № 3. Управляющие структуры"
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
    name="lab03_code",
    credit=false,
)

notebook_path = Literate.notebook(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab03_control_structures",
    execute=true,
    credit=false,
)

quarto_path = Literate.markdown(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab03_quarto",
    flavor=Literate.QuartoFlavor(),
    postprocess=content -> QUARTO_HEADER * content,
    credit=false,
)

quarto = Sys.which("quarto")
isnothing(quarto) && error("Quarto не найден в PATH")
run(`$quarto render $quarto_path --to html`)

println("Сгенерирован чистый код: ", script_path)
println("Сгенерирован и выполнен notebook: ", notebook_path)
println("Сгенерирован Quarto-документ: ", quarto_path)
println("Сгенерирован HTML: ", replace(quarto_path, r"\.qmd$" => ".html"))
