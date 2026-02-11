include("consumption_vifi.jl")
using  .ConsumptionSavingsVFI, Plots, Printf


N_z = length(result_γ2_std.z_grid)
z_low_idx = 1
z_med_idx = div(N_z + 1, 2)
z_high_idx = N_z

#Policy for the 2

p1 = plot(result_γ2_std.a_grid, result_γ2_std.c_policy[:, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=2: Consumption Policy (Low Income)")
plot!(p1, result_γ2_ces.a_grid, result_γ2_ces.c_policy[:, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(result_γ2_std.a_grid, result_γ2_std.c_policy[:, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=2: Consumption Policy (Median Income)")
plot!(p2, result_γ2_ces.a_grid, result_γ2_ces.c_policy[:, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p3 = plot(result_γ2_std.a_grid, result_γ2_std.c_policy[:, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=2: Consumption Policy (High Income)")
plot!(p3, result_γ2_ces.a_grid, result_γ2_ces.c_policy[:, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p4 = plot(result_γ2_std.a_grid, result_γ2_std.a_policy[:, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=2: Asset Policy (Low Income)")
plot!(p4, result_γ2_ces.a_grid, result_γ2_ces.a_policy[:, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
plot!(p4, result_γ2_std.a_grid, result_γ2_std.a_grid, 
      label="45° line", color=:black, linestyle=:dot, linewidth=1)

p5 = plot(result_γ2_std.a_grid, result_γ2_std.a_policy[:, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=2: Asset Policy (Median Income)")
plot!(p5, result_γ2_ces.a_grid, result_γ2_ces.a_policy[:, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
plot!(p5, result_γ2_std.a_grid, result_γ2_std.a_grid, 
      label="45° line", color=:black, linestyle=:dot, linewidth=1)

p6 = plot(result_γ2_std.a_grid, result_γ2_std.a_policy[:, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=2: Asset Policy (High Income)")
plot!(p6, result_γ2_ces.a_grid, result_γ2_ces.a_policy[:, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
plot!(p6, result_γ2_std.a_grid, result_γ2_std.a_grid, 
      label="45° line", color=:black, linestyle=:dot, linewidth=1)

plot_policies_γ2 = plot(p1, p2, p3, p4, p5, p6, layout=(2,3), size=(1400, 800))
savefig(plot_policies_γ2, "policies_gamma2.png")

#Policy for the 10

p1 = plot(result_γ10_std.a_grid, result_γ10_std.c_policy[:, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=10: Consumption Policy (Low Income)")
plot!(p1, result_γ10_ces.a_grid, result_γ10_ces.c_policy[:, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(result_γ10_std.a_grid, result_γ10_std.c_policy[:, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=10: Consumption Policy (Median Income)")
plot!(p2, result_γ10_ces.a_grid, result_γ10_ces.c_policy[:, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p3 = plot(result_γ10_std.a_grid, result_γ10_std.c_policy[:, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=10: Consumption Policy (High Income)")
plot!(p3, result_γ10_ces.a_grid, result_γ10_ces.c_policy[:, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p4 = plot(result_γ10_std.a_grid, result_γ10_std.a_policy[:, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=10: Asset Policy (Low Income)")
plot!(p4, result_γ10_ces.a_grid, result_γ10_ces.a_policy[:, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
plot!(p4, result_γ10_std.a_grid, result_γ10_std.a_grid, 
      label="45° line", color=:black, linestyle=:dot, linewidth=1)

p5 = plot(result_γ10_std.a_grid, result_γ10_std.a_policy[:, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=10: Asset Policy (Median Income)")
plot!(p5, result_γ10_ces.a_grid, result_γ10_ces.a_policy[:, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
plot!(p5, result_γ10_std.a_grid, result_γ10_std.a_grid, 
      label="45° line", color=:black, linestyle=:dot, linewidth=1)

p6 = plot(result_γ10_std.a_grid, result_γ10_std.a_policy[:, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=10: Asset Policy (High Income)")
plot!(p6, result_γ10_ces.a_grid, result_γ10_ces.a_policy[:, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
plot!(p6, result_γ10_std.a_grid, result_γ10_std.a_grid, 
      label="45° line", color=:black, linestyle=:dot, linewidth=1)

plot_policies_γ10 = plot(p1, p2, p3, p4, p5, p6, layout=(2,3), size=(1400, 800))
savefig(plot_policies_γ10, "policies_gamma10.png")

#Plots to see at the bound for the 2 (zoomed in)

a_min_γ2 .<= result_γ2_std.a_grid  
zoom_range = (a_min_γ2 .<= result_γ2_std.a_grid) .& (result_γ2_std.a_grid .<= a_min_γ2 + 5)

p1 = plot(result_γ2_std.a_grid[zoom_range], result_γ2_std.c_policy[zoom_range, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=2: Consumption Policy (Low Income) - Zoomed")
plot!(p1, result_γ2_ces.a_grid[zoom_range], result_γ2_ces.c_policy[zoom_range, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p1, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p2 = plot(result_γ2_std.a_grid[zoom_range], result_γ2_std.c_policy[zoom_range, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=2: Consumption Policy (Median Income) - Zoomed")
plot!(p2, result_γ2_ces.a_grid[zoom_range], result_γ2_ces.c_policy[zoom_range, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p2, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p3 = plot(result_γ2_std.a_grid[zoom_range], result_γ2_std.c_policy[zoom_range, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=2: Consumption Policy (High Income) - Zoomed")
plot!(p3, result_γ2_ces.a_grid[zoom_range], result_γ2_ces.c_policy[zoom_range, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p3, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p4 = plot(result_γ2_std.a_grid[zoom_range], result_γ2_std.a_policy[zoom_range, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=2: Asset Policy (Low Income) - Zoomed")
plot!(p4, result_γ2_ces.a_grid[zoom_range], result_γ2_ces.a_policy[zoom_range, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p4, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p5 = plot(result_γ2_std.a_grid[zoom_range], result_γ2_std.a_policy[zoom_range, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=2: Asset Policy (Median Income) - Zoomed")
plot!(p5, result_γ2_ces.a_grid[zoom_range], result_γ2_ces.a_policy[zoom_range, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p5, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p6 = plot(result_γ2_std.a_grid[zoom_range], result_γ2_std.a_policy[zoom_range, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=2: Asset Policy (High Income) - Zoomed")
plot!(p6, result_γ2_ces.a_grid[zoom_range], result_γ2_ces.a_policy[zoom_range, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p6, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

plot_policies_γ2_zoom = plot(p1, p2, p3, p4, p5, p6, layout=(2,3), size=(1400, 800))
savefig(plot_policies_γ2_zoom, "policies_gamma2_zoomed.png")

#Plots to see at the bound for the 10 (zoomed in)

a_min_γ10 = result_γ10_std.a_min
zoom_range = (a_min_γ10 .<= result_γ10_std.a_grid) .& (result_γ10_std.a_grid .<= a_min_γ10 + 5)

p1 = plot(result_γ10_std.a_grid[zoom_range], result_γ10_std.c_policy[zoom_range, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=10: Consumption Policy (Low Income) - Zoomed")
plot!(p1, result_γ10_ces.a_grid[zoom_range], result_γ10_ces.c_policy[zoom_range, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p1, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p2 = plot(result_γ10_std.a_grid[zoom_range], result_γ10_std.c_policy[zoom_range, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=10: Consumption Policy (Median Income) - Zoomed")
plot!(p2, result_γ10_ces.a_grid[zoom_range], result_γ10_ces.c_policy[zoom_range, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p2, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p3 = plot(result_γ10_std.a_grid[zoom_range], result_γ10_std.c_policy[zoom_range, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Consumption c(a,z)",
          title="γ=10: Consumption Policy (High Income) - Zoomed")
plot!(p3, result_γ10_ces.a_grid[zoom_range], result_γ10_ces.c_policy[zoom_range, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p3, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p4 = plot(result_γ10_std.a_grid[zoom_range], result_γ10_std.a_policy[zoom_range, z_low_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=10: Asset Policy (Low Income) - Zoomed")
plot!(p4, result_γ10_ces.a_grid[zoom_range], result_γ10_ces.a_policy[zoom_range, z_low_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p4, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p5 = plot(result_γ10_std.a_grid[zoom_range], result_γ10_std.a_policy[zoom_range, z_med_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=10: Asset Policy (Median Income) - Zoomed")
plot!(p5, result_γ10_ces.a_grid[zoom_range], result_γ10_ces.a_policy[zoom_range, z_med_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p5, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p6 = plot(result_γ10_std.a_grid[zoom_range], result_γ10_std.a_policy[zoom_range, z_high_idx],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Assets' a'(a,z)",
          title="γ=10: Asset Policy (High Income) - Zoomed")
plot!(p6, result_γ10_ces.a_grid[zoom_range], result_γ10_ces.a_policy[zoom_range, z_high_idx],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p6, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

plot_policies_γ10_zoom = plot(p1, p2, p3, p4, p5, p6, layout=(2,3), size=(1400, 800))
savefig(plot_policies_γ10_zoom, "policies_gamma10_zoomed.png")

#Euler + assets

# For γ=2
ee_grid_γ2_std = zeros(length(result_γ2_std.a_grid), 3)
ee_grid_γ2_ces = zeros(length(result_γ2_ces.a_grid), 3)

for (col_idx, z_idx) in enumerate([z_low_idx, z_med_idx, z_high_idx])
    for (i_a, a) in enumerate(result_γ2_std.a_grid)
        # Calculate expected marginal utility
        EMU = 0.0
        for (i_z_prime, z_prime) in enumerate(result_γ2_std.z_grid)
            a_prime = result_γ2_std.a_policy[i_a, z_idx]
            c_next = ConsumptionSavingsVFI.interp_value(a_prime, result_γ2_std.a_grid, 
                                                        result_γ2_std.c_policy[:, i_z_prime])
            if c_next > 0
                EMU += result_γ2_std.P[z_idx, i_z_prime] * (c_next^(-params_γ2.γ))
            end
        end
        
        c_t = result_γ2_std.c_policy[i_a, z_idx]
        if c_t > 0 && EMU > 0
            c_implied = (params_γ2.β * params_γ2.R * EMU)^(-1/params_γ2.γ)
            ee_grid_γ2_std[i_a, col_idx] = abs(log10(abs(c_implied / c_t)))
        else
            ee_grid_γ2_std[i_a, col_idx] = NaN
        end
    end
    
    for (i_a, a) in enumerate(result_γ2_ces.a_grid)
        EMU = 0.0
        for (i_z_prime, z_prime) in enumerate(result_γ2_ces.z_grid)
            a_prime = result_γ2_ces.a_policy[i_a, z_idx]
            c_next = ConsumptionSavingsVFI.interp_value(a_prime, result_γ2_ces.a_grid, 
                                                        result_γ2_ces.c_policy[:, i_z_prime])
            if c_next > 0
                EMU += result_γ2_ces.P[z_idx, i_z_prime] * (c_next^(-params_γ2.γ))
            end
        end
        
        c_t = result_γ2_ces.c_policy[i_a, z_idx]
        if c_t > 0 && EMU > 0
            c_implied = (params_γ2.β * params_γ2.R * EMU)^(-1/params_γ2.γ)
            ee_grid_γ2_ces[i_a, col_idx] = abs(log10(abs(c_implied / c_t)))
        else
            ee_grid_γ2_ces[i_a, col_idx] = NaN
        end
    end
end

p1 = plot(result_γ2_std.a_grid, ee_grid_γ2_std[:, 1],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors (Low Income)")
plot!(p1, result_γ2_ces.a_grid, ee_grid_γ2_ces[:, 1],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(result_γ2_std.a_grid, ee_grid_γ2_std[:, 2],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors (Median Income)")
plot!(p2, result_γ2_ces.a_grid, ee_grid_γ2_ces[:, 2],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p3 = plot(result_γ2_std.a_grid, ee_grid_γ2_std[:, 3],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors (High Income)")
plot!(p3, result_γ2_ces.a_grid, ee_grid_γ2_ces[:, 3],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

plot_ee_γ2 = plot(p1, p2, p3, layout=(1,3), size=(1400, 400))
savefig(plot_ee_γ2, "euler_errors_gamma2.png")

# Zoomed version
zoom_range_γ2 = (result_γ2_std.a_grid .<= a_min_γ2 + 10)

p1 = plot(result_γ2_std.a_grid[zoom_range_γ2], ee_grid_γ2_std[zoom_range_γ2, 1],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors (Low Income) - Zoomed")
plot!(p1, result_γ2_ces.a_grid[zoom_range_γ2], ee_grid_γ2_ces[zoom_range_γ2, 1],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p1, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p2 = plot(result_γ2_std.a_grid[zoom_range_γ2], ee_grid_γ2_std[zoom_range_γ2, 2],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors (Median Income) - Zoomed")
plot!(p2, result_γ2_ces.a_grid[zoom_range_γ2], ee_grid_γ2_ces[zoom_range_γ2, 2],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p2, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

p3 = plot(result_γ2_std.a_grid[zoom_range_γ2], ee_grid_γ2_std[zoom_range_γ2, 3],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors (High Income) - Zoomed")
plot!(p3, result_γ2_ces.a_grid[zoom_range_γ2], ee_grid_γ2_ces[zoom_range_γ2, 3],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p3, [a_min_γ2], label="Borrowing limit", color=:black, linestyle=:dot)

plot_ee_γ2_zoom = plot(p1, p2, p3, layout=(1,3), size=(1400, 400))
savefig(plot_ee_γ2_zoom, "euler_errors_gamma2_zoomed.png")

# For γ=10
ee_grid_γ10_std = zeros(length(result_γ10_std.a_grid), 3)
ee_grid_γ10_ces = zeros(length(result_γ10_ces.a_grid), 3)

for (col_idx, z_idx) in enumerate([z_low_idx, z_med_idx, z_high_idx])
    for (i_a, a) in enumerate(result_γ10_std.a_grid)
        EMU = 0.0
        for (i_z_prime, z_prime) in enumerate(result_γ10_std.z_grid)
            a_prime = result_γ10_std.a_policy[i_a, z_idx]
            c_next = ConsumptionSavingsVFI.interp_value(a_prime, result_γ10_std.a_grid, 
                                                        result_γ10_std.c_policy[:, i_z_prime])
            if c_next > 0
                EMU += result_γ10_std.P[z_idx, i_z_prime] * (c_next^(-params_γ10.γ))
            end
        end
        
        c_t = result_γ10_std.c_policy[i_a, z_idx]
        if c_t > 0 && EMU > 0
            c_implied = (params_γ10.β * params_γ10.R * EMU)^(-1/params_γ10.γ)
            ee_grid_γ10_std[i_a, col_idx] = abs(log10(abs(c_implied / c_t)))
        else
            ee_grid_γ10_std[i_a, col_idx] = NaN
        end
    end
    
    for (i_a, a) in enumerate(result_γ10_ces.a_grid)
        EMU = 0.0
        for (i_z_prime, z_prime) in enumerate(result_γ10_ces.z_grid)
            a_prime = result_γ10_ces.a_policy[i_a, z_idx]
            c_next = ConsumptionSavingsVFI.interp_value(a_prime, result_γ10_ces.a_grid, 
                                                        result_γ10_ces.c_policy[:, i_z_prime])
            if c_next > 0
                EMU += result_γ10_ces.P[z_idx, i_z_prime] * (c_next^(-params_γ10.γ))
            end
        end
        
        c_t = result_γ10_ces.c_policy[i_a, z_idx]
        if c_t > 0 && EMU > 0
            c_implied = (params_γ10.β * params_γ10.R * EMU)^(-1/params_γ10.γ)
            ee_grid_γ10_ces[i_a, col_idx] = abs(log10(abs(c_implied / c_t)))
        else
            ee_grid_γ10_ces[i_a, col_idx] = NaN
        end
    end
end

p1 = plot(result_γ10_std.a_grid, ee_grid_γ10_std[:, 1],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors (Low Income)")
plot!(p1, result_γ10_ces.a_grid, ee_grid_γ10_ces[:, 1],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(result_γ10_std.a_grid, ee_grid_γ10_std[:, 2],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors (Median Income)")
plot!(p2, result_γ10_ces.a_grid, ee_grid_γ10_ces[:, 2],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p3 = plot(result_γ10_std.a_grid, ee_grid_γ10_std[:, 3],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors (High Income)")
plot!(p3, result_γ10_ces.a_grid, ee_grid_γ10_ces[:, 3],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

plot_ee_γ10 = plot(p1, p2, p3, layout=(1,3), size=(1400, 400))
savefig(plot_ee_γ10, "euler_errors_gamma10.png")

# Zoomed version
zoom_range_γ10 = (result_γ10_std.a_grid .<= a_min_γ10 + 10)

p1 = plot(result_γ10_std.a_grid[zoom_range_γ10], ee_grid_γ10_std[zoom_range_γ10, 1],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors (Low Income) - Zoomed")
plot!(p1, result_γ10_ces.a_grid[zoom_range_γ10], ee_grid_γ10_ces[zoom_range_γ10, 1],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p1, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p2 = plot(result_γ10_std.a_grid[zoom_range_γ10], ee_grid_γ10_std[zoom_range_γ10, 2],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors (Median Income) - Zoomed")
plot!(p2, result_γ10_ces.a_grid[zoom_range_γ10], ee_grid_γ10_ces[zoom_range_γ10, 2],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p2, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

p3 = plot(result_γ10_std.a_grid[zoom_range_γ10], ee_grid_γ10_std[zoom_range_γ10, 3],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Assets a", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors (High Income) - Zoomed")
plot!(p3, result_γ10_ces.a_grid[zoom_range_γ10], ee_grid_γ10_ces[zoom_range_γ10, 3],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)
vline!(p3, [a_min_γ10], label="Borrowing limit", color=:black, linestyle=:dot)

plot_ee_γ10_zoom = plot(p1, p2, p3, layout=(1,3), size=(1400, 400))
savefig(plot_ee_γ10_zoom, "euler_errors_gamma10_zoomed.png")

#First 100 after we discard the burn in peroid
periods_to_plot = 100

# γ=2
p1 = plot(1:periods_to_plot, sim_γ2_std.a[1:periods_to_plot],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Period", ylabel="Assets", title="γ=2: Asset Path")
plot!(p1, 1:periods_to_plot, sim_γ2_ces.a[1:periods_to_plot],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(1:periods_to_plot, sim_γ2_std.c[1:periods_to_plot],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Period", ylabel="Consumption", title="γ=2: Consumption Path")
plot!(p2, 1:periods_to_plot, sim_γ2_ces.c[1:periods_to_plot],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p3 = plot(1:periods_to_plot, sim_γ2_std.z[1:periods_to_plot],
          label="Income", color=:green, linewidth=2,
          xlabel="Period", ylabel="Income", title="γ=2: Income Path")

plot_sim_γ2 = plot(p1, p2, p3, layout=(3,1), size=(1000, 900))
savefig(plot_sim_γ2, "simulation_gamma2.png")

# γ=10
p1 = plot(1:periods_to_plot, sim_γ10_std.a[1:periods_to_plot],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Period", ylabel="Assets", title="γ=10: Asset Path")
plot!(p1, 1:periods_to_plot, sim_γ10_ces.a[1:periods_to_plot],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(1:periods_to_plot, sim_γ10_std.c[1:periods_to_plot],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Period", ylabel="Consumption", title="γ=10: Consumption Path")
plot!(p2, 1:periods_to_plot, sim_γ10_ces.c[1:periods_to_plot],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p3 = plot(1:periods_to_plot, sim_γ10_std.z[1:periods_to_plot],
          label="Income", color=:green, linewidth=2,
          xlabel="Period", ylabel="Income", title="γ=10: Income Path")

plot_sim_γ10 = plot(p1, p2, p3, layout=(3,1), size=(1000, 900))
savefig(plot_sim_γ10, "simulation_gamma10.png")

#Euler plotter
p1 = plot(1:periods_to_plot, ee_γ2_std[1:periods_to_plot],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Period", ylabel="Euler Error (log10)",
          title="γ=2: Euler Errors Over Time")
plot!(p1, 1:periods_to_plot, ee_γ2_ces[1:periods_to_plot],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

p2 = plot(1:periods_to_plot, ee_γ10_std[1:periods_to_plot],
          label="Standard VFI", color=:blue, linewidth=2,
          xlabel="Period", ylabel="Euler Error (log10)",
          title="γ=10: Euler Errors Over Time")
plot!(p2, 1:periods_to_plot, ee_γ10_ces[1:periods_to_plot],
      label="CES Trick", color=:red, linestyle=:dash, linewidth=2)

plot_ee_sim = plot(p1, p2, layout=(2,1), size=(1000, 700))
savefig(plot_ee_sim, "euler_errors_simulation.png")
