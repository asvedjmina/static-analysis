#!/usr/bin/env julia

using DrWatson

const LAB_DIRECTORY = @__DIR__
const PROJECT_DIRECTORY = joinpath(LAB_DIRECTORY, "project")
const PROJECT_FILE = joinpath(PROJECT_DIRECTORY, "Project.toml")

if isfile(PROJECT_FILE)
    println("Проект DrWatson уже существует:")
    println(PROJECT_DIRECTORY)
    println("Существующие файлы не изменены.")
elseif ispath(PROJECT_DIRECTORY)
    error(
        "Каталог project существует, но Project.toml в нём не найден. " *
        "Проверьте содержимое каталога вручную: $PROJECT_DIRECTORY",
    )
else
    initialize_project(
        PROJECT_DIRECTORY;
        authors=["Ведьмина Александра Сергеевна"],
        git=false,
        placeholder=true,
    )

    println("Проект DrWatson создан:")
    println(PROJECT_DIRECTORY)
end

println()
println("Следующий шаг:")
println("cd ", PROJECT_DIRECTORY)
