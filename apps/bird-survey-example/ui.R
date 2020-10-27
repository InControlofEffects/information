#'////////////////////////////////////////////////////////////////////////////
#' FILE: ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-10-27
#' MODIFIED: 2020-10-27
#' PURPOSE: UI for bird-survey-example
#' STATUS: in.progress
#' PACKAGES: see global.R
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

ui <- tagList(
    iceComponents::use_iceComponents(),
    iceComponents::container(
        uiOutput("app_page")
    )
)