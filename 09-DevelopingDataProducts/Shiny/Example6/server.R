## set x <- 0, at outside
## refresh the page will see, the y is added 1 automaticlly, but x is the same

x <<- x + 1
y <<- 0

shinyServer(
    function(input, output) {
        y <<- y + 1
        output$text1 <- renderText({input$text1})
        output$text2 <- renderText({input$text2})
        output$text3 <- renderText({as.numeric(input$text1) + 1})
        output$text4 <- renderText(y)
        output$text5 <- renderText(x)
    })

## runApp(display.mode = 'showcase')  will show the code on the page