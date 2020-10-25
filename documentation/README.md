![in control of effects](../imgs/incontrolofeffects.png)

## Project Documentation

The primary output of this project is a [shiny application](https://shiny.rstudio.com) that provides antipsychotic medication recommendations based on an individual's preference for avoiding side effects. This application &mdash; the In Control of Effects app, or `iceApp` for short &mdash; is bundled into an R package and was built using several custom R packages, which are listed below.

- [iceApp](https://github.com/InControlofEffects/iceApp): The primary shiny application bundled into an R package.
- [iceData](https://github.com/InControlofEffects/iceData): an R package containing the primary dataset and user preferences function
- [iceComponents](https://github.com/InControlofEffects/iceComponents): all custom Shiny UI components were bundled into an R package
- [browsertools](https://github.com/davidruvolo51/browsertools): a package for communication between R and the client
- [rheroicons](https://github.com/davidruvolo51/rheroicons): the Heroicons library for R; an inline SVG icon library

To learn more about the application and the packages listed above, take a look at the following guides.

- [The application analytics module: logging user interactions](app_data/)
- [Generating medication recommendations with the `iceData` package](generating_recommendations/)
- [Building an app with the `iceComponents` package](developing_an_app/)