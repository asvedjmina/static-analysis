#!/usr/bin/env julia

using Pkg

const PROJECT_DIRECTORY = @__DIR__
Pkg.activate(PROJECT_DIRECTORY)

const REQUIRED_PACKAGES = ["BenchmarkTools", "IJulia", "Literate"]

println("Активное окружение: ", Base.active_project())
println("Устанавливаемые пакеты: ", join(REQUIRED_PACKAGES, ", "))
Pkg.add(REQUIRED_PACKAGES)
Pkg.instantiate()

jupyter = Sys.which("jupyter")
if isnothing(jupyter)
    @warn "Jupyter не найден в PATH. Пакеты установлены, но IJulia не настроена."
else
    ENV["JUPYTER"] = jupyter
    println("Настройка IJulia для Jupyter: ", jupyter)
    Pkg.build("IJulia")
end

Pkg.precompile()
Pkg.status()
println("Установка завершена.")

