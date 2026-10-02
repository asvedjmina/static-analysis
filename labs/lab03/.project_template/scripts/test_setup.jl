#!/usr/bin/env julia

using DrWatson
@quickactivate "Lab03ControlStructures"

using Colors
using IJulia
using Lab03ControlStructures
using Literate

println("Проверка окружения лабораторной работы № 3")
println("Версия Julia:       ", VERSION)
println("Активный проект:    ", Base.active_project())
println("Имя проекта:        ", projectname())
println("Корень проекта:     ", projectdir())
println("Каталог данных:     ", datadir())
println("Каталог скриптов:   ", scriptsdir())
println("Каталог исходников: ", srcdir())
println("Каталог результатов:", projectdir("generated"))
println("Все обязательные пакеты загружены.")
