# Generating Medication Recommendations with the `iceData` package

The `iceData` R package is a primary dependency for the shiny application. This package provides the reference data and the function for generating medication recommendations. The dataset was originally developed by Huhn and colleague's 2019 paper [Comparative efficacy and tolerability of 32 oral antipsychotics for the acute treatment of adults with multi-episode schizophrenia: a systematic review and network meta-analysis](http://dx.doi.org/10.1016/S0140-6736(19)31135-3). This guide will provide an overview on the `iceData` package and provide examples on how to use it.

## Getting Started

To get started, install the `iceData` package from the [iceData GitHub repository](https://github.com/InControlofEffects/iceData). You can use `devtools`, `remotes`, `pak`, etc.

```r
remotes::install_github("InControlofEffects/iceData")
```

In side there package, there are few datasets available. These are listed in the following table.

| Name | Command | Description |
| ---- | ------- | ----------- |
| Medications | `iceData::meds` | dataset of 32 medications and the relative risk (RR) or standardized mean difference (SMD) for seven side effects
| Medication Info | `iceData::med_info` | List of medications and the licensing status by country (EU, UK, Germany, USA).
| Side Effects | `iceData::side_effects` | data about the side effects, including the medical term, common name, and definition.

All scores (relative risk and mean difference) per medication and side effect are located in the `meds` dataset. This object is arranged in long format. Included in `meds` is a grouping variable `quality`. This variable is a *rating* that indicates how *good* the scores are for each medication and side effects. Quality is determined by a number of factors (e.g., sample size, accuracy, etc.) and given a rating of *very low*, *low*, *moderate*, or *high*.  

In addition, the `meds` dataset includes licensing status by country and medication. However, data is structured in long format and repeated. Instead, use the `med_info` object. License status is binary (1 = approved) and is available for Germany, the UK, and the USA. This information is still in development and will be improved in the coming months (see [issue #2](https://github.com/InControlofEffects/iceData/issues/2) for more information).

The `side_effects` object was created to automate the generation of the side effects selection UI. Medical terms are used as accordion component Ids (i.e., shiny server `input$...`). The common name and definitions are also used in the accordion component. This data defines the title and collapsible content.

## Generating Recommendations

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