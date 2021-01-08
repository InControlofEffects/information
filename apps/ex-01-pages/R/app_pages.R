#'////////////////////////////////////////////////////////////////////////////
#' FILE: app_pages.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-10-27
#' MODIFIED: 2021-01-08
#' PURPOSE: app UI pages
#' STATUS: in.progress
#' PACKAGES: see global
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' Create application pages
app_pages <- list()
attr(app_pages, "title") <- "The IceComponents R package"

#' create list of code fragments
code <- list()

#' Create introduction page
app_pages$intro <- iceComponents::page(
    inputId = "page-a",
    `aria-labelledby` = "introduction-page-title",
    tags$h1(
        id = "introduction-page-title",
        "Welcome!"
    ),
    tags$p(
        "Welcome to the", tags$strong("In Control of Effects"),
        "shiny example application. This example demonstrates how to create ",
        "book-like applications where you must click through a series of ",
        "to get to a result. This approach may be useful for creating ",
        "surveys or information pages on top of an existing application."
    ),
    tags$p(
        "Press the start button to continue."
    ),
    iceComponents::navigation(
        iceComponents::forward_btn(
            label = "Start"
        )
    )
)

#' isolate code fragment to preserve indentation
code$install <- '
remotes::install_github("InControlofEffects/iceComponents")
'

#' Create `Getting Started` page
app_pages$getStarted <- iceComponents::page(
    inputId = "page-b",
    `aria-labelledby` = "getting-started-page-title",
    tags$h1(
        id = "getting-started-page-title",
        "Getting Started"
    ),
    tags$p(
        "To get started, you will need to install the ",
        tags$code("iceComponents"), "R package from GitHub.",
    ),
    tags$pre(
        tags$code(code$install)
    ),
    tags$p("See ",
        tags$a(
            href = "https://github.com/InControlofEffects/iceComponents",
            "https://github.com/InControlofEffects/iceComponents"
        ),
        "for more information. Press next to continue"
    ),
    iceComponents::navigation(
        iceComponents::forward_btn(
            label = "Next"
        )
    )
)

attr(pages$get_started, "title") <- "Get Started"

#' Create Basic Use Page
app_pages$basic_use <- iceComponents::page(
    inputId = "page-c",
    `aria-labelledby` = "basic-use-page-title",
    tags$h1(
        id = "basic-use-page-title",
        "Basic Use"
    ),
    tags$p(
        "The 'page turning' structure of the app works by rendering the UI ",
        "server side. All pages are nested in a list object using the",
        tags$code("page"), " function. Use the ",
        tags$code("forward_btn"), "and", tags$code("back_btn"), "components ",
        "to handle page navigation."
    )
)

attr(app_pages$basic_use, "title") <- "Basic Use"