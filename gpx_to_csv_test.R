#Converting GPX files to CSV for the 2017 folder
library(plotKML)
library(tidyverse)
library(janitor)
library(rgdal) 


#first, set the wd to the vesseltracksightings

gpx_sightings2017 <- list.files("2017/", full.names = T) #list the files within the 2017 folder 
# Initialise empty data frame -- set up for loop
first_time <- T

for (gpx_file in gpx_sightings2017) {
  print(gpx_file)
  # - Select first file from the list and import data into R object
  tracklist <- readGPX(gpx_file, metadata = FALSE,
                     bounds = FALSE,
                     waypoints = FALSE,
                     routes = FALSE)
  # extract latitude, longituDe, elevation, time, name and comments and apppend to R dataframe
  tracksdf<- tracklist$tracks
  # append dataframe from last index to a full waypoint object
  if (first_time) {
    gpx_full <- tracksdf
    first_time <- F
  }
  else {
    gpx_full <- rbind(gpx_full, tracksdf)
  }
}
#head(gpx_full)


#from Frew
# g = readGPX("2017-03-31 20.50.14 Day.gpx",
#             metadata = FALSE,
#             bounds = FALSE,
#             waypoints = FALSE,
#             routes = FALSE)

#from frew
track_points = Reduce(rbind, gpx_raw$tracks[[1]])
head(track_points)

#write csv
write.csv(track_points, file = "GPXtoCSV.csv")