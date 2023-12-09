using Pkg
Pkg.add("RData")

using RData

# Replace "your_data.RData" with the actual path to your .RData file
loaded_data = load("/home/jcc/Documents/GitHub/Soft_Skills_Centrality_India/Results/Result5.RData")

# Access the DataFrame or other variables from the loaded data
df = loaded_data["Programs"]

Pkg.add("Plots")
using Plots

# Assuming you have a DataFrame named Programs with columns SS, Eigen.vector, and Program

# Set colors
colors = ["orange", "darkgreen", "lightblue"]

# Create the plot
plot(
    scatter(
        Programs[!,:SS],
        Programs[!,:Eigen.vector],
        group=Programs[!,:Program],
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

