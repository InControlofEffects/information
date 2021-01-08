#'////////////////////////////////////////////////////////////////////////////
#' FILE: app.R
#' AUTHOR: David Ruvolo
#' CREATED: 2021-01-08
#' MODIFIED: 2021-01-08
#' PURPOSE: example book-like apps
#' STATUS: in.progress
#' PACKAGES: iceComponents; shiny;
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' pkgs
#' remotes::install_github("InControlofEffects/iceComponents")
suppressPackageStartupMessages(library(shiny))

#' ui
ui <- tagList(
    iceComponents::use_iceComponents(),
    iceComponents::container(
        uiOutput("app_page")
    )
)

#' server
server <- function(input, output) {

    page_counter <- reactiveVal(1)

    observeEvent(input$back_button, {
    })

    observeEvent(input$forward_btn, {
    })

    observe({
        output$app_page <- renderUI({
            app_pages[[page_counter]]
        })
    })
}

#' runApp
shinyApp(ui, server)