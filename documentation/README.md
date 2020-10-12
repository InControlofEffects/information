![in control of effects](../imgs/incontrolofeffects.png)

# In Control of Effects
## Project Documentation

The primary output of this project is a [shiny application](https://shiny.rstudio.com) that provides antipsychotic medication recommendations based on an individual's preference for avoiding side effects. This application &mdash; the In Control of Effects app, or `iceApp` for short &mdash; is bundled into an R package and was built using several custom R packages, which are listed below.

- [iceApp](https://github.com/InControlofEffects/iceApp): The primary shiny application bundled into an R package.
- [iceData](https://github.com/InControlofEffects/iceData): an R package containing the primary dataset and user preferences function
- [iceComponents](https://github.com/InControlofEffects/iceComponents): all custom Shiny UI components were bundled into an R package
- [browsertools](https://github.com/davidruvolo51/browsertools): a package for communication between R and the client
- [rheroicons](https://github.com/davidruvolo51/rheroicons): the Heroicons library for R; an inline SVG icon library

This guide will provide more information about each of the In Control of Effects packages.

## The `iceData` package

The `iceData` R package is a primary dependency for the shiny application. This package provides the reference data and the function for generating medication recommendations based on side effects that users would like to avoid. The reference dataset was originally created by Huhn and colleague's 2019 paper [Comparative efficacy and tolerability of 32 oral antipsychotics for the acute treatment of adults with multi-episode schizophrenia: a systematic review and network meta-analysis](http://dx.doi.org/10.1016/S0140-6736(19)31135-3). 

The dataset provides risk scores of 7 side effects for 32 medications. Information about the medications, side effects, and data can be viewed in the R console using the following commands.


```r
# install
remotes::install_github("InControlofEffects/iceData")

# view
iceData::side_effects   # side effects information
iceData::med_info       # view licensing status
iceData::meds           # prints the entire dataset
```

Before you can generate medication recommendations, there are a few things you need to do.

**1. Define a new array of `weights` (i.e., user preferences)**

The first element that you will need is an array containing the user preferences for avoiding a side effect. Depending on the context in which the preferences are collected, the data type must be binary where `1` indicates the side effect that the user would like to avoid. It is recommended that the selections are structured using a named array. 

```r
w <- c(
    akathisia = 0,
    anticholinergic = 0,
    antiparkinson = 0,
    prolactin = 1,
    qtc = 0,
    sedation = 0,
    weight_gain = 0
)
```

The names are available via `iceData::side_effects` (Note: `weight` should be `weight_gain`; this will be fixed).

If you are using a UI component (for example, a checkbox input) for collecting responses, you can convert the responses to numeric like so.

```r
w <- c(
    akathisia = as.numeric(input$akathisia),
    anticholinergic = as.numeric(input$anticholinergic),
    ...
)
```

At this point, you can pass the array into the `user_preferences` function.

**2. Generating Recommendations**

The `user_preferences` function generates a new score per medication based on the user preferences for side effects. This approach is a weighted mean where each medication is rescored using the weights and ranked in descending order. Lower scores indicate that a medication will have a lower likelihood in causing the side effect that the user would like to avoid. 

```r
# array containing user preferences
w <- c(
    akathisia = 0,
    anticholinergic = 0,
    antiparkinson = 0,
    prolactin = 1,
    qtc = 0,
    sedation = 0,
    weight_gain = 0
)

# generate recommendations
results <- iceData::user_preferences(weights = w)
```

By default, the function uses the entire reference dataset (`iceData::meds`). However, this object is made available for...


Data should not be filtered for a specific side effect(s) as this function is designed to run with all seven side effects. 


## The `iceComponents` package


## The `iceApp` package