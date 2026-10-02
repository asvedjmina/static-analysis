using DrWatson
@quickactivate "Lab03ControlStructures"

using Lab03ControlStructures

println("Лабораторная работа № 3 — краткий запуск всех заданий")
println("1. squares_arr[100] = ", squares_with_for().squares_arr[100])
println("2. Проверка 7 и 8: ", (even_or_odd(7), even_or_odd_ternary(8)))
println("3. add_one(41) = ", add_one(41))
println("4. Матрица 3×4:")
display(increasing_matrix())
println("5. A³:")
display(matrix_power_task().A_cubed)
println("6. BᵀB:")
display(matrix_product_task().C)
patterns = pattern_matrices()
println("7. Z1–Z4 построены: ",
        [size(getproperty(patterns, name)) for name in (:Z1, :Z2, :Z3, :Z4)])
outer_result = outer_matrices()
println("8. A1–A5 построены: ",
        [size(getproperty(outer_result, name)) for name in propertynames(outer_result)])
println("9. x = ", structured_system().x)
random_result = random_matrix_task()
println("10. Числа > 4 по строкам: ", random_result.greater_counts)
println("10. Подходящие пары столбцов: ", random_result.qualifying_pairs)
println("11. Двойные суммы: ", nested_sums())
