shinyUI(pageWithSidebar(
    headerPanel("Example plot"),
    sidebarPanel(
        sliderInput('mu', 'Guess at the man', value = 70, min = 62, max = 74, step = 0.05)
    ),
    mainPanel(
        plotOutput('newHist')
     )
    ))