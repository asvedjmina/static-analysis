#!/usr/bin/env julia

using DrWatson

const LAB_DIRECTORY = @__DIR__
const PROJECT_DIRECTORY = joinpath(LAB_DIRECTORY, "project")
const TEMPLATE_DIRECTORY = joinpath(LAB_DIRECTORY, ".project_template")

ispath(PROJECT_DIRECTORY) && error(
    "Каталог project уже существует. Для повторного создания сначала сохраните " *
    "нужные результаты и удалите этот каталог вручную.",
)
isdir(TEMPLATE_DIRECTORY) || error("Не найден шаблон лабораторной: $TEMPLATE_DIRECTORY")

# DrWatson действительно создаёт новый проект и стандартную структуру каталогов.
initialize_project(
    PROJECT_DIRECTORY,
    "Lab03ControlStructures";
    authors=["Ведьмина Александра Сергеевна"],
    git=false,
    readme=false,
    placeholder=false,
    add_test=false,
)

# После создания дополняем каркас подготовленными исходниками лабораторной.
for entry in readdir(TEMPLATE_DIRECTORY)
    source = joinpath(TEMPLATE_DIRECTORY, entry)
    destination = joinpath(PROJECT_DIRECTORY, entry)
    cp(source, destination; force=true)
end

println("Проект DrWatson создан: ", PROJECT_DIRECTORY)
