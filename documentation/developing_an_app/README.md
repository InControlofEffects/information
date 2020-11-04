# Building an app with the `iceComponents` package

The `iceComponents` package was created to make the development of "page-by-page" styled applications much easier. This application structure may be useful if you want to create a shiny app that acts as a survey. Nearly all elements in the In Control of Effects application are available via this package. This guide will present a basic example for creating such an example.

## Getting Started

The `iceComponents` package can be installed from GitHub using any R package installer (e.g., `devtools`, `remotes`, `pack`, etc.).

```r
remotes::install_github("InControlofEffects/iceComponents")
```

To use the enable this package's features in your application, place the `use_iceComponents` function at the top of your app.

```r
library(shiny)

ui <- tagList(
    iceComponents::use_iceComponents(),
    ...
)
```
