using Lab03ControlStructures
using LinearAlgebra
using Test

@testset "Задание 1: циклы" begin
    while_result = squares_with_while()
    for_result = squares_with_for()
    @test while_result == for_result
    @test length(for_result.numbers_and_squares) == 100
    @test for_result.numbers_and_squares[[1, 100]] == [(1, 1), (100, 10_000)]
    @test for_result.squares[37] == 1369
    @test for_result.squares_arr == [number^2 for number in 1:100]
    @test_throws ArgumentError squares_with_while(limit=0)
end

@testset "Задания 2–4: условия и функции" begin
    @test even_or_odd(8) == 8
    @test even_or_odd(7) == "нечётное"
    @test even_or_odd_ternary(8) == 8
    @test even_or_odd_ternary(7) == "нечётное"
    @test add_one(41) == 42
    @test increasing_matrix(3, 4) == [1 2 3 4; 5 6 7 8; 9 10 11 12]
end

@testset "Задания 5–7: матрицы" begin
    power_result = matrix_power_task()
    @test power_result.A_cubed == power_result.A * power_result.A * power_result.A
    @test power_result.A_modified == [1 1 4; 5 2 8; -2 -1 -4]
    @test power_result.A == [1 1 3; 5 2 6; -2 -1 -3]

    product_result = matrix_product_task()
    @test size(product_result.B) == (15, 3)
    @test all(product_result.B[:, 1] .== 10)
    @test all(product_result.B[:, 2] .== -10)
    @test all(product_result.B[:, 3] .== 10)
    @test product_result.C == [1500 -1500 1500; -1500 1500 -1500; 1500 -1500 1500]

    result = pattern_matrices()
    @test result.Z == zeros(Int, 6, 6)
    @test result.E == ones(Int, 6, 6)
    @test result.Z1 == [
        0 1 0 0 0 0;
        1 0 1 0 0 0;
        0 1 0 1 0 0;
        0 0 1 0 1 0;
        0 0 0 1 0 1;
        0 0 0 0 1 0
    ]
    @test result.Z2 == [
        1 0 1 0 0 0;
        0 1 0 1 0 0;
        1 0 1 0 1 0;
        0 1 0 1 0 1;
        0 0 1 0 1 0;
        0 0 0 1 0 1
    ]
    @test result.Z3 == reverse(result.Z2; dims=2)
    @test result.Z4 == [iseven(row + column) for row in 1:6, column in 1:6]
end

@testset "Задание 8: outer" begin
    A = [1 2 3; 4 5 6]
    B = [7 8; 9 10; 11 12]
    @test outer(A, B, *) == A * B
    @test outer([1, 2], [10, 20, 30], +) == [11 21 31; 12 22 32]
    @test_throws DimensionMismatch outer(ones(2, 3), ones(2, 2), *)

    result = outer_matrices()
    @test result.A1 == [row + column for row in 0:4, column in 0:4]
    @test result.A2 == [row^power for row in 0:4, power in 1:5]
    @test result.A3 == [mod(row + column, 5) for row in 0:4, column in 0:4]
    @test result.A4 == [mod(row + column, 10) for row in 0:9, column in 0:9]
    @test result.A5 == [mod(row - column, 9) for row in 0:8, column in 0:8]
end

@testset "Задания 9–11" begin
    system_result = structured_system()
    @test system_result.A == [abs(row - column) + 1 for row in 1:5, column in 1:5]
    @test system_result.x ≈ [-2, 3, 5, 2, -4]
    @test system_result.A * system_result.x ≈ system_result.y

    random_result = random_matrix_task()
    @test size(random_result.M) == (6, 10)
    @test all(1 .<= random_result.M .<= 10)
    @test random_result.greater_counts == vec(sum(random_result.M .> 4; dims=2))
    @test random_result.matching_rows == findall(vec(sum(random_result.M .== 7; dims=2)) .== 2)
    @test all(pair -> pair.sum > 75, random_result.qualifying_pairs)
    @test all(pair -> pair.sum == sum(random_result.M[:, collect(pair.columns)]),
              random_result.qualifying_pairs)

    sums = nested_sums()
    @test sums.first_sum == sum(big(i)^4 // big(3 + j) for i in 1:20 for j in 1:5)
    @test sums.second_sum == sum(big(i)^4 // big(3 + i * j) for i in 1:20 for j in 1:5)
end

@testset "Структура и производные материалы" begin
    project = normpath(joinpath(@__DIR__, ".."))
    @test isdir(joinpath(project, "data"))
    @test isdir(joinpath(project, "generated"))
    @test isdir(joinpath(project, "plots"))
    @test isfile(joinpath(project, "scripts", "lab03_literate.jl"))
    @test isfile(joinpath(project, "scripts", "generate_outputs.jl"))
    @test isfile(joinpath(project, "generated", "lab03_code.jl"))
    @test isfile(joinpath(project, "generated", "lab03_control_structures.ipynb"))
    @test isfile(joinpath(project, "generated", "lab03_quarto.qmd"))
    @test isfile(joinpath(project, "generated", "lab03_quarto.html"))
end
