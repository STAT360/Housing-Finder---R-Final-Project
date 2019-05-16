## Data processing

library(tidyverse)
library(readxl)
library(xlsx)
library(datapasta)

files <- list.files()
tbl <- sapply(files, read_excel, simplify = FALSE) %>%
  bind_rows(.id = 'state')

AllStateCrimes <- tbl[, -14]

colnames(AllStateCrimes) <- c('State', 'City', 'Population', 'Violent', 'Murder', 'Rape', 'Rape2', 'Robbery', 'Aggra', 'Property', 'Burglary', 'Larc', 'Motor')

AllStateCrimes <- AllStateCrimes %>%
  filter(!is.na(Population), Population != 'Population') %>%
  mutate(State = substr(State, 43, nchar(State) - 17))

StateAbb <- data.frame(stringsAsFactors=FALSE,
       State = c("Alabama", "Alaska", "Arizona", "Arkansas", "California",
                     "Colorado", "Connecticut", "Delaware", "District_of_Columbia", "Florida",
                     "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
                     "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
                     "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
                     "Montana", "Nebraska", "Nevada", "New_Hampshire",
                     "New_Jersey", "New_Mexico", "New_York", "North_Carolina",
                     "North_Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
                     "Rhode_Island", "South_Carolina", "South_Dakota", "Tennessee", "Texas",
                     "Utah", "Vermont", "Virginia", "Washington",
                     "West_Virginia", "Wisconsin", "Wyoming"),
   Abbrev = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL",
                     "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA",
                     "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV",
                     "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA",
                     "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV",
                     "WI", "WY")
)

Crime <- StateAbb %>%
  merge.data.frame(AllStateCrimes, by = 'State') %>%
  select(-c('State', 'Rape2'))

colnames(Crime) <- c('State', 'City', 'Population', 'Violent', 'Murder', 'Rape', 'Robbery', 'Aggravated Assault', 'Property', 'Burglary', 'Larceny', 'Motor Vehicle')

####

Precip <- read_excel("~/Final/data/PrecipitationData.xlsx", 
                     col_names = c('State', 'City', 'AnnualPrecip'),
                     col_types = c("text", "text", "numeric"), skip = 1)
  
CrimeAndPrecip <- Crime %>%
  mutate(City = toupper(City)) %>%
  merge.data.frame(Precip, by = c('City', 'State'))

####

CityCoordinates <- read_csv("~/Final/data/CityCoordinates.csv", col_names = c('City', 'State', 'LAT', 'LNG'),   skip = 1)

AllData <- CityCoordinates %>%
  mutate(City = toupper(City)) %>%
  merge.data.frame(CrimeAndPrecip, by = c('City', 'State'))

### Prep data for mapping

AllData$LAT <- as.numeric(AllData$LAT)
AllData$LNG <- as.numeric(AllData$LNG)

