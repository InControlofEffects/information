# Generating Medication Recommendations with the `iceData` package

The `iceData` R package is a primary dependency for the shiny application. This package provides the reference data and the function for generating medication recommendations. The dataset was originally developed by Huhn and colleague's 2019 paper [Comparative efficacy and tolerability of 32 oral antipsychotics for the acute treatment of adults with multi-episode schizophrenia: a systematic review and network meta-analysis](http://dx.doi.org/10.1016/S0140-6736(19)31135-3). This guide will provide an overview on the `iceData` package and provide examples on how to use it.

Before you begin, it's important to note that any information produced by this tool should be discussed with an individual's psychiatrist or other healthcare provider as this app does not take into account individual patient characteristics, pre-existing medical conditions, any current medical treatment or medications may already be prescribed. Any concerns in regard to side effects, medications, or anything related to medical treatment should be discussed a healthcare provider.

## Contents

<!-- TOC depthFrom:2 -->

- [Contents](#contents)
- [Getting Started](#getting-started)
- [Defining user preferences](#defining-user-preferences)
- [Generating Recommendations](#generating-recommendations)
- [Limitations](#limitations)

<!-- /TOC -->

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

Before you can generate medication recommendations, there are a few things you need to do.

## Defining user preferences

First, create an array of the user preferences for each side effect. Depending on the context in which the preferences are collected, the data type must be binary where `1` means that the user would like to a side effect. Structure user preferences using the format below.

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

Named attributes are required as this ensures there is a score for each side effect. An error will be thrown if names do not exist. The names of side effects can be found in the `side_effects` object (see the variable `id`). Use the command `iceData::side_effects` to view this information.

If you are using the accordion input component from the `iceComponents` package or similar input component (e.g., checkbox, radio button, etc.), the response will be logical. You can convert responses to numeric using `as.numeric(input$some_id)`. 

```r
w <- c(
    akathisia = as.numeric(input$akathisia),
    anticholinergic = as.numeric(input$anticholinergic),
    antiparkinson = as.numeric(input$antiparkinson),
    prolactin = as.numeric(input$prolactin),
    qtc = as.numeric(input$qtc),
    sedation = as.numeric(input$sedation),
    weight_gain = as.numeric(input$weight_gain)
)
```

Regardless of the input type, the sum of the weights must be 1. Research on the presence of multiple side effects &mdash; in relation to the medications included in this dataset &mdash; is limited. At this time, there is not enough evidence to support multiple side effect selections. Allowing multiple user selections should not be enabled.

At this point, you can pass the array into the `user_preferences` function.

## Generating Recommendations

The `user_preferences` function generates a new score per medication based on the user preferences for side effects. This approach is a weighted mean where each medication is re-scored using the weights and ranked in descending order. Lower scores indicate that a medication will have a lower likelihood in causing the side effect that the user would like to avoid. 

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

# print results
results                     
#> # A tibble: 32 x 3
#>    id    name          score
#>    <chr> <chr>         <dbl>
#>  1 CLO   Clozapine    -77.0 
#>  2 ZOT   Zotepine     -42.2 
#>  3 PERA  Perazine     -13.4 
#>  4 FPX   Flupentixol  -10.4 
#>  5 ARI   Aripiprazole  -7.1 
#>  6 PIM   Pimozide      -3.91
#>  7 CAR   Cariprazine   -3.19
#>  8 QUE   Quetiapine    -1.17
#>  9 CPX   Clopenthixol   0   
#> 10 FLU   Fluphenazine   0   
#> # … with 22 more rows
```

By default, the function uses full `iceData::meds` dataset. You can limit the medication dataset for a specific country or countries. Apply filters outside the `user_preferences` function, and then pass in through the `data` argument.

```r
library(dplyr)

# array containing user preferences (i.e., weights)
w <- c(
    akathisia = 0,
    anticholinergic = 0,
    antiparkinson = 0,
    prolactin = 1,
    qtc = 0,
    sedation = 0,
    weight_gain = 0
)

# filter for medications with valid licensing status in Germany
meds_germany <- iceData::meds %>% filter(Germany == 1)
results_germany <- iceData::user_preferences(data = meds_germany, weights = w)

# view results
results_germany
#> # A tibble: 23 x 3
#>    id    name          score
#>    <chr> <chr>         <dbl>
#>  1 CLO   Clozapine    -77.0
#>  2 ZOT   Zotepine     -42.2
#>  3 FPX   Flupentixol  -10.4
#>  4 ARI   Aripiprazole  -7.1
#>  5 PIM   Pimozide      -3.91
#>  6 CAR   Cariprazine   -3.19
#>  7 QUE   Quetiapine    -1.17
#>  8 CPX   Clopenthixol   0
#>  9 LOX   Loxapine       0
#> 10 PEN   Penfluridol    0
#> # … with 13 more rows
```

## Limitations

Before you use this package in any project, there are a few important limitations to discuss.

1. Most important, results do not account for existing diagnoses, treatments or medications that you may already be taking, or any other medical condition. If you have any concerns about side effects or medical treatment, these should be discussed with your healthcare provider.
2. Data should not be filtered for a specific side effect(s). This function is designed to run with all seven side effects.
3. The sum of the weights must be 1. Otherwise, an error will be thrown.
4. There is not enough evidence to support multiple side effect selections. Do not create UIs that allow multiple user selections.
