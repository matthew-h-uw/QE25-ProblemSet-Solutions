module ConsumptionSavingsVFI

using Distributions, Optim, Interpolations, LinearAlgebra, Statistics, Plots, Parameters, Printf, Random

@with_kw struct ModelParams
    γ::Float64 = 2.0
    β::Float64 = 0.99
    R::Float64 = 1.010
    ρ::Float64 = 0.90
    σ_ε::Float64 = 0.20 * sqrt(1 - 0.90^2)
    N_z::Int = 11
    N_a::Int = 100
    a_max::Float64 = 500.0
    tol::Float64 = 1e-7
    max_iter::Int = 1000
end

function u(c::Float64, γ::Float64)
    if c <= 0
        return -1e10
    end
    if γ ≈ 1.0
        return log(c)
    else
        return (c^(1-γ) - 1) / (1 - γ)
    end
end

function rouwenhorst_matrix(N::Int, p::Float64, q::Float64)
    if N == 2
        return [p 1-p; 1-q q]
    else
        P_prev = rouwenhorst_matrix(N-1, p, q)
        P = zeros(N, N)
        
        P[1:N-1, 1:N-1] .+= p * P_prev
        P[1:N-1, 2:N] .+= (1-p) * P_prev
        P[2:N, 1:N-1] .+= (1-q) * P_prev
        P[2:N, 2:N] .+= q * P_prev
        
        P[2:N-1, :] ./= 2
        return P
    end
end

function rouwenhorst(ρ::Float64, σ_ε::Float64, N::Int)
    σ_z = σ_ε / sqrt(1 - ρ^2)
    
    p = (1 + ρ) / 2
    q = p
    
    P = rouwenhorst_matrix(N, p, q)
    
    ψ = sqrt(N - 1) * σ_z
    z_grid = range(-ψ, ψ, length=N)
    z_grid = exp.(z_grid)
    
    return z_grid, P
end

function create_asset_grid(a_min::Float64, a_max::Float64, N::Int, θ::Float64=3.0)
    ω = range(0, 1, length=N)
    a_grid = a_min .+ (a_max - a_min) .* (ω .^ θ)
    return a_grid
end

function interp_value(x::Float64, grid::Vector{Float64}, values::Vector{Float64})
    if x <= grid[1]
        return values[1]
    elseif x >= grid[end]
        return values[end]
    else
        idx = searchsortedfirst(grid, x)
        a_low = grid[idx-1]
        a_high = grid[idx]
        weight = (x - a_low) / (a_high - a_low)
        return (1 - weight) * values[idx-1] + weight * values[idx]
    end
end

function solve_vfi_standard(params::ModelParams; verbose::Bool=true)
    @unpack γ, β, R, ρ, σ_ε, N_z, N_a, a_max, tol, max_iter = params
    
    z_grid, P = rouwenhorst(ρ, σ_ε, N_z)
    z_min = minimum(z_grid)

    a_min = -0.6 * z_min / (R - 1)

    a_grid = create_asset_grid(a_min, a_max, N_a, 3.0)

    V = zeros(N_a, N_z)
    V_new = zeros(N_a, N_z)
    c_policy = zeros(N_a, N_z)
    a_policy = zeros(N_a, N_z)
    
    iter = 0
    diff = Inf
    start_time = time()
    
    if verbose
        println("\n" * "="^70)
        println("METHOD 1: Standard VFI with Linear Interpolation")
        println("="^70)
        println("Parameters: γ = $γ, β = $β, R = $R")
        println("Grid: N_a = $N_a, N_z = $N_z")
        println("Borrowing limit: a_min = $(round(a_min, digits=4))")
    end
    
    while iter < max_iter && diff > tol
        iter += 1
        
        for (i_z, z) in enumerate(z_grid)
            for (i_a, a) in enumerate(a_grid)
                cash = R * a + z

                c_max = cash - a_min
                
                if c_max <= 0
                    V_new[i_a, i_z] = -1e10
                    c_policy[i_a, i_z] = 0.0
                    a_policy[i_a, i_z] = a_min
                    continue
                end

                function obj(a_prime::Float64)
                    c = cash - a_prime
                    
                    if c <= 0
                        return -1e10
                    end
                    
                    util = u(c, γ)
                    EV = 0.0
                    for (i_z_prime, z_prime) in enumerate(z_grid)
                        V_interp = interp_value(a_prime, a_grid, V[:, i_z_prime])
                        EV += P[i_z, i_z_prime] * V_interp
                    end
                    
                    return util + β * EV
                end
                best_val = -Inf
                best_a_prime = a_min
                
                for a_prime in a_grid
                    if a_prime <= cash - 1e-10
                        val = obj(a_prime)
                        if val > best_val
                            best_val = val
                            best_a_prime = a_prime
                        end
                    end
                end
                
                V_new[i_a, i_z] = best_val
                a_policy[i_a, i_z] = best_a_prime
                c_policy[i_a, i_z] = cash - best_a_prime
            end
        end
        
        diff = maximum(abs.(V_new .- V) ./ (1 .+ abs.(V)))
        V .= V_new
        
        if verbose && (iter % 10 == 0 || iter == 1)
            @printf("Iter %4d: diff = %.2e\n", iter, diff)
        end
    end
    
    elapsed = time() - start_time
    
    if verbose
        println("\nConvergence achieved!")
        println("Iterations: $iter")
        @printf("Time: %.2f seconds\n", elapsed)
        @printf("Final diff: %.2e\n", diff)
    end
    
    return (V=V, c_policy=c_policy, a_policy=a_policy, 
            a_grid=a_grid, z_grid=z_grid, P=P,
            iter=iter, time=elapsed, z_min=z_min, a_min=a_min)
