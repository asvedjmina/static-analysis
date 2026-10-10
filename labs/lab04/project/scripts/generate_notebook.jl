#!/usr/bin/env julia

using DrWatson
@quickactivate "project"
using Literate

const SOURCE_FILE = scriptsdir("lab04_literate.jl")
const OUTPUT_DIRECTORY = projectdir("notebooks")

mkpath(OUTPUT_DIRECTORY)
notebook = Literate.notebook(
    SOURCE_FILE,
    OUTPUT_DIRECTORY;
    name="lab04",
    execute=false,
    credit=false,
)

println("Jupyter Notebook создан: ", notebook)
println("Откройте его в JupyterLab и выполните Kernel → Restart Kernel and Run All Cells.")
