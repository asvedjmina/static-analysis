using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using Lab02DataTypes

sets = set_task()
arrays = array_tasks()
randoms = random_vector_tasks()
number_sequences = squares_and_primes()
sums = sums_task()

println("Задание 1, P = ", sort(collect(sets.P)))
println("Задание 3.9, степени: ", arrays.powers,
        "; цифра 6 встречается ", arrays.six_digits, " раза")
println("Задание 3.10, среднее y = ", arrays.y_mean)
println("Задание 3.14, y > 600: ", length(randoms.y_over_600), " элементов")
println("Задание 3.14, чётных/нечётных x: ",
        randoms.even_count, "/", randoms.odd_count)
println("Задание 5, 89-е простое: ", number_sequences.prime_89)
println("Задание 5, элементы 89:99: ", number_sequences.primes_89_to_99)
println("Задание 6.1: ", sums.sum_6_1)
println("Задание 6.2: ", sums.sum_6_2)
println("Задание 6.3: ", sums.sum_6_3)

