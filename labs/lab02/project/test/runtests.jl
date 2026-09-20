using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using Lab02DataTypes
using Test

@testset "Множества" begin
    result = set_task()
    @test result.P == Set([0, 1, 3, 4, 7, 9])
    @test result.examples.membership
end

@testset "Массивы" begin
    result = array_tasks()
    @test result.ascending == collect(1:25)
    @test result.descending == collect(25:-1:1)
    @test length(result.there_and_back) == 49
    @test count(==(4), result.counts_11_10_10) == 11
    @test count(==(6), result.counts_11_10_10) == 10
    @test count(==(3), result.counts_11_10_10) == 10
    @test result.powers == [16, 64, 8, 8, 8, 8]
    @test result.six_digits == 2
    @test length(result.power_pairs) == 12
    @test result.filenames[end] == "fn30"
end

@testset "Случайные векторы" begin
    result = random_vector_tasks()
    @test length(result.x) == 250
    @test length(result.differences) == 249
    @test length(result.linear_combination) == 248
    @test result.even_count + result.odd_count == 250
    @test result.x_sorted_by_y == result.x[sortperm(result.y)]
    @test issorted(result.x_top_10; rev=true)
end

@testset "Квадраты, простые числа и суммы" begin
    sequences = squares_and_primes()
    sums = sums_task()
    @test sequences.squares[[1, 100]] == [1, 10_000]
    @test sequences.prime_89 == 461
    @test sequences.primes_89_to_99 == [461, 463, 467, 479, 487, 491,
                                        499, 503, 509, 521, 523]
    @test sums.sum_6_1 == 26_852_735
    @test length(sums.terms_6_3) == 20
end

@testset "Структура и производные материалы" begin
    project = normpath(joinpath(@__DIR__, ".."))
    @test isdir(joinpath(project, "data"))
    @test isdir(joinpath(project, "generated"))
    @test isdir(joinpath(project, "plots"))
    @test isfile(joinpath(project, "scripts", "lab02_literate.jl"))
    @test isfile(joinpath(project, "scripts", "generate_outputs.jl"))
    @test isfile(joinpath(project, "generated", "lab02_code.jl"))
    @test isfile(joinpath(project, "generated", "lab02_notebook.ipynb"))
    @test isfile(joinpath(project, "generated", "lab02_quarto.qmd"))
    @test isfile(joinpath(project, "generated", "lab02_quarto.html"))
end
