using DrWatson
using Test

@quickactivate "project"

include(srcdir("lab01.jl"))

println("Starting tests")
ti = time()

@testset "Lab 01 calculations" begin
    matrix = [
        1.0 2.0 3.0
        4.0 5.0 6.0
        7.0 8.0 10.0
    ]
    vector = [1.0, 2.0, 3.0]

    result = calculate_for_parameter(0.5, matrix, vector)

    @test result.alpha == 0.5
    @test result.matrix_norm ≈ 8.717797887081348
    @test result.result ≈ [7.0, 16.0, 26.5]
end

@testset "Project structure" begin
    @test isfile(scriptsdir("lab01_literate.jl"))
    @test isfile(scriptsdir("generate_outputs.jl"))
    @test isdir(datadir())
    @test isdir(plotsdir())
end

ti = time() - ti
println("\nTest took total time of:")
println(round(ti/60, digits = 3), " minutes")
