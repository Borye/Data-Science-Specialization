library(shiny)
library(rCharts)
library(maps)
library(mapdata)
library(maptools)
library(data.table)
library(reshape2)
library(markdown)
library(ggplot2)
library(grid)
library(stringi)


shinyServer(function(input, output){
    
    weather.sub <- reactive({
        # Sys.setlocale()
        data <- subset(weather, 
               t_json >= as.numeric(as.POSIXlt(paste("2015-01-13", input$range_1), format = "%Y-%m-%d %H:%M", origin = "2015-01-13 00:00:00"))
               & t_json <= as.numeric(as.POSIXlt(paste("2015-01-13", input$range_2), format = "%Y-%m-%d %H:%M", origin = "2015-01-13 00:00:00")) 
               & city %in% input$which_city,
               select = c("city", "cityid", "temp", "WD", "SD", "WSE", "time", "t_json", "degree", "province")
               )
        data
          })
    
    output$Location <- renderPlot({
        weather_sub <- weather.sub()
        getColor <- function(mapdata, provname, provcol, othercol)
        {
            f = function(x, y){ifelse(x %in% y, which(y == x), 0)};
            colIndex = sapply(iconv(mapdata@data$NAME, "GBK", "UTF-8"), f, provname);  
            col = c(othercol, provcol)[colIndex + 1];
            return(col);
        }
        provname <- stri_unescape_unicode(weather_sub$province[1])
        plot(map, col = getColor(map, provname, "blue", "white"))
          }, height = 500)
    
    output$TempSD <- renderChart({
        weather_sub <- weather.sub()
        # options(viewer = NULL)   
        dat <- weather_sub[, c("temp", "SD", "t_json")]
        names(dat) <- c("Tempreture", "Humidity", "t_json")
        dat <- melt(dat, id = c("t_json"), measure.vars = c("Tempreture", "Humidity"))
        TempSD <- nPlot(value ~ t_json, group = 'variable', data = dat[order(dat$t_json), ], type = 'lineChart', dom = 'TempSD', width = 650)
        TempSD$xAxis(
            tickFormat =   "#!
            function(d) {return d3.time.format('%Y-%m-%d %H:%M')(new Date(d*1000));}
            !#")
        TempSD$params$width <- 550
        TempSD$params$height <- 400
        TempSD$chart(margin = list(left = 40))
        TempSD$yAxis(axisLabel = "Celsius/percent", width = 40)
        TempSD$xAxis(axisLabel = "time", width = 70)
        return(TempSD)
          })
    
    output$Wind <- renderPlot({
        weather_sub <- weather.sub()
        names(weather_sub)[which(names(weather_sub) == "temp")] <- "tempreture"
        scaling <- c(as.numeric(diff(range(weather_sub$time)))*60*60/8, diff(range(weather_sub$WSE)))/8
        dat <- within(weather_sub, {
            x.end <- time  + scaling[1] * cos(degree / 180 * pi)
            y.end <- WSE + scaling[2] * sin(degree / 180 * pi)
        })
        ggplot(data = dat, aes(x = time, y = WSE)) +
            geom_line(size = 1) +
            geom_segment(data = dat,
                         size = 2,
                         aes(x = time,
                             xend = x.end,
                             y = WSE,
                             yend = y.end,
                             color = tempreture),arrow = arrow(length = unit(0.5, "cm"))) +
                             scale_colour_gradient(low="blue", high="red") + coord_cartesian(ylim = c(-1, 6)) +
                             
            theme_set(theme_bw()) + labs(x = "time", y = "Wind")
    })
    
})



