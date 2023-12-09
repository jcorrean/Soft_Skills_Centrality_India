using Pkg
Pkg.add("RData")

using RData

# Replace "your_data.RData" with the actual path to your .RData file
loaded_data = load("/home/jcc/Documents/GitHub/Soft_Skills_Centrality_India/Results/Result5.RData")

# Access the DataFrame or other variables from the loaded data
df = loaded_data["Programs"]

df

# Add the Plots package
Pkg.add("Plots")
using Plots

# Assuming you have a DataFrame named Programs with columns SS, Eigen.vector, and Program

# Set colors
colors = ["orange", "darkgreen", "lightblue"]

# Create the plot
plot(
    scatter(
        df[!,:SS],  # Use df instead of Programs
        df[!,:Eigen.vector],  # Use df instead of Programs
        group=df[!,:Program],  # Use df instead of Programs
        color=colors,
        markersize=5,
        alpha=0.6,
        xlabel="Soft Skills",
        ylabel="Eigenvector Centrality",
        legend=:top,
        legendfont=font(15),
        grid=true,
        xrotation=60,
        xtickfont=font(15),
        ytickfont=font(15),
        xguidefont=font(20, :black, :italic),
        yguidefont=font(20, :black, :italic),
    ),
    seriestype = :scatter,
    size=(800, 600),
)
