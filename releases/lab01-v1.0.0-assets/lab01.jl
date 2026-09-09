using LinearAlgebra

"""
    calculate_for_parameter(alpha, matrix, vector)

Масштабировать матрицу на `alpha`, умножить её на вектор и вернуть параметр,
норму масштабированной матрицы и результирующий вектор.
"""
function calculate_for_parameter(alpha, matrix, vector)
    scaled_matrix = alpha .* matrix
    result_vector = scaled_matrix * vector
    return (
        alpha=alpha,
        matrix_norm=norm(scaled_matrix),
        result=result_vector,
    )
end
