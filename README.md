# KoalaPlots

Plotting functions for use with
[Koala](https://github.com/ablaom/Koala.jl) that require
[Plots](https://github.com/JuliaPlots/Plots.jl) to be imported.

### Methods

    recordfig(filename, models...)

Save the current `Plots` figure as a PNG file called `filename` (which
must include ".png" extension) and generate a markdown report
containing an embedded version of the figure and the output of
`showall(model)` for each `model` in `models` (ususually metadata
associated with the plot).

For example, if the filename is "assets/myplot.png" then two files
"assets/myplot.png" and "assets/myplot.md" are created.



