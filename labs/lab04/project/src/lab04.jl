module Lab04

using LinearAlgebra

export matrix_function_symmetric, productivity_by_inverse, rref_exact, solve_exact

"""Привести матрицу рациональных чисел к приведённому ступенчатому виду."""
function rref_exact(matrix::AbstractMatrix)
    result = Rational{BigInt}.(matrix)
    rows, columns = size(result)
    pivot_row = 1

    for column in 1:columns
        pivot_row > rows && break
        candidate = findfirst(row -> !iszero(result[row, column]), pivot_row:rows)
        isnothing(candidate) && continue
        selected_row = pivot_row + candidate - 1

        if selected_row != pivot_row
            result[pivot_row, :], result[selected_row, :] =
                copy(result[selected_row, :]), copy(result[pivot_row, :])
        end

        result[pivot_row, :] ./= result[pivot_row, column]
        for row in 1:rows
            row == pivot_row && continue
            factor = result[row, column]
            iszero(factor) || (result[row, :] .-= factor .* result[pivot_row, :])
        end
        pivot_row += 1
    end

    return result
end


"""
    solve_exact(A, b)

Классифицировать СЛАУ и вернуть точное рациональное решение. Для системы с
бесконечным числом решений возвращаются частное решение и базис ядра.
"""
function solve_exact(A::AbstractMatrix, b::AbstractVector)
    size(A, 1) == length(b) || throw(DimensionMismatch("Число уравнений не совпадает"))
    augmented = hcat(Rational{BigInt}.(A), Rational{BigInt}.(b))
    reduced = rref_exact(augmented)
    equations, variables = size(A)

    rank_a = count(row -> any(!iszero, reduced[row, 1:variables]), 1:equations)
    rank_augmented = count(row -> any(!iszero, reduced[row, :]), 1:equations)

    if rank_a < rank_augmented
        return (
            kind=:inconsistent,
            rank_a=rank_a,
            rank_augmented=rank_augmented,
            rref=reduced,
            particular=nothing,
            null_basis=Vector{Vector{Rational{BigInt}}}(),
        )
    end

    pivot_columns = Int[]
    pivot_rows = Int[]
    for row in 1:equations
        column = findfirst(!iszero, reduced[row, 1:variables])
        if !isnothing(column)
            push!(pivot_columns, column)
            push!(pivot_rows, row)
        end
    end

    particular = zeros(Rational{BigInt}, variables)
    for (row, column) in zip(pivot_rows, pivot_columns)
        particular[column] = reduced[row, end]
    end

    free_columns = setdiff(collect(1:variables), pivot_columns)
    null_basis = Vector{Vector{Rational{BigInt}}}()
    for free_column in free_columns
        vector = zeros(Rational{BigInt}, variables)
        vector[free_column] = 1
        for (row, pivot_column) in zip(pivot_rows, pivot_columns)
            vector[pivot_column] = -reduced[row, free_column]
        end
        push!(null_basis, vector)
    end

    kind = rank_a == variables ? :unique : :infinite
    return (
        kind=kind,
        rank_a=rank_a,
        rank_augmented=rank_augmented,
        rref=reduced,
        particular=particular,
        null_basis=null_basis,
    )
end


"""Вычислить функцию от вещественной симметричной матрицы спектральным методом."""
function matrix_function_symmetric(matrix::AbstractMatrix, function_on_values)
    decomposition = eigen(Symmetric(Float64.(matrix)))
    transformed = function_on_values.(decomposition.values)
    return decomposition.vectors * Diagonal(transformed) * decomposition.vectors'
end


"""Проверить неотрицательность матрицы Леонтьева `(I-A)^(-1)`."""
function productivity_by_inverse(matrix::AbstractMatrix; atol=1e-12)
    coefficients = Matrix{Float64}(matrix)
    leontief_inverse = inv(I - coefficients)
    productive = all(value -> value >= -atol, leontief_inverse)
    return productive, leontief_inverse
end


end


