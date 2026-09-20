using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using Lab02DataTypes

function print_help()
    println("Использование: julia --project=labs/lab02/project ",
            "labs/lab02/project/scripts/run_task.jl НОМЕР")
    println("Номера: 1, 2, 3.1–3.14, 4, 5, 6.1, 6.2, 6.3")
end

isempty(ARGS) && (print_help(); exit(1))
task = ARGS[1]

if task == "1"
    result = set_task()
    println("A = ", result.A)
    println("B = ", result.B)
    println("C = ", result.C)
    println("P = ", sort(collect(result.P)))
elseif task == "2"
    println(set_task().examples)
elseif startswith(task, "3.") && task != "3.14"
    result = array_tasks()
    fields = Dict(
        "3.1" => :ascending,
        "3.2" => :descending,
        "3.3" => :there_and_back,
        "3.4" => :tmp,
        "3.5" => :first_ten,
        "3.6" => :all_ten,
        "3.7" => :counts_11_10_10,
        "3.8" => :blocks_10_20_30,
        "3.9" => :powers,
        "3.10" => :y_grid,
        "3.11" => :power_pairs,
        "3.12" => :ratio_powers,
        "3.13" => :filenames,
    )
    haskey(fields, task) || (print_help(); exit(1))
    println(task, ": ", getproperty(result, fields[task]))
    task == "3.9" && println("Количество цифр 6: ", result.six_digits,
                             "; элементов, равных 6: ", result.six_values)
    task == "3.10" && println("Среднее значение y: ", result.y_mean)
elseif task == "3.14"
    result = random_vector_tasks()
    println("x = ", result.x)
    println("y = ", result.y)
    println("y[2:n] - x[1:n-1] = ", result.differences)
    println("Линейная комбинация = ", result.linear_combination)
    println("sin(y[i]) / cos(x[i+1]) = ", result.trig_ratios)
    println("Сумма = ", result.weighted_sum)
    println("y > 600: ", result.y_over_600)
    println("Индексы y > 600: ", result.over_600_indices)
    println("Соответствующие x: ", result.corresponding_x)
    println("Корни отклонений: ", result.deviations)
    println("Не далее 200 от max(y): ", result.near_max_count)
    println("Чётных/нечётных x: ", result.even_count, "/", result.odd_count)
    println("Кратных 7: ", result.multiples_of_7)
    println("x в порядке возрастания y: ", result.x_sorted_by_y)
    println("top-10 x: ", result.x_top_10)
    println("Уникальные x: ", result.unique_x)
elseif task == "4"
    println("squares = ", squares_and_primes().squares)
elseif task == "5"
    result = squares_and_primes()
    println("myprimes = ", result.myprimes)
    println("89-е простое число = ", result.prime_89)
    println("Срез 89:99 = ", result.primes_89_to_99)
elseif task == "6.1"
    println("6.1: ", sums_task().sum_6_1)
elseif task == "6.2"
    println("6.2: ", sums_task().sum_6_2)
elseif task == "6.3"
    result = sums_task()
    println("Члены суммы: ", result.terms_6_3)
    println("6.3: ", result.sum_6_3)
else
    print_help()
    exit(1)
end

