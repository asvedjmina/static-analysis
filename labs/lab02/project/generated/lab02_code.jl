using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using Lab02DataTypes
using Primes
using Random
using Statistics

empty_tuple = ()
favorite_languages = ("Python", "Julia", "R")
x1 = (1, 2, 3)
x2 = (1, 2.0, "tmp")
x3 = (a=2, b=1 + 2)

println("Пуст ли кортеж: ", isempty(empty_tuple))
println("Длина x2: ", length(x2))
println("Элементы x2: ", (x2[1], x2[2], x2[3]))
println("x1[2] + x1[3] = ", x1[2] + x1[3])
println("Именованный кортеж: ", (x3.a, x3.b, x3[2]))
println("Вхождение: ", (in("tmp", x2), 0 in x2))
println("Уникальные: ", unique((1, 2, 1, 3)))
println("Свёртка и максимум: ", (reduce(+, x1), maximum(x1)))

phonebook = Dict(
    "Иванов И.И." => ("867-5309", "333-5544"),
    "Бухгалтерия" => "555-2368",
)
println("Ключи: ", collect(keys(phonebook)))
println("Значения: ", collect(values(phonebook)))
println("Пары: ", collect(pairs(phonebook)))
println("Есть Иванов И.И.: ", haskey(phonebook, "Иванов И.И."))
phonebook["Сидоров П.С."] = "555-3344"
removed_phone = pop!(phonebook, "Иванов И.И.")
println("Удалённое значение: ", removed_phone)

dict_a = Dict("foo" => 0.0, "bar" => 42.0)
dict_b = Dict("baz" => 17, "bar" => 13.0)
println("merge(a, b): ", merge(dict_a, dict_b))
println("merge(b, a): ", merge(dict_b, dict_a))

S1 = Set([1, 2])
S2 = Set([3, 4])
S3 = Set([1, 2, 2, 3, 1, 2, 3, 2, 1])
S4 = Set([2, 3, 1])

println("Эквивалентность S1 и S2: ", issetequal(S1, S2))
println("Эквивалентность S3 и S4: ", issetequal(S3, S4))
println("Объединение: ", union(S1, S2))
println("Пересечение: ", intersect(S1, S3))
println("Разность: ", setdiff(S3, S1))
println("Включение: ", issubset(S1, S4))
push!(S4, 99)
println("После push!: ", S4)

empty_array_1 = []
empty_array_2 = Int64[]
empty_array_3 = Float64[]
column_vector = [1, 2, 3]
row_vector = [1 2 3]
matrix_A = [[1, 2, 3] [4, 5, 6] [7, 8, 9]]
matrix_B = [[1 2 3]; [4 5 6]; [7 8 9]]

println("Вектор-столбец: ", column_vector)
println("Вектор-строка: ", row_vector)
display(matrix_A)
display(matrix_B)

rng = MersenneTwister(2026)
println("Случайный массив 1×8: ", rand(rng, 1, 8))
println("Случайный массив 2×3: ", rand(rng, 2, 3))
println("Размер массива 4×3×2: ", size(rand(rng, 4, 3, 2)))

roots = [sqrt(i) for i in 1:10]
ar_1 = [3i^2 for i in 1:2:9]
ar_2 = [i^2 for i in 1:10 if i^2 % 5 != 0 && i^2 % 4 != 0]
println("Корни: ", roots)
println("3i²: ", ar_1)
println("Квадраты по условию: ", ar_2)

base = collect(1:12)
reshaped = reshape(base, (2, 6))
ar = rand(rng, 10:20, 10, 5)
println("length, ndims, size: ", (length(ar), ndims(ar), size(ar)))
println("ones: ", ones(2, 3))
println("zeros: ", zeros(4))
println("fill: ", fill(3.5, (3, 2)))
println("repeat: ", repeat([1, 2], 3, 3))
display(reshaped)
display(transpose(reshaped))
println("Второй столбец: ", ar[:, 2])
println("Столбцы 2 и 5: ", ar[:, [2, 5]])
println("Столбцы 2:4: ", ar[:, 2:4])
println("Выбранные строки и столбцы: ", ar[[2, 4, 6], [1, 5]])
println("Срез первой строки: ", ar[1, 3:end])
display(sort(ar, dims=1))
display(sort(ar, dims=2))
display(ar .> 14)
println("Индексы значений > 14: ", findall(ar .> 14))

sets = set_task()
println("P = ", sort(collect(sets.P)))
println("Операции над множествами разных типов: ", sets.examples)

arrays = array_tasks(N=25)
println("3.1: ", arrays.ascending)
println("3.2: ", arrays.descending)
println("3.3: ", arrays.there_and_back)
println("3.4: ", arrays.tmp)
println("3.5: ", arrays.first_ten)
println("3.6: ", arrays.all_ten)
println("3.7: ", arrays.counts_11_10_10)
println("3.8: ", arrays.blocks_10_20_30)
println("3.9: ", arrays.powers)
println("Количество цифр 6: ", arrays.six_digits)
println("3.10, y: ", arrays.y_grid)
println("Среднее y: ", arrays.y_mean)
println("3.11: ", arrays.power_pairs)
println("3.12: ", arrays.ratio_powers)
println("3.13: ", arrays.filenames)

randoms = random_vector_tasks(seed=2026, n=250)
println("Вектор разностей: ", randoms.differences)
println("Линейная комбинация: ", randoms.linear_combination)
println("Тригонометрические отношения: ", randoms.trig_ratios)
println("Сумма: ", randoms.weighted_sum)
println("y > 600: ", randoms.y_over_600)
println("Индексы y > 600: ", randoms.over_600_indices)
println("Соответствующие x: ", randoms.corresponding_x)
println("Корни отклонений: ", randoms.deviations)
println("Не далее 200 от max(y): ", randoms.near_max_count)
println("Чётных/нечётных: ", (randoms.even_count, randoms.odd_count))
println("Кратных 7: ", randoms.multiples_of_7)
println("x по возрастанию y: ", randoms.x_sorted_by_y)
println("top-10 x: ", randoms.x_top_10)
println("Уникальные x: ", randoms.unique_x)

sequences = squares_and_primes()
println("Квадраты 1:100: ", sequences.squares)
println("Первые 168 простых: ", sequences.myprimes)
println("89-е простое: ", sequences.prime_89)
println("Простые 89:99: ", sequences.primes_89_to_99)

sums = sums_task(M=25)
println("6.1: ", sums.sum_6_1)
println("6.2: ", sums.sum_6_2)
println("Члены 6.3: ", sums.terms_6_3)
println("6.3: ", sums.sum_6_3)
