library(shiny)
library(leaflet)

ui <- fluidPage(
  theme = shinytheme('darkly'),
  # TEXT
  titlePanel(h1("House Finder!")),
  p("Welcome to the House Finder Shiny App, where you can find
              your ideal place to live!", style = "font-size: 18px"),
  p("Currently, you can look at factors such as Crime, Housing Prices, Precipitation, and Location.
    With the help of our interactive map, you can explore places in the United States to find your new home.", style = "font-size: 18px"),
  hr(),
  
  # INTERACTIVE INPUTS
  sidebarLayout(
    sidebarPanel(
      h5('Adjust sliders to narrow your options.'),
      sliderInput("range1", h4("Median Home Price ($)"), 0, max(AllData3$HomeSalesPrice),
                  value = range(AllData3$HomeSalesPrice), step = 50000),
      sliderInput("range", h4("Annual Precipitation (inches)"), 0, max(AllData3$AnnualPrecip),
                value = range(AllData3$AnnualPrecip), step = 500),
      sliderInput("range2", h4("Property Crime Rate (per 1000 residents)"), 0, 81,
                  value = range(AllData3$PropCrimeRatePer1000), step = 5)
    ),
    
  # MAP
    mainPanel(
      tabsetPanel(type = 'tabs',
                  tabPanel('Map View', leafletOutput('mymap', height = 600)),
                  tabPanel('Table View', dataTableOutput('table')))
    )
  )
)

server <- function(input, output, session) {
  
  # MAP
  
  data <- reactive({
      AllData3[AllData3$AnnualPrecip >= input$range[1] & AllData3$AnnualPrecip <= input$range[2] &
                 AllData3$HomeSalesPrice >= input$range1[1] & AllData3$HomeSalesPrice <= input$range1[2] &
                 AllData3$PropCrimeRatePer1000 >= input$range2[1] & AllData3$PropCrimeRatePer1000 <= input$range2[2],]
    })
  
  output$table <- renderDataTable({
    data()
  })
  
  output$mymap <- renderLeaflet({
    AllData3 <- data()
    
    m <- leaflet(data = AllData3) %>%
      addTiles() %>%
      setView(-95, 39, zoom = 4.4) %>%
      addMarkers(lng = ~LNG,
                 lat = ~LAT,
                 popup = paste(AllData3$City, ', ', AllData3$State, "<br>",
                               'Population:', AllData3$Population, "<br>",
                               'Median Home Price: $', AllData3$HomeSalesPrice, '<br>',
                               'Annual Precipitation:', AllData3$AnnualPrecip, 'inches',"<br>",
                               'Property Crime Rate:', AllData3$PropCrimeRatePer1000, "<br>")
                 )
    m
  })
}

shinyApp(ui = ui, server = server)