end

function solve_vfi_ces_trick(params::ModelParams; verbose::Bool=true)
    @unpack γ, β, R, ρ, σ_ε, N_z, N_a, a_max, tol, max_iter = params

    z_grid, P = rouwenhorst(ρ, σ_ε, N_z)
    z_min = minimum(z_grid)

    a_min = -0.6 * z_min / (R - 1)

    a_grid = create_asset_grid(a_min, a_max, N_a, 3.0)

    W = zeros(N_a, N_z)
    W_new = zeros(N_a, N_z)
    c_policy = zeros(N_a, N_z)
    a_policy = zeros(N_a, N_z)

    for (i_z, z) in enumerate(z_grid)           #guesser
        for (i_a, a) in enumerate(a_grid)
            cash = R * a + z
            c_autarky = max(cash, 1e-8)
            W[i_a, i_z] = c_autarky
        end
    end
    
    iter = 0
    diff = Inf
    start_time = time()
    
    if verbose
        println("\n" * "="^70)
        println("METHOD 2: VFI with Recursive CES Trick")
        println("="^70)
        println("Parameters: γ = $γ, β = $β, R = $R")
        println("Grid: N_a = $N_a, N_z = $N_z")
        println("Borrowing limit: a_min = $(round(a_min, digits=4))")
    end
    
    while iter < max_iter && diff > tol
        iter += 1
        
        for (i_z, z) in enumerate(z_grid)
            for (i_a, a) in enumerate(a_grid)
                cash = R * a + z
                c_max = cash - a_min
                
                if c_max <= 0
                    W_new[i_a, i_z] = 1e-10
                    c_policy[i_a, i_z] = 1e-10
                    a_policy[i_a, i_z] = a_min
                    continue
                end
                function obj_ces(a_prime::Float64)
                    c = cash - a_prime
                    
                    if c <= 0
                        return -Inf
                    end

                    EW_power = 0.0
                    for (i_z_prime, z_prime) in enumerate(z_grid)
                        W_interp = interp_value(a_prime, a_grid, W[:, i_z_prime])
                        EW_power += P[i_z, i_z_prime] * (W_interp^(1-γ))
                    end

                    ces_value = c^(1-γ) + β * EW_power
                    
                    return ces_value^(1/(1-γ))
                end

                best_val = -Inf
                best_a_prime = a_min
                
                for a_prime in a_grid
                    if a_prime <= cash - 1e-10
                        val = obj_ces(a_prime)
                        if val > best_val
                            best_val = val
                            best_a_prime = a_prime
                        end
                    end
                end
                
                W_new[i_a, i_z] = best_val
                a_policy[i_a, i_z] = best_a_prime
                c_policy[i_a, i_z] = cash - best_a_prime
            end
        end
        
        diff = maximum(abs.(W_new .- W) ./ (1 .+ abs.(W)))
        W .= W_new
        
        if verbose && (iter % 10 == 0 || iter == 1)
            @printf("Iter %4d: diff = %.2e\n", iter, diff)
        end
    end
    
    elapsed = time() - start_time

    V = (1 - β) .* (W .^ (1 - γ))
    
    if verbose
        println("\nConvergence achieved!")
        println("Iterations: $iter")
        @printf("Time: %.2f seconds\n", elapsed)
        @printf("Final diff: %.2e\n", diff)
    end
    
    return (V=V, W=W, c_policy=c_policy, a_policy=a_policy, 
            a_grid=a_grid, z_grid=z_grid, P=P,
            iter=iter, time=elapsed, z_min=z_min, a_min=a_min)
