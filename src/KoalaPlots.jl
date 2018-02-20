module KoalaPlots

export bootstrap_histogram, bootstrap_histogram!, recordfig

# extended:
export plot, plot! # from Plots

import Koala: keys_ordered_by_values, bootstrap_resample_of_mean
import Plots: histogram, histogram!, savefig
import StatPlots: density, density!

# to be extended:
import Plots: plot, plot!, bar, bar!

"""
## `plot(d)`

Produces a bar plot of the dictionary `d`, whose values are required
to be of `Real` type. In the plot the keys of the dictionary are ordered
by the corresponding values, unless `ordered_by_keys=true` is passed.

There is a corresponding `plot!` method.

"""
function plot{S,T<:Real}(d::Dict{S,T}; ordered_by_keys=false, args...)

    x = String[]
    y = T[]
    
    if ordered_by_keys
        kys = sort(collect(keys(d)))
    else
        kys = keys_ordered_by_values(d)
    end
    
    for k in kys
        push!(x, string(k))
        push!(y, d[k])
    end
    return bar(x,y; args...)

end

function plot!{S,T<:Real}(d::Dict{S,T}; ordered_by_keys=false, args...)

    x = String[]
    y = T[]
    
    if ordered_by_keys
        kys = sort(collect(keys(d)))
    else
        kys = keys_ordered_by_values(d)
    end
    
    for k in kys
        push!(x, string(k))
        push!(y, d[k])
    end
    
    return bar!(x,y; args...)
end

function bootstrap_histogram(v; label=string(now().instant.periods.value), plot_args...)

    bootstrap = bootstrap_resample_of_mean(v)
    p = histogram(bootstrap; alpha = 0.5, normalized=true, label=label, plot_args...)
    return density!(bootstrap; label="", linewidth=2, color=:black)

end


function bootstrap_histogram!(v; label=string(now().instant.periods.value), plot_args...)

    bootstrap = bootstrap_resample_of_mean(v)
    p = histogram!(bootstrap; alpha = 0.5, normalized=true, label=label, plot_args...)
    return density!(bootstrap; label=label, linewidth=2, label="", color=:black)

end


"""
## `recordfig(filename, models...)`

Save the current `Plots` figure as a PNG file called `filename` (which
must include ".png" extension) and generate a markdown report
containing an embedded version of the figure and the output of
`showall(model)` for each `model` in `models` (ususually metadata
associated with the plot).

For example, if the filename is "assets/myplot.png" then two files
"assets/myplot.png" and "assets/myplot.md" are created.

"""
function recordfig(figure_filename::String, models...)
    local_figure_filename = match(r"([^\/]*)$", figure_filename)[1]
    title = match(r"(.*)\..*$", local_figure_filename)[1]
    md_filename = match(r"(.*)\..*$", figure_filename)[1] * ".md"
    savefig(figure_filename)
    open(md_filename,"w") do md_file
        write(md_file, "# $title\n\n")
        write(md_file, "![$local_figure_filename]($local_figure_filename)\n\n")
        for model in models
            showall(md_file, model)
            println(md_file, "\n\n")
        end
    end
    println("Recorded figure and metadata at $md_filename.")
end


end # of module


