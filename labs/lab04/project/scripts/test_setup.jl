#!/usr/bin/env julia

using DrWatson
@quickactivate "project"

println("Проверка окружения лабораторной работы № 4")
println(repeat("=", 52))
println("Версия Julia:    ", VERSION)
println("Активный проект: ", Base.active_project())
println("Корень проекта:  ", projectdir())
println("Каталог scripts: ", scriptsdir())
println("Каталог src:     ", srcdir())
println("Quarto CLI:      ", something(Sys.which("quarto"), "не найден"))
println("Jupyter:         ", something(Sys.which("jupyter"), "не найден"))

required_packages = ["DrWatson", "BenchmarkTools", "IJulia", "Literate"]
failed_packages = String[]

println("\nПроверка пакетов:")
for package in required_packages
    try
        Base.eval(Main, Meta.parse("using $package"))
        println("  [OK] ", package)
    catch error
        push!(failed_packages, package)
        println("  [ОШИБКА] ", package, ": ", sprint(showerror, error))
    end
end

if isempty(failed_packages)
    if isnothing(Sys.which("jupyter")) || isnothing(Sys.which("quarto"))
        println("\nПакеты Julia доступны, но для всех форматов нужны Jupyter и Quarto CLI.")
        exit(1)
    end
    println("\nПроверка завершена успешно: окружение готово.")
else
    println("\nНе удалось загрузить: ", join(failed_packages, ", "))
    println("Выполните: julia --project=. add_packages.jl")
    exit(1)
end

