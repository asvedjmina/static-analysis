module Lab02DataTypes

using Primes
using Random
using Statistics

export set_task, array_tasks, random_vector_tasks, squares_and_primes, sums_task

"""Выполнить задания 1–2: операции над числовыми и разнотипными множествами."""
function set_task()
    A = Set([0, 3, 4, 9])
    B = Set([1, 3, 4, 7])
    C = Set([0, 1, 2, 4, 7, 8, 9])

    # В условии A∩B записано дважды; повтор не меняет объединение.
    P = union(intersect(A, B), intersect(A, B), intersect(A, C), intersect(B, C))

    integers = Set([1, 2, 3, 5])
    reals = Set([2.0, 3.5, 5.0])
    mixed = Set(Any[1, "Julia", :symbol, 3.5])
    examples = (
        union=union(integers, reals),
        intersection=intersect(integers, reals),
        difference=setdiff(mixed, Set(Any[1, :symbol])),
        membership="Julia" in mixed,
        subset=issubset(Set([2, 5]), integers),
    )
    return (; A, B, C, P, examples)
end

"""Выполнить задания 3.1–3.13 для N=25."""
function array_tasks(; N=25)
    N > 20 || throw(ArgumentError("N должно быть больше 20"))

    ascending = collect(1:N)                                      # 3.1
    descending = collect(N:-1:1)                                  # 3.2
    there_and_back = vcat(1:N, (N - 1):-1:1)                       # 3.3
    tmp = [4, 6, 3]                                                # 3.4
    first_ten = fill(first(tmp), 10)                               # 3.5
    all_ten = repeat(tmp, 10)                                      # 3.6
    counts_11_10_10 = vcat(first(tmp), repeat(tmp, 10))            # 3.7
    blocks_10_20_30 = vcat(fill(tmp[1], 10), fill(tmp[2], 20),
                           fill(tmp[3], 30))                        # 3.8
    powers = vcat(2 .^ tmp[1:2], fill(2^tmp[3], 4))                # 3.9
    six_digits = count(==('6'), join(powers))
    six_values = count(==(6), powers)

    x_grid = collect(3.0:0.1:6.0)                                 # 3.10
    y_grid = exp.(x_grid) .* cos.(x_grid)
    y_mean = mean(y_grid)

    i_values = 3:3:36                                              # 3.11
    j_values = 1:3:34
    power_pairs = collect(zip(0.1 .^ i_values, 0.2 .^ j_values))

    ratio_powers = [2.0^i / i for i in 1:25]                       # 3.12
    filenames = ["fn$i" for i in 1:30]                            # 3.13

    return (; ascending, descending, there_and_back, tmp, first_ten,
            all_ten, counts_11_10_10, blocks_10_20_30, powers,
            six_digits, six_values, x_grid, y_grid, y_mean,
            power_pairs, ratio_powers, filenames)
end

"""Выполнить все подпункты 3.14 с воспроизводимой случайной выборкой."""
function random_vector_tasks(; seed=2026, n=250)
    rng = MersenneTwister(seed)
    x = rand(rng, 0:999, n)
    y = rand(rng, 0:999, n)

    differences = y[2:end] .- x[1:end-1]
    linear_combination = x[1:end-2] .+ 2 .* x[2:end-1] .- x[3:end]
    trig_ratios = sin.(y[1:end-1]) ./ cos.(x[2:end])
    weighted_sum = sum(exp.(-x[2:end]) ./ (x[1:end-1] .+ 10))
    over_600_indices = findall(>(600), y)
    y_over_600 = y[over_600_indices]
    corresponding_x = x[over_600_indices]
    deviations = sqrt.(abs.(x .- mean(x)))
    near_max_count = count(>=(maximum(y) - 200), y)
    even_count = count(iseven, x)
    odd_count = count(isodd, x)
    multiples_of_7 = count(value -> value % 7 == 0, x)
    x_sorted_by_y = x[sortperm(y)]
    x_top_10 = sort(x; rev=true)[1:10]
    unique_x = unique(x)

    return (; x, y, differences, linear_combination, trig_ratios,
            weighted_sum, over_600_indices, y_over_600, corresponding_x,
            deviations, near_max_count, even_count, odd_count,
            multiples_of_7, x_sorted_by_y, x_top_10, unique_x)
end

"""Выполнить задания 4–5 с квадратами и простыми числами."""
function squares_and_primes()
    squares = [i^2 for i in 1:100]
    myprimes = collect(primes(1000))
    @assert length(myprimes) == 168
    return (; squares, myprimes, prime_89=myprimes[89],
            primes_89_to_99=myprimes[89:99])
end

"""Вычислить три суммы из задания 6."""
function sums_task(; M=25)
    sum_6_1 = sum(i^3 + 4i^2 for i in 10:100)
    sum_6_2 = sum(2.0^i / i + 3.0^i / i^2 for i in 1:M)

    # 1 + 2/3 + (2·4)/(3·5) + ... + (2·4·...·38)/(3·5·...·39)
    terms_6_3 = vcat(1.0, accumulate(*, [2k / (2k + 1) for k in 1:19]))
    sum_6_3 = sum(terms_6_3)
    return (; sum_6_1, sum_6_2, terms_6_3, sum_6_3)
end

end
