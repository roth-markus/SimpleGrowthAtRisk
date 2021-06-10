using Pkg
#Pkg.add("LaTeXStrings")
using DataFrames
using CSV
using Plots
using Distributions
using LaTeXStrings
using Random
#pyplot()

ndraws = 1000

DataFile=CSV.read("C:\\Users\\Markus\\OneDrive\\Desktop\\Neuer Ordner\\DataVulnerability.csv", DataFrame)
bb=CSV.File("C:\\Users\\Markus\\OneDrive\\Desktop\\Neuer Ordner\\DataVulnerability.csv")

Dates = DataFile[:,1]
GDPGrowth = DataFile[:,2]
NFCI = DataFile[:,3]

y = GDPGrowth[2:end]
T = size(y,1)

X = hcat(NFCI[1:end-1], GDPGrowth[1:end-1], NFCI[1:end-1].*GDPGrowth[1:end-1], ones(T,1))

β   = (X'*X)^(-1)*(X'*y)
ε   = y - X*β
SSR = ε'*ε
Σ   = SSR/T

TSPlot1 = plot(Dates, GDPGrowth, label = "GDP growth", linecolor = :black, foreground_color_legend = nothing, ylabel="Percent" )
TSPlot2 = plot(Dates, NFCI, label = "NFCI", linecolor = :black, foreground_color_legend = nothing, ylabel = "Index")
plot(TSPlot1,TSPlot2)

hist1 = histogram(GDPGrowth, label = "GDP growth", foreground_color_legend = nothing, linecolor = :black, fill = :grey)
hist2 = histogram(NFCI, label = L"\gamma NFCI", foreground_color_legend = nothing, linecolor = :black, fill = :grey)
plot(hist1,hist2)

IGrnd = rand(InverseGamma(3,0.5), ndraws)

xax = LinRange(0,4,100)

histIGam = histogram(IGrnd, label = "Inverse Gamma distribution", foreground_color_legend = nothing, linecolor = :black, fill = :grey, normed =true)

plot!(xax,pdf(InverseGamma(3,0.5),xax), label="pdf", linewidth=2)

mean(IGrnd)
var(IGrnd)
mean(InverseGamma(3,0.5))
var(InverseGamma(3,0.5))
