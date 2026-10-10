#!/usr/bin/env julia

using DrWatson
@quickactivate "project"

if length(ARGS) != 1
    println("Использование: julia --project=. scripts/run_task.jl <номер>")
    println("Пример:       julia --project=. scripts/run_task.jl 4.4.3.2")
    exit(2)
end

ENV["LAB04_TASK"] = only(ARGS)
include(scriptsdir("lab04_literate.jl"))

