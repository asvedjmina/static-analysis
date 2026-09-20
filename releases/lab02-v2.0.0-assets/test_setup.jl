#!/usr/bin/env julia

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using DrWatson
using IJulia
using Lab02DataTypes
using Literate
using Primes

println("Проверка окружения лабораторной работы № 2")
println("Версия Julia:       ", VERSION)
println("Активный проект:    ", Base.active_project())
println("Корень проекта:     ", projectdir())
println("Каталог данных:     ", datadir())
println("Каталог скриптов:   ", scriptsdir())
println("Каталог исходников: ", srcdir())
println("Каталог графиков:   ", plotsdir())
println("Все обязательные пакеты загружены.")

