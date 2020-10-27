#'////////////////////////////////////////////////////////////////////////////
#' FILE: app_pages.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-10-27
#' MODIFIED: 2020-10-27
#' PURPOSE: app UI pages
#' STATUS: in.progress
#' PACKAGES: see global
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' Create application pages
pages <- list()
attr(pages, "title") <- "My Favorite Bird"


#' Create introduction page
pages$intro <- iceComponents::page(
    inputId = "page-a",
    `aria-labelledby` = "introduction-page-title",
    tags$h1(
        id = "introduction-page-title",
        "Welcome!"
    ),
    tags$p(
        "Welcome to the", tags$strong("Bird Survey Example"), "shiny ",
        "application. This is an example application for collecting the ",
        "number of bird species that were spotted. This is purely for ",
        "demonstration purposes only."
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

#' Create the instructions page
pages$instructions <- iceComponents::page(
    inputId = "page-b",
    `aria-labelledby` = "",
    tags$h1(
        id = "instructions-page-title",
        "How to use this app"
    ),
    tags$p(
        "In a moment, you will be presented with a list of species. Click ",
        "the name of bird or birds that you have seen. When you are submit your ",
        "selections. "

    )
)