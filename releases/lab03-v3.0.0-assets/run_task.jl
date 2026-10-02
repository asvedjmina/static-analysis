using DrWatson
@quickactivate "Lab03ControlStructures"

using Lab03ControlStructures

function print_help()
    println("Использование: julia --project=project project/scripts/run_task.jl НОМЕР")
    println("Доступные номера: 1, 2, ..., 11")
end

isempty(ARGS) && (print_help(); exit(1))
task = ARGS[1]

if task == "1"
    while_result = squares_with_while()
    for_result = squares_with_for()
    println("Цикл while:")
    pair_index = 1
    while pair_index <= length(while_result.numbers_and_squares)
        number, square = while_result.numbers_and_squares[pair_index]
        println(number, "² = ", square)
        global pair_index += 1
    end
    println("Цикл for:")
    foreach(pair -> println(pair[1], "² = ", pair[2]), for_result.numbers_and_squares)
    println("squares = ", for_result.squares)
    println("squares_arr = ", for_result.squares_arr)
elseif task == "2"
    for number in 1:10
        println(number, " → ", even_or_odd(number), " / ", even_or_odd_ternary(number))
    end
elseif task == "3"
    println("add_one(41) = ", add_one(41))
elseif task == "4"
    display(increasing_matrix())
elseif task == "5"
    result = matrix_power_task()
    println("A ="); display(result.A)
    println("A³ ="); display(result.A_cubed)
    println("Изменённая A ="); display(result.A_modified)
elseif task == "6"
    result = matrix_product_task()
    println("B ="); display(result.B)
    println("BᵀB ="); display(result.C)
elseif task == "7"
    result = pattern_matrices()
    for name in propertynames(result)
        println(name, " ="); display(getproperty(result, name))
    end
elseif task == "8"
    result = outer_matrices()
    for name in propertynames(result)
        println(name, " ="); display(getproperty(result, name))
    end
elseif task == "9"
    result = structured_system()
    println("A ="); display(result.A)
    println("y = ", result.y)
    println("x = ", result.x)
    println("A*x ≈ y: ", result.A * result.x ≈ result.y)
elseif task == "10"
    result = random_matrix_task()
    println("M ="); display(result.M)
    println("Количество > 4: ", result.greater_counts)
    println("Строки с двумя числами 7: ", result.matching_rows)
    println("Суммы столбцов: ", result.column_sums)
    println("Пары столбцов с общей суммой > 75: ", result.qualifying_pairs)
elseif task == "11"
    result = nested_sums()
    println("Первая сумма: ", result.first_sum, " ≈ ", Float64(result.first_sum))
    println("Вторая сумма: ", result.second_sum, " ≈ ", Float64(result.second_sum))
else
    print_help()
    exit(1)
end