end

function simulate(result, params::ModelParams, T::Int; burn_in::Int=500, seed::Int=123)
    @unpack R = params
    
    Random.seed!(seed)
    
    a_grid = result.a_grid
    z_grid = result.z_grid
    P = result.P
    c_policy = result.c_policy
    a_policy = result.a_policy
    
    N_z = length(z_grid)
    median_z_idx = div(N_z + 1, 2)
    
    T_total = T + burn_in
    a_sim = zeros(T_total)
    c_sim = zeros(T_total)
    z_sim = zeros(T_total)
    z_idx_sim = zeros(Int, T_total)

    a_sim[1] = 0.0
    z_idx_sim[1] = median_z_idx
    z_sim[1] = z_grid[median_z_idx]
    
    for t in 1:T_total-1
        a_t = a_sim[t]
        z_idx_t = z_idx_sim[t]

        c_t = interp_value(a_t, a_grid, c_policy[:, z_idx_t])
        a_t_next = interp_value(a_t, a_grid, a_policy[:, z_idx_t])
        
        c_sim[t] = c_t
        a_sim[t+1] = a_t_next

        prob_cumsum = cumsum(P[z_idx_t, :])
        u = rand()
        z_idx_next = findfirst(prob_cumsum .>= u)
        
        z_idx_sim[t+1] = z_idx_next
        z_sim[t+1] = z_grid[z_idx_next]
    end

    c_sim[T_total] = interp_value(a_sim[T_total], a_grid, c_policy[:, z_idx_sim[T_total]])

    a_sim = a_sim[burn_in+1:end]
    c_sim = c_sim[burn_in+1:end]
    z_sim = z_sim[burn_in+1:end]
    z_idx_sim = z_idx_sim[burn_in+1:end]
    
    return (a=a_sim, c=c_sim, z=z_sim, z_idx=z_idx_sim)
end

function compute_euler_errors(result, params::ModelParams, sim)
    @unpack γ, β, R = params
    
    a_grid = result.a_grid
    z_grid = result.z_grid
    P = result.P
    c_policy = result.c_policy
    
    T = length(sim.a)
    ee_errors = zeros(T-1)
    
    for t in 1:T-1
        z_idx_t = sim.z_idx[t]
        c_t = sim.c[t]
        a_next = sim.a[t+1]

        EMU_next = 0.0          #they dont have more utility the peroid after the simulation so they kinda dont really care
        for (i_z_prime, z_prime) in enumerate(z_grid)
            c_next = interp_value(a_next, a_grid, c_policy[:, i_z_prime])
            if c_next > 0
                EMU_next += P[z_idx_t, i_z_prime] * (c_next^(-γ))
            end
        end
        if c_t > 0 && EMU_next > 0
            c_implied = (β * R * EMU_next)^(-1/γ)
            ee_errors[t] = abs(log10(abs(c_implied / c_t)))
        else
            ee_errors[t] = NaN
        end
    end
    
    return ee_errors
end

function compute_statistics(sim, result, params)
    a_min = result.a_min
    
    mean_a = mean(sim.a)
    std_a = std(sim.a)
    mean_c = mean(sim.c)
    std_c = std(sim.c)
    
    min_a = minimum(sim.a)
    max_a = maximum(sim.a)
    min_c = minimum(sim.c)
    max_c = maximum(sim.c)
    
    frac_constrained = mean(sim.a .<= a_min + 1e-3)

    T = length(sim.a)
    corr_a = cor(sim.a[1:T-1], sim.a[2:T])
    corr_c = cor(sim.c[1:T-1], sim.c[2:T])

    corr_c_z = cor(sim.c, sim.z)
    corr_a_z = cor(sim.a, sim.z)
    
    return Dict(
        "mean_a" => mean_a,
        "std_a" => std_a,
        "mean_c" => mean_c,
        "std_c" => std_c,
        "min_a" => min_a,
        "max_a" => max_a,
        "min_c" => min_c,
        "max_c" => max_c,
        "frac_constrained" => frac_constrained,
        "corr_a" => corr_a,
        "corr_c" => corr_c,
        "corr_c_z" => corr_c_z,
        "corr_a_z" => corr_a_z
    )
end

end
