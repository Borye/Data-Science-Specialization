library(shiny)
library(rCharts)

#Sys.setlocale(, "CHS")

shinyUI(
    navbarPage("Weather Data Explorer",
        tabPanel("Main",       
               sidebarPanel(
                   h4("Range of time"),
                   h6("(min = 00:00,  max = 24:00)"),
                   textInput(inputId = "range_1", label = "From", value = "07:00"),
                   textInput(inputId = "range_2", label = "to", value = "19:00"),
                   h4("Province"),
                   radioButtons("which_city", "", 
                                c("北京市 (Beijing BJ)" = "\\u5317\\u4eac", "上海市 (Shanghai SH)" = "\\u4e0a\\u6d77", 
                                  "天津市 (Tianjing TJ)" = "\\u5929\\u6d25", "重庆市 (Chongqing CQ)" = "\\u91cd\\u5e86", 
                                  "黑龙江省 (Heilongjiang HL)" = "\\u54c8\\u5c14\\u6ee8", "吉林省 (Jilin JL)" = "\\u957f\\u6625", 
                                  "辽宁省 (Liaoning LN)" = "\\u6c88\\u9633", "内蒙古省 (Inner Mongoria IM)" = "\\u547c\\u548c\\u6d69\\u7279", 
                                  "河北省 (Hebei HB)" = "\\u77f3\\u5bb6\\u5e84", "新疆维吾尔自治区 (Xinjiang XJ)" = "\\u4e4c\\u9c81\\u6728\\u9f50", 
                                  "甘肃省 (Gansu GS)" = "\\u5170\\u5dde", "青海省 (Qinghai QH)" = "\\u897f\\u5b81", "陕西省 (Shaanxi SX)" = "\\u897f\\u5b89", 
                                  "宁夏回族自治区 (Ningxia NX)" = "\\u94f6\\u5ddd", "河南省 (Henan HA)" = "\\u90d1\\u5dde", "山东省 (Shandong SD)" = "\\u6d4e\\u5357", 
                                  "山西省 (Shanxi SX)" = "\\u592a\\u539f", "安徽省 (Anhui AH)" = "\\u5408\\u80a5", "湖北省 (Hubei HB)" = "\\u6b66\\u6c49", 
                                  "湖南省 (Hunan HN)" = "\\u957f\\u6c99", "江苏省 (Jiangsu JS)" = "\\u5357\\u4eac", "四川省 (Sichuan SC)" = "\\u6210\\u90fd", 
                                  "贵州省 (Guizhou GZ)" = "\\u8d35\\u9633", "云南省 (Yunnan YN)" = "\\u6606\\u660e", "广西壮族自治区 (Guangxi GX)" = "\\u5357\\u5b81", 
                                  "西藏自治区 (Tibet XZ)" = "\\u62c9\\u8428", "浙江省 (Zhejiang ZJ)" = "\\u676d\\u5dde", "江西省 (Jiangxi JX)" = "\\u5357\\u660c",
                                  "广东省 (Guangdong GD)" = "\\u5e7f\\u5dde", "福建省 (Fujian FJ)" = "\\u798f\\u5dde", "海南省 (Hainan HI)" = "\\u6d77\\u53e3")),
                   tags$small("Note: Here we use weather condition 
                              of the capital city of each province to 
                              represent the province in china. 
                              Location of the province is showed on the top. 
                              Down left shows the tempreture and humidity. 
                              Solid line in down left shows the wind level, 
                              while the arrow shows the wind direction")
                           ),
               
               mainPanel(
                   fixedPage(
                       fixedRow(
                           column(12, 
                                  h2('Location', align = "center"),
                                  plotOutput("Location", height = "500px"),
                                  fixedRow(
                                      column(6,  
                                             h2('Tempreture and Humidity', align = "center"),
                                             showOutput("TempSD", "nvd3")
                                      ),
                                      column(6, 
                                             h2('Wind level and direction', align = "center"),
                                             plotOutput("Wind", width = "105%")
                                      )
                                  )
                           )
                       )
                   )
    
               )),
              tabPanel("About",
                     mainPanel(
                         includeMarkdown("C:/Users/bliap/Documents/GitHub/Data-Science-Specialization/09-DevelopingDataProducts/Project/Shiny/include.md")
                             )
                         )
        )
)
        
               
        
