library(shiny)
library(leaflet)

ui <- fluidPage(
  theme = shinytheme('darkly'),
  # TEXT
  titlePanel(h1("House Finder")),
  p("Welcome to the House Finder Shiny App, where you can find
              your ideal place to live!", style = "font-size: 18px"),
  p("Currently, you can look at factors such as Crime Rate, Housing Price Index, Precipitation, and Location.
    With the help of our interactive map, you can explore places in the United States to find your new home.", style = "font-size: 18px"),
  br(),
  p("Adjust the sliders below to filter your choices", style = "font-size: 16px"),
  hr(),
  
  # INTERACTIVE INPUTS
  sidebarLayout(
    sidebarPanel(
      sliderInput("range1", h4("Median Home Price ($)"), 0, max(AllData3$HomeSalesPrice),
                  value = range(AllData3$HomeSalesPrice), step = 100000),
      sliderInput("range", h4("Annual Precipitation (inches)"), 0, max(AllData3$AnnualPrecip),
                value = range(AllData3$AnnualPrecip), step = 500),
      sliderInput("range2", h4("Property Crime Rate (per 1000 residents)"), 0, max(AllData3$PropCrimeRatePer1000),
                  value = range(AllData3$PropCrimeRatePer1000), step = 10),
      checkboxGroupInput("choices", label = h4("Factors"), 
                         choices = list("HPI" = 1, "Weather" = 2, "Crime" = 3)),
      fluidRow(column(3, verbatimTextOutput("value")))
    ),
    
  # MAP
    mainPanel(
      leafletOutput('mymap', height = 600)
    )
  )
)

server <- function(input, output, session) {
  # Checkboxes
  output$value <- renderPrint({ input$choices })
  
  # MAP
  data <- reactive({
      AllData3[AllData3$AnnualPrecip >= input$range[1] & AllData3$AnnualPrecip <= input$range[2],]
    })
  
  output$mymap <- renderLeaflet({
    AllData3 <- data()
    
    m <- leaflet(data = AllData3) %>%
      addTiles() %>%
      setView(-95, 41, zoom = 4.4) %>%
      addMarkers(lng = ~LNG,
                 lat = ~LAT,
                 popup = paste('Population:', AllData3$Population, "<br>",
                               'Annual Precipitation:', AllData3$AnnualPrecip, "<br>",
                               'Property Crime:', AllData3$Property))
    m
  })
}

shinyApp(ui = ui, server = server)
