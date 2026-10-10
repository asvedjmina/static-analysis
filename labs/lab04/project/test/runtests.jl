using DrWatson
using LinearAlgebra
using Test

@quickactivate "project"
include(srcdir("lab04.jl"))
using .Lab04

@testset "Точные решения СЛАУ" begin
    unique_solution = solve_exact([1 1; 1 -1], [2, 3])
    @test unique_solution.kind == :unique
    @test unique_solution.particular == [5//2, -1//2]

    infinite_solution = solve_exact([1 1; 2 2], [2, 4])
    @test infinite_solution.kind == :infinite
    @test length(infinite_solution.null_basis) == 1

    inconsistent = solve_exact([1 1; 2 2], [2, 5])
    @test inconsistent.kind == :inconsistent
end

@testset "Матричные функции" begin
    matrix = [5 -2; -2 5]
    root = matrix_function_symmetric(matrix, sqrt)
    @test root * root ≈ matrix atol=1e-12

    cube_matrix = [1 -2; -2 1]
    cube_root = matrix_function_symmetric(cube_matrix, cbrt)
    @test cube_root^3 ≈ cube_matrix atol=1e-12
end

@testset "Продуктивность" begin
    productive, inverse_matrix = productivity_by_inverse([0.1 0.2; 0.3 0.4])
    @test productive
    @test all(inverse_matrix .>= -1e-12)
end

@testset "Структура проекта" begin
    @test isfile(scriptsdir("lab04_literate.jl"))
    @test isfile(scriptsdir("generate_notebook.jl"))
    @test isfile(scriptsdir("generate_outputs.jl"))
    @test isfile(scriptsdir("run_task.jl"))
    @test isfile(srcdir("lab04.jl"))
end
