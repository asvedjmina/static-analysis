module Lab03ControlStructures

using LinearAlgebra
using Random

export squares_with_while, squares_with_for,
       even_or_odd, even_or_odd_ternary, add_one, increasing_matrix,
       matrix_power_task, matrix_product_task, pattern_matrices,
       outer, outer_matrices, structured_system, random_matrix_task,
       nested_sums

"""Получить числа 1:100, их квадраты, словарь и массив квадратов с помощью `while`."""
function squares_with_while(; limit::Integer=100)
    limit >= 1 || throw(ArgumentError("limit должен быть положительным"))
    numbers_and_squares = Tuple{Int, Int}[]
    squares = Dict{Int, Int}()
    squares_arr = Int[]

    number = 1
    while number <= limit
        square = number^2
        push!(numbers_and_squares, (number, square))
        squares[number] = square
        push!(squares_arr, square)
        number += 1
    end

    return (; numbers_and_squares, squares, squares_arr)
end

"""Получить числа 1:100, их квадраты, словарь и массив квадратов с помощью `for`."""
function squares_with_for(; limit::Integer=100)
    limit >= 1 || throw(ArgumentError("limit должен быть положительным"))
    numbers_and_squares = Tuple{Int, Int}[]
    squares = Dict{Int, Int}()
    squares_arr = Int[]

    for number in 1:limit
        square = number^2
        push!(numbers_and_squares, (number, square))
        squares[number] = square
        push!(squares_arr, square)
    end

    return (; numbers_and_squares, squares, squares_arr)
end

"""Вернуть число, если оно чётное, и строку `нечётное` в противном случае."""
function even_or_odd(number::Integer)
    if iseven(number)
        return number
    else
        return "нечётное"
    end
end

"""Тот же условный выбор, записанный тернарным оператором."""
even_or_odd_ternary(number::Integer) = iseven(number) ? number : "нечётное"

"""Увеличить аргумент на единицу."""
add_one(value) = value + one(value)

"""Создать матрицу последовательных чисел, применив `add_one` через `map`."""
function increasing_matrix(rows::Integer=3, columns::Integer=4)
    rows > 0 && columns > 0 || throw(ArgumentError("размеры должны быть положительными"))
    predecessors = [
        (row - 1) * columns + column - 1
        for row in 1:rows, column in 1:columns
    ]
    return map(add_one, predecessors)
end

"""Вычислить A³ и заменить третий столбец копии A суммой столбцов 2 и 3."""
function matrix_power_task()
    A = [1 1 3; 5 2 6; -2 -1 -3]
    A_cubed = A^3
    A_modified = copy(A)
    A_modified[:, 3] .= A[:, 2] .+ A[:, 3]
    return (; A, A_cubed, A_modified)
end

"""Построить B размера `rows × 3` и вычислить C = BᵀB."""
function matrix_product_task(; rows::Integer=15)
    rows > 0 || throw(ArgumentError("rows должен быть положительным"))
    B = repeat([10 -10 10], rows, 1)
    C = transpose(B) * B
    return (; B, C)
end

"""Построить нулевую, единичную и четыре структурные матрицы размера n × n."""
function pattern_matrices(; n::Integer=6)
    n > 0 || throw(ArgumentError("n должен быть положительным"))
    Z = zeros(Int, n, n)
    E = ones(Int, n, n)
    Z1 = copy(Z)
    Z2 = copy(Z)
    Z3 = copy(Z)
    Z4 = copy(Z)

    for row in 1:n, column in 1:n
        Z1[row, column] = abs(row - column) == 1
        Z2[row, column] = abs(row - column) in (0, 2)
        Z3[row, column] = abs(row - (n - column + 1)) in (0, 2)
        Z4[row, column] = iseven(row + column)
    end

    return (; Z, E, Z1, Z2, Z3, Z4)
end

"""
    outer(x, y, operation)

Применить `operation` ко всем парам элементов векторов `x` и `y`, как `outer()` в R.
"""
function outer(x::AbstractVector, y::AbstractVector, operation::Function)
    return [operation(left, right) for left in x, right in y]
end

"""
    outer(A, B, operation)

Обобщить матричное произведение: `operation` заменяет умножение, а результаты по
общему индексу складываются. Поэтому `outer(A, B, *) == A * B`.
"""
function outer(A::AbstractMatrix, B::AbstractMatrix, operation::Function)
    size(A, 2) == size(B, 1) || throw(DimensionMismatch(
        "число столбцов A должно совпадать с числом строк B",
    ))
    common = axes(A, 2)
    return [sum(operation(A[row, k], B[k, column]) for k in common)
            for row in axes(A, 1), column in axes(B, 2)]
end

"""Создать пять матриц задания 8 посредством `outer`."""
function outer_matrices(; n_small::Integer=5, n_large::Integer=10, n_shift::Integer=9)
    n_small > 0 && n_large > 0 && n_shift > 0 ||
        throw(ArgumentError("размеры должны быть положительными"))

    small = collect(0:(n_small - 1))
    large = collect(0:(n_large - 1))
    shifted = collect(0:(n_shift - 1))

    A1 = outer(small, small, +)
    A2 = outer(small, collect(1:n_small), ^)
    A3 = outer(small, small, (left, right) -> mod(left + right, n_small))
    A4 = outer(large, large, (left, right) -> mod(left + right, n_large))
    A5 = outer(shifted, shifted, (left, right) -> mod(left - right, n_shift))

    return (; A1, A2, A3, A4, A5)
end

"""Построить структурную матрицу Aᵢⱼ=|i-j|+1 и решить Ax=y."""
function structured_system(; y::AbstractVector=[7, -1, -3, 5, 17])
    n = length(y)
    n > 0 || throw(ArgumentError("вектор правой части не должен быть пустым"))
    A = [abs(row - column) + 1 for row in 1:n, column in 1:n]
    x = A \ y
    return (; A, y=collect(y), x)
end

"""Выполнить три запроса задания 10 для воспроизводимой случайной матрицы."""
function random_matrix_task(;
    seed::Integer=2026,
    rows::Integer=6,
    columns::Integer=10,
    threshold::Integer=4,
    target::Integer=7,
    target_count::Integer=2,
    pair_threshold::Integer=75,
)
    rows > 0 && columns > 1 || throw(ArgumentError(
        "требуются положительное число строк и не менее двух столбцов",
    ))
    rng = MersenneTwister(seed)
    M = rand(rng, 1:10, rows, columns)

    greater_counts = vec(sum(M .> threshold; dims=2))
    matching_rows = findall(vec(sum(M .== target; dims=2)) .== target_count)
    column_sums = vec(sum(M; dims=1))
    qualifying_pairs = [
        (columns=(first_column, second_column),
         sum=column_sums[first_column] + column_sums[second_column])
        for first_column in 1:(columns - 1)
        for second_column in (first_column + 1):columns
        if column_sums[first_column] + column_sums[second_column] > pair_threshold
    ]

    return (; M, greater_counts, matching_rows, column_sums, qualifying_pairs)
end

"""Вычислить обе двойные суммы задания 11 точно, как рациональные числа."""
function nested_sums(; max_i::Integer=20, max_j::Integer=5)
    max_i > 0 && max_j > 0 || throw(ArgumentError("границы должны быть положительными"))
    # BigInt предотвращает переполнение при приведении дробей к общему знаменателю.
    first_sum = sum(big(i)^4 // big(3 + j) for i in 1:max_i for j in 1:max_j)
    second_sum = sum(big(i)^4 // big(3 + i * j) for i in 1:max_i for j in 1:max_j)
    return (; first_sum, second_sum)
end

end
