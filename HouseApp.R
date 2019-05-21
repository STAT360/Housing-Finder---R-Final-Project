library(shiny)
library(leaflet)

ui <- fluidPage(
  theme = shinytheme('darkly'),
  
  # Title Text
  
  titlePanel(h1("House Finder!")),
  p("Welcome to the House Finder Shiny App, where you can find
              your ideal place to live!", style = "font-size: 18px"),
  p("Currently, you can look at factors such as Crime, Housing Prices, Precipitation, and Location.
    With the help of our interactive map, you can explore places in the United States to find your new home.", style = "font-size: 18px"),
  hr(),
  
  # Interactive Inputs
  
  sidebarLayout(
    sidebarPanel(
      h5('Adjust sliders to narrow your options.'),
      sliderInput("range1", h4("Median Home Price ($)"), 0, max(AllData3$HomeSalesPrice),
                  value = range(AllData3$HomeSalesPrice), step = 50000),
      sliderInput("range", h4("Year to Date Precipitation (inches)"), 0, max(AllData3$YTDprecip),
                value = range(AllData3$YTDprecip), step = 5),
      sliderInput("range2", h4("Property Crime Rate (per 1000 residents)"), 0, 81,
                  value = range(AllData3$PropCrimeRatePer1000), step = 5)
    ),
    
  # Panels with map and table output
  
    mainPanel(
      tabsetPanel(type = 'tabs',
                  tabPanel('Map View',
                           h4('Click on a city marker to learn more!'),
                           leafletOutput('mymap', height = 600)),
                  tabPanel('Table View',
                           h4('Click on a column name to sort your results!'),
                           h5('Example: Click "HomeSalePrice" to order by smallest to largest, then click it again to order by largest to smallest'),
                           br(),
                           dataTableOutput('table'))
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Reactive Data
  
  data <- reactive({
      AllData3[AllData3$YTDprecip >= input$range[1] & AllData3$YTDprecip <= input$range[2] &
                 AllData3$HomeSalesPrice >= input$range1[1] & AllData3$HomeSalesPrice <= input$range1[2] &
                 AllData3$PropCrimeRatePer1000 >= input$range2[1] & AllData3$PropCrimeRatePer1000 <= input$range2[2], ]
    })
  
  # Reactive Table
  
  output$table <- renderDataTable({
    data()
  })
  
  # Reactive Map
  
  output$mymap <- renderLeaflet({
    AllData3 <- data()
    
    m <- leaflet(data = AllData3) %>%
      addTiles() %>%
      setView(-95, 38, zoom = 4.4) %>%
      addMarkers(lng = ~LNG,
                 lat = ~LAT,
                 popup = paste(AllData3$City, ', ', AllData3$State, "<br>",
                               'Population:', AllData3$Population, "<br>",
                               'Median Home Price: $', AllData3$HomeSalesPrice, '<br>',
                               'YTD Precipitation:', AllData3$YTDprecip, 'inches',"<br>",
                               'Property Crime Rate:', AllData3$PropCrimeRatePer1000, "<br>")
                 )
    m
  })
}

shinyApp(ui = ui, server = server)
