library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Data science FTW!"),
    sidebarPanel(
        h3('Sidebar text')
        ),
    mainPanel(
        h3('Main Panel text')
        )
    ))


## Example run:  runApp("C:/Users/bliap/Documents/GitHub/Data-Science-Specialization/09-DevelopingDataProducts/Shiny/Example1")
