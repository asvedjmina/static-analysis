using DrWatson
@quickactivate "project"

ENV["GKSwstype"] = "100"

using BenchmarkTools
using CSV
using DataFrames
using Dates
using DelimitedFiles
using DifferentialEquations
using JLD2
using LinearAlgebra
using Plots

include(srcdir("lab01.jl"))

println("Версия Julia: ", VERSION)
println("Дата выполнения: ", today())
println("Активный проект: ", Base.active_project())
println("Корень проекта: ", projectdir())

values = (3, 3.5, 3 / 3.5, 3 + 4im, pi)

for value in values
    println(repr(value), " имеет тип ", typeof(value))
end

special_values = (Inf, -Inf, NaN, 1.0 / 0.0, 0.0 / 0.0)

for value in special_values
    println(repr(value), " имеет тип ", typeof(value))
end

integer_types = [
    Int8,
    Int16,
    Int32,
    Int64,
    Int128,
    UInt8,
    UInt16,
    UInt32,
    UInt64,
    UInt128,
]

for T in integer_types
    println(lpad(string(T), 7), ": [", typemin(T), ", ", typemax(T), "]")
end

direct_conversion = (Int64(2.0), Char(65))
generic_conversion = (convert(Int64, 2.0), convert(Char, 65))
boolean_conversion = (Bool(1), Bool(0))
promoted = promote(Int8(1), Float16(4.5), Float32(4.1))

println("Прямое преобразование: ", direct_conversion)
println("Преобразование convert: ", generic_conversion)
println("Преобразование Bool: ", boolean_conversion)
println("Результат promote: ", promoted)
println("Типы после promote: ", typeof.(promoted))

function square(x)
    return x^2
end

cube(x) = x^3

println("square(4) = ", square(4))
println("cube(3) = ", cube(3))

row_vector = [4 7 6]
column_vector = [1, 2, 3]

println("Вектор-строка: ", row_vector)
println("Вектор-столбец: ", column_vector)
println("Вторые элементы: ", row_vector[2], ", ", column_vector[2])

a, b, c, d = 1, 2, 3, 4
Am = [a b; c d]

println("Матрица Am:")
display(Am)
println("Элементы Am: ", (Am[1, 1], Am[1, 2], Am[2, 1], Am[2, 2]))

aa = [1 2]
AA = [1 2; 3 4]
println("aa * AA * aa' = ", aa * AA * aa')

print("Вывод print; ")
println("вывод println")
show(stdout, "строка через show")
println()

mkpath(datadir("exp_pro"))
text_file = datadir("exp_pro", "example.txt")
binary_file = datadir("exp_pro", "bytes.bin")
table_file = datadir("exp_pro", "table.csv")

open(text_file, "w") do io
    println(io, "первая строка")
    println(io, "вторая строка")
    println(io, "третья строка")
end

whole_text = read(text_file, String)
println("Результат read(..., String):")
println(whole_text)

open(text_file, "r") do io
    println("Результат readline: ", readline(io))
end

all_lines = readlines(text_file)
println("Результат readlines: ", all_lines)

bytes_written = write(binary_file, UInt8[0x41, 0x42, 0x43, 0x0a])
println("Функция write записала байт: ", bytes_written)
println("Байты после read: ", read(binary_file))

numeric_table = [1.0 2.0 3.0; 4.0 5.0 6.0]
writedlm(table_file, numeric_table, ',')
table_from_file = readdlm(table_file, ',', Float64)
println("Таблица после readdlm:")
display(table_from_file)

println("parse(Int, \"42\") = ", parse(Int, "42"))
println("parse(Float64, \"3.1415\") = ", parse(Float64, "3.1415"))
println("parse(Bool, \"true\") = ", parse(Bool, "true"))
println("Двоичное 1010 = ", parse(Int, "1010"; base=2))
println("Шестнадцатеричное ff = ", parse(Int, "ff"; base=16))
println("tryparse(Int, \"123\") = ", tryparse(Int, "123"))
println("tryparse(Int, \"abc\") = ", tryparse(Int, "abc"))

x = 7
y = 3

println("x + y = ", x + y)
println("x - y = ", x - y)
println("x * y = ", x * y)
println("x / y = ", x / y)
println("div(x, y) = ", div(x, y))
println("rem(x, y) = ", rem(x, y))
println("x^y = ", x^y)
println("sqrt(9.0) = ", sqrt(9.0))
println("sqrt(-1 + 0im) = ", sqrt(-1 + 0im))

println("Сравнения: ", (x > y, x < y, x == y, x != y, x >= y))

p = true
q = false
println("p && q = ", p && q)
println("p || q = ", p || q)
println("!p = ", !p)

v = [1.0, 2.0, 3.0]
w = [4.0, 5.0, 6.0]
A = [1.0 2.0 3.0; 4.0 5.0 6.0; 7.0 8.0 10.0]
B = [2.0 0.0 1.0; 1.0 3.0 2.0; 0.0 1.0 4.0]

println("v + w = ", v + w)
println("v - w = ", v - w)
println("dot(v, w) = ", dot(v, w))
println("transpose(v) = ", transpose(v))
println("2v = ", 2 .* v)
println("A + B =")
display(A + B)
println("A - B =")
display(A - B)
println("A * v = ", A * v)
println("A * B =")
display(A * B)
println("Поэлементное A .* B =")
display(A .* B)

parameters = [0.5, 1.0, 2.0]
parameter_results = [
    calculate_for_parameter(alpha, A, v) for alpha in parameters
]

for result in parameter_results
    println(
        "alpha=", result.alpha,
        ", норма=", round(result.matrix_norm; digits=3),
        ", результат=", result.result,
    )
end

results_table = DataFrame(
    alpha=[result.alpha for result in parameter_results],
    matrix_norm=[result.matrix_norm for result in parameter_results],
    result_1=[result.result[1] for result in parameter_results],
    result_2=[result.result[2] for result in parameter_results],
    result_3=[result.result[3] for result in parameter_results],
)

println("Таблица результатов для набора параметров:")
display(results_table)

csv_file = datadir("exp_pro", "parameter_results.csv")
jld2_file = datadir("sims", "parameter_results.jld2")
CSV.write(csv_file, results_table)
@save jld2_file parameters parameter_results results_table

println("CSV сохранён: ", csv_file)
println("JLD2 сохранён: ", jld2_file)

mkpath(plotsdir())
parameter_plot = plot(
    results_table.alpha,
    results_table.matrix_norm;
    marker=:circle,
    linewidth=2,
    xlabel="alpha",
    ylabel="Норма матрицы",
    label="norm(alpha * A)",
    title="Вычисление для набора параметров",
)
plot_file = plotsdir("parameter_norms.png")
savefig(parameter_plot, plot_file)
println("График сохранён: ", plot_file)

decay!(du, u, parameter, time) = (du[1] = -parameter * u[1])
ode_problem = ODEProblem(decay!, [1.0], (0.0, 5.0), 1.0)
ode_solution = solve(ode_problem, Tsit5(); saveat=1.0)
println("Решение ОДУ в узлах: ", first.(ode_solution.u))

elapsed = @belapsed sum($v)
println("Оценка времени sum(v), секунд: ", elapsed)
