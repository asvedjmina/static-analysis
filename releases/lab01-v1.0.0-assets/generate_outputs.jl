#!/usr/bin/env julia

using DrWatson
@quickactivate "project"

using Literate

const SOURCE_FILE = scriptsdir("lab01_literate.jl")
const OUTPUT_DIRECTORY = projectdir("generated")
const QUARTO_HEADER = """---
title: "Лабораторная работа № 1"
jupyter: julia-1.12
execute:
  echo: true
---

"""

mkpath(OUTPUT_DIRECTORY)

println("Исходный файл: ", SOURCE_FILE)
println("Каталог результатов: ", OUTPUT_DIRECTORY)

script_path = Literate.script(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab01_code",
    credit=false,
)

notebook_path = Literate.notebook(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab01_notebook",
    execute=true,
    credit=false,
)

quarto_path = Literate.markdown(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab01_quarto",
    flavor=Literate.QuartoFlavor(),
    postprocess=content -> QUARTO_HEADER * content,
    credit=false,
)

println()
println("Сгенерирован чистый код: ", script_path)
println("Сгенерирован notebook: ", notebook_path)
println("Сгенерирован Quarto-документ: ", quarto_path)
