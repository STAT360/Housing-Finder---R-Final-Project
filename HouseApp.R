library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("House Finder"),
  p("Welcome to the House Finder Shiny App, where you can find
              the ideal place for you to live!", style = "font-size: 20px"),
  br(),
  p("Currently, you can look at factors such as Crime Rate, Housing Price Index, Precipitation, and Location.
    With the help of our interactive map, you can explore places in the United States to find your new home.", style = "font-size: 20px"),
  leafletOutput('mymap', height = 1000),
  absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                width = 330, height = "auto",
                
                sliderInput("range", "Annual Precipitation", min(AllData$AnnualPrecip), max(AllData$AnnualPrecip),
                            value = range(AllData$AnnualPrecip), step = 100))
)

server <- function(input, output, session) {
  data <- reactive({
      AllData[AllData$AnnualPrecip >= input$range[1] & AllData$AnnualPrecip <= input$range[2],]
    })
  
  output$mymap <- renderLeaflet({
    AllData <- data()
    
    m <- leaflet(data = AllData) %>%
      addTiles() %>%
      addMarkers(lng = ~LNG,
                 lat = ~LAT,
                 popup = paste('Population:', AllData$Population, "<br>",
                               'Annual Precipitation:', AllData$AnnualPrecip, "<br>",
                               'Property Crime:', AllData$Property))
    m
  })
}

shinyApp(ui = ui, server = server)
