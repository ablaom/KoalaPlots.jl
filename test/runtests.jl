using Koala
using KoalaPlots
using Base.Test

using Plots

const srcdir = dirname(@__FILE__)

pyplot()
v = randn(50)
bootstrap_histogram_of_mean(v)
bootstrap_histogram_of_mean!(2*v, label="two big")
recordfig(joinpath(srcdir, "output", "testplot.png"), ConstantRegressor())
