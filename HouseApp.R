library(shiny)

ui <- fluidPage(
  titlePanel("House Finder"),
  p("Welcome to the House Finder Shiny App, where you can find
              the ideal place for you to live!", style = "font-size: 20px"),
  br(),
  p("Currently, you can look at factors such as Crime Rate, Housing Price Index, Precipitation, and Location.
    With the help of our interactive map, you can explore places in the United States to find your new home.", style = "font-size: 20px")
)

server <- function(input, output, session) {
  
}

shinyApp(ui = ui, server = server)
