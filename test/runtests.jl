using Koala
using KoalaPlots
using Base.Test

using Plots: pyplot

const srcdir = dirname(@__FILE__)

pyplot()
d=Dict{Char, Int}()
f=Dict{Char, Int}()
d['a']= 1
d['b']=3
d['c']=2
f['a']=6
f['b']=4
f['c']=2
plot(d)
plot!(f)
plot(d, ordered_by_keys=true)
plot!(f)

v = randn(50)
bootstrap_histogram(v)
bootstrap_histogram!(2*v, label="two big")
recordfig(joinpath(srcdir, "output", "testplot.png"), ConstantRegressor())
