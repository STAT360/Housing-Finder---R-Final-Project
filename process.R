## Data processing

library(tidyverse)
library(readxl)
library(xlsx)
library(datapasta)

# List state crime files in WD and bind (union) to create one US data frame

files <- list.files()
tbl <- sapply(files, read_excel, simplify = FALSE) %>%
  bind_rows(.id = 'state')

AllStateCrimes <- tbl[, -14]

colnames(AllStateCrimes) <- c('State', 'City', 'Population', 'Violent', 'Murder', 'Rape', 'Rape2', 'Robbery', 'Aggra', 'Property', 'Burglary', 'Larc', 'Motor')

# Removing repeated titles within df (from the union) and trimming lengthy state column name

AllStateCrimes <- AllStateCrimes %>%
  filter(!is.na(Population), Population != 'Population') %>%
  mutate(State = substr(State, 43, nchar(State) - 17))

# Used data pasta to quickly create df of state abbreviations

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

# Joining crime data with state abbreviations and removing column with entire State name
# Key fields will be City and State abbreviation

Crime <- StateAbb %>%
  merge.data.frame(AllStateCrimes, by = 'State') %>%
  select(-c('State', 'Rape2'))

colnames(Crime) <- c('State', 'City', 'Population', 'Violent', 'Murder', 'Rape', 'Robbery', 'Aggravated Assault', 'Property', 'Burglary', 'Larceny', 'Motor Vehicle')

# Loading precipiation data and joining with crime df

Precip <- read_excel("data/PrecipitationData.xlsx", 
                     col_names = c('State', 'City', 'AnnualPrecip'),
                     col_types = c("text", "text", "numeric"), skip = 1)
  
CrimeAndPrecip <- Crime %>%
  mutate(City = toupper(City)) %>%
  merge.data.frame(Precip, by = c('City', 'State'))

# Loading coordinates for mapping

CityCoordinates <- read_csv("/data/CityCoordinates.csv", col_names = c('City', 'State', 'LAT', 'LNG'),   skip = 1)

# Loading and joining house price data

HousePrice <- read_csv("data/HousePrice.csv")

HousePrice <- HousePrice %>%
  mutate(HomeSalesPrice = parse_number(HousePrice$`Median Sale Price`)) %>%
  select(c('City', 'State', 'HomeSalesPrice'))

# Finalizing data frame by merging house price data and converting appropriate fields to numeric

AllData3 <-HousePrice %>%
  merge.data.frame(AllData, by = c('City', 'State'))

AllData3 <- AllData3 %>%
  mutate(PropCrimeRatePer1000 = (parse_number(AllData3$Property)/parse_number(AllData3$Population)*1000))

AllData3[, c(3:17)] <- sapply(AllData3[, c(3:17)], as.numeric)
AllData3 <- AllData3 %>%
  mutate(PropCrimeRatePer1000 = round(PropCrimeRatePer1000, 2))

