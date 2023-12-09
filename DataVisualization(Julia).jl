using Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Plots")

using DataFrames, CSV, Plots

# Replace "your_data.csv" with the actual path to your CSV file
df = CSV.File("Programs.csv") |> DataFrame

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
        legendfont=font(12),  # Adjust the font size as needed
        grid=true,
        xrotation=60,
        xtickfont=font(12),  # Adjust the font size as needed
        ytickfont=font(12),  # Adjust the font size as needed
        xguidefont=font(12, :black, :italic),  # Adjust the font size and style as needed
        yguidefont=font(12, :black, :italic),  # Adjust the font size and style as needed
    ),
    seriestype = :scatter,
    size=(800, 600),
)
