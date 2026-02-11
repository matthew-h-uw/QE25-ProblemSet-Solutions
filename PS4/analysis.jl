include("consumption_vifi.jl")
using .ConsumptionSavingsVFI,Plots, Printf, Statistics, DataFrames, Statistics

gr()
default(fontfamily="Computer Modern", linewidth=2, framestyle=:box, grid=false)


#γ = 2
params_γ2 = ConsumptionSavingsVFI.ModelParams(γ=2.0, R=1.010)

#γ = 10
params_γ10 = ConsumptionSavingsVFI.ModelParams(γ=10.0, R=1.008)


println("\n" * "+"^80)
println("CASE 1: γ = 2, Standard VFI")
println("+"^80)
result_γ2_std = ConsumptionSavingsVFI.solve_vfi_standard(params_γ2, verbose=true)

println("\n" * "+"^80)
println("CASE 2: γ = 2, CES Trick")
println("+"^80)
result_γ2_ces = ConsumptionSavingsVFI.solve_vfi_ces_trick(params_γ2, verbose=true)

println("\n" * "+"^80)
println("CASE 3: γ = 10, Standard VFI")
println("+"^80)
result_γ10_std = ConsumptionSavingsVFI.solve_vfi_standard(params_γ10, verbose=true)

println("\n" * "+"^80)
println("CASE 4: γ = 10, CES Trick")
println("+"^80)
result_γ10_ces = ConsumptionSavingsVFI.solve_vfi_ces_trick(params_γ10, verbose=true)

println("\n" * "="^80)
println("RUNNING SIMULATIONS")
println("="^80)

T_sim = 10000
seed = 123
#simiulations
sim_γ2_std = ConsumptionSavingsVFI.simulate(result_γ2_std, params_γ2, T_sim, seed=seed)
sim_γ2_ces = ConsumptionSavingsVFI.simulate(result_γ2_ces, params_γ2, T_sim, seed=seed)
sim_γ10_std = ConsumptionSavingsVFI.simulate(result_γ10_std, params_γ10, T_sim, seed=seed)
sim_γ10_ces = ConsumptionSavingsVFI.simulate(result_γ10_ces, params_γ10, T_sim, seed=seed)
#euler
ee_γ2_std = ConsumptionSavingsVFI.compute_euler_errors(result_γ2_std, params_γ2, sim_γ2_std)
ee_γ2_ces = ConsumptionSavingsVFI.compute_euler_errors(result_γ2_ces, params_γ2, sim_γ2_ces)
ee_γ10_std = ConsumptionSavingsVFI.compute_euler_errors(result_γ10_std, params_γ10, sim_γ10_std)
ee_γ10_ces = ConsumptionSavingsVFI.compute_euler_errors(result_γ10_ces, params_γ10, sim_γ10_ces)
#simiulations
stats_γ2_std = ConsumptionSavingsVFI.compute_statistics(sim_γ2_std, result_γ2_std, params_γ2)
stats_γ2_ces = ConsumptionSavingsVFI.compute_statistics(sim_γ2_ces, result_γ2_ces, params_γ2)
stats_γ10_std = ConsumptionSavingsVFI.compute_statistics(sim_γ10_std, result_γ10_std, params_γ10)
stats_γ10_ces = ConsumptionSavingsVFI.compute_statistics(sim_γ10_ces, result_γ10_ces, params_γ10)

println("\n" * "-"^80)
println("TABLE: Simulation Statistics for All Four Cases")
println("-"^80)
println("|  Statistic          | γ=2, Std | γ=2, CES | γ=10, Std | γ=10, CES |")
println("|" * "-"^77 * "|")
@printf("| Mean assets         | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["mean_a"], stats_γ2_ces["mean_a"], 
        stats_γ10_std["mean_a"], stats_γ10_ces["mean_a"])
@printf("| Std dev assets      | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["std_a"], stats_γ2_ces["std_a"], 
        stats_γ10_std["std_a"], stats_γ10_ces["std_a"])
@printf("| Mean consumption    | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["mean_c"], stats_γ2_ces["mean_c"], 
        stats_γ10_std["mean_c"], stats_γ10_ces["mean_c"])
@printf("| Std dev consumption | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["std_c"], stats_γ2_ces["std_c"], 
        stats_γ10_std["std_c"], stats_γ10_ces["std_c"])
