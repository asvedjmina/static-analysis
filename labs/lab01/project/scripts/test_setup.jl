#!/usr/bin/env julia

using DrWatson
@quickactivate "project"

println("Проверка рабочего окружения лабораторной работы № 1")
println(repeat("=", 58))
println("Версия Julia:    ", VERSION)
println("Активный проект: ", Base.active_project())
println("Корень проекта:  ", projectdir())
println("Каталог данных:  ", datadir())
println("Каталог скриптов:", scriptsdir())
println("Каталог исходников: ", srcdir())
println("Каталог графиков:   ", plotsdir())

required_packages = [
    "DrWatson",
    "DifferentialEquations",
    "Plots",
    "DataFrames",
    "CSV",
    "JLD2",
    "Literate",
    "IJulia",
    "BenchmarkTools",
    "Quarto",
]

failed_packages = String[]

println()
println("Проверка пакетов:")

for package in required_packages
    try
        Base.eval(Main, Meta.parse("using $package"))
        println("  [OK]     ", package)
    catch error
        push!(failed_packages, package)
        println("  [ОШИБКА] ", package)
        println("           ", sprint(showerror, error))
    end
end

println()

if isempty(failed_packages)
    println("Проверка завершена успешно: все пакеты доступны.")
else
    println("Не удалось загрузить пакеты: ", join(failed_packages, ", "))
    println("Установите их командой:")
    println("julia --project=. add_packages.jl")
    exit(1)
end
