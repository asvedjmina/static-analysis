#!/usr/bin/env julia

using Pkg
using Downloads

const PROJECT_DIRECTORY = @__DIR__

# Медленные соединения и некоторые прокси могут не передавать данные дольше
# стандартных 20 секунд. Увеличиваем этот интервал, но не отключаем контроль
# полностью, чтобы зависшая загрузка всё же завершилась ошибкой.
const DOWNLOADER = Downloads.Downloader()
DOWNLOADER.easy_hook = function (easy, info)
    Downloads.Curl.setopt(
        easy,
        Downloads.Curl.CURLOPT_LOW_SPEED_TIME,
        120,
    )
    Downloads.Curl.setopt(
        easy,
        Downloads.Curl.CURLOPT_LOW_SPEED_LIMIT,
        1,
    )
end
Downloads.default_downloader!(DOWNLOADER)

# Не делим пропускную способность между восемью загрузками одновременно.
ENV["JULIA_PKG_CONCURRENT_DOWNLOADS"] = "2"

Pkg.activate(PROJECT_DIRECTORY)

const REQUIRED_PACKAGES = [
    "DataFrames",
    "CSV",
    "JLD2",
    "Literate",
    "IJulia",
    "BenchmarkTools",
    "Quarto",
    "DifferentialEquations",
    "Plots",
]

println("Активное окружение: ", Base.active_project())
println("Устанавливаемые пакеты: ", join(REQUIRED_PACKAGES, ", "))
println("Параллельных загрузок: ", ENV["JULIA_PKG_CONCURRENT_DOWNLOADS"])
println("Порог ожидания медленного соединения: 120 секунд")
println()

failed_packages = String[]

for package in REQUIRED_PACKAGES
    println()
    println("Установка пакета: ", package)
    try
        Pkg.add(package)
        println("Установлен: ", package)
    catch error
        push!(failed_packages, package)
        println("Не удалось установить ", package)
        println(sprint(showerror, error))
    end
end

if !isempty(failed_packages)
    println()
    println("Не удалось установить: ", join(failed_packages, ", "))
    println("Повторно запустите этот же скрипт после проверки сети.")
    exit(1)
end

Pkg.instantiate()

# IJulia должна знать путь к уже установленному Jupyter. Иначе пакет может
# установиться, но его предварительная компиляция завершится сообщением
# `IJulia not properly installed`.
jupyter = Sys.which("jupyter")
if isnothing(jupyter)
    error("Jupyter не найден в PATH. Сначала установите Jupyter.")
end
ENV["JUPYTER"] = jupyter
println("Настройка IJulia для Jupyter: ", jupyter)
Pkg.build("IJulia")

Pkg.precompile()

println()
println("Установленные зависимости проекта:")
Pkg.status()
println()
println("Установка завершена. Теперь выполните:")
println("julia --project=. scripts/test_setup.jl")