@printf("| Min assets          | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["min_a"], stats_γ2_ces["min_a"], 
        stats_γ10_std["min_a"], stats_γ10_ces["min_a"])
@printf("| Max assets          | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["max_a"], stats_γ2_ces["max_a"], 
        stats_γ10_std["max_a"], stats_γ10_ces["max_a"])
@printf("| Min consumption     | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["min_c"], stats_γ2_ces["min_c"], 
        stats_γ10_std["min_c"], stats_γ10_ces["min_c"])
@printf("| Max consumption     | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["max_c"], stats_γ2_ces["max_c"], 
        stats_γ10_std["max_c"], stats_γ10_ces["max_c"])
@printf("| Frac. constrained   | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["frac_constrained"], stats_γ2_ces["frac_constrained"], 
        stats_γ10_std["frac_constrained"], stats_γ10_ces["frac_constrained"])
@printf("| Autocorr(a_t,a_t-1) | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["corr_a"], stats_γ2_ces["corr_a"], 
        stats_γ10_std["corr_a"], stats_γ10_ces["corr_a"])
@printf("| Autocorr(c_t,c_t-1) | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["corr_c"], stats_γ2_ces["corr_c"], 
        stats_γ10_std["corr_c"], stats_γ10_ces["corr_c"])
@printf("| Corr(c_t, z_t)      | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["corr_c_z"], stats_γ2_ces["corr_c_z"], 
        stats_γ10_std["corr_c_z"], stats_γ10_ces["corr_c_z"])
@printf("| Corr(a_t, z_t)      | %8.3f | %8.3f | %9.3f | %9.3f |\n", 
        stats_γ2_std["corr_a_z"], stats_γ2_ces["corr_a_z"], 
        stats_γ10_std["corr_a_z"], stats_γ10_ces["corr_a_z"])
println("-"^80)

#Performance
println("\n" * "-"^80)
println("TABLE: Performance Comparison")
println("-"^80)
println("|  Metric      | γ=2, Std | γ=2, CES | γ=10, Std | γ=10, CES |")
println("|" * "-"^77 * "|")
@printf("| Iterations   | %8d | %8d | %9d | %9d |\n", 
        result_γ2_std.iter, result_γ2_ces.iter, 
        result_γ10_std.iter, result_γ10_ces.iter)
@printf("| Time (sec)   | %8.2f | %8.2f | %9.2f | %9.2f |\n", 
        result_γ2_std.time, result_γ2_ces.time, 
        result_γ10_std.time, result_γ10_ces.time)
println("-"^80)

#Euler
println("\n" * "-"^80)
println("TABLE: Euler Equation Errors (log10 scale)")
println("-"^80)
println("|  Percentile  | γ=2, Std | γ=2, CES | γ=10, Std | γ=10, CES |")
println("|" * "-"^77 * "|")

#getting rid of junk
ee_γ2_std_clean = filter(!isnan, ee_γ2_std)
ee_γ2_ces_clean = filter(!isnan, ee_γ2_ces)
ee_γ10_std_clean = filter(!isnan, ee_γ10_std)
ee_γ10_ces_clean = filter(!isnan, ee_γ10_ces)

using Statistics: quantile
@printf("| Mean         | %8.5f | %8.5f | %9.5f | %9.5f |\n", 
        mean(ee_γ2_std_clean), mean(ee_γ2_ces_clean), 
        mean(ee_γ10_std_clean), mean(ee_γ10_ces_clean))
@printf("| Median       | %8.5f | %8.5f | %9.5f | %9.5f |\n", 
        median(ee_γ2_std_clean), median(ee_γ2_ces_clean), 
        median(ee_γ10_std_clean), median(ee_γ10_ces_clean))
@printf("| 10th pctile  | %8.5f | %8.5f | %9.5f | %9.5f |\n", 
        quantile(ee_γ2_std_clean, 0.10), quantile(ee_γ2_ces_clean, 0.10), 
        quantile(ee_γ10_std_clean, 0.10), quantile(ee_γ10_ces_clean, 0.10))
@printf("| 90th pctile  | %8.5f | %8.5f | %9.5f | %9.5f |\n", 
        quantile(ee_γ2_std_clean, 0.90), quantile(ee_γ2_ces_clean, 0.90), 
        quantile(ee_γ10_std_clean, 0.90), quantile(ee_γ10_ces_clean, 0.90))
println("-"^80)
