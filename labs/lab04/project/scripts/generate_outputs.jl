#!/usr/bin/env julia

using DrWatson
@quickactivate "project"
using Literate

const VALID_TASKS = [
    "all",
    "4.2.1", "4.2.2", "4.2.3", "4.2.4", "4.2.5", "4.2.6",
    "4.4.1", "4.4.2.1", "4.4.2.2",
    "4.4.3.1", "4.4.3.2", "4.4.3.3",
    "4.4.4.1", "4.4.4.2", "4.4.4.3",
]

if length(ARGS) > 1
    println("Использование: julia --project=. scripts/generate_outputs.jl [номер|all]")
    exit(2)
end

task = isempty(ARGS) ? "all" : only(ARGS)
task in VALID_TASKS || error(
    "Неизвестное задание '$task'. Доступны: " * join(VALID_TASKS, ", "),
)

slug = replace(task, "." => "_")
base_name = "lab04_" * slug
source = scriptsdir("lab04_literate.jl")
output_directory = projectdir("generated", slug)
selector = "ENV[\"LAB04_TASK\"] = \"$task\"\n\n"

quarto_header = """---
title: "Лабораторная работа № 4 — $task"
jupyter: julia-1.12
execute:
  echo: true
  warning: false
format:
  html:
    toc: true
---

"""

mkpath(output_directory)
preprocess = content -> selector * content

script_path = Literate.script(
    source,
    output_directory;
    name=base_name * "_code",
    preprocess=preprocess,
    credit=false,
)
notebook_path = Literate.notebook(
    source,
    output_directory;
    name=base_name * "_notebook",
    preprocess=preprocess,
    execute=false,
    credit=false,
)
quarto_path = Literate.markdown(
    source,
    output_directory;
    name=base_name * "_quarto",
    flavor=Literate.QuartoFlavor(),
    preprocess=preprocess,
    postprocess=content -> quarto_header * content,
    credit=false,
)

println("Задание:       ", task)
println("Julia-скрипт:  ", script_path)
println("Notebook:      ", notebook_path)
println("Quarto:        ", quarto_path)
println()
println("Запуск скрипта:")
println("julia --project=. ", relpath(script_path, projectdir()))
println()
println("Рендер Quarto:")
println("quarto render ", relpath(quarto_path, projectdir()), " --to html")
