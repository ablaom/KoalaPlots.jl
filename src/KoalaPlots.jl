module KoalaPlots

export recordfig

import Plots.savefig

"""
    recordfig(filename, models...)

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
    info("Recorded figure and metadata at $md_filename.")
end

end # of module


