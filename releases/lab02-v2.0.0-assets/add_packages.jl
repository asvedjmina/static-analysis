#!/usr/bin/env julia

using Pkg

Pkg.activate(@__DIR__)
Pkg.instantiate()
Pkg.precompile()

println("Зависимости лабораторной работы № 2 установлены.")
Pkg.status()

