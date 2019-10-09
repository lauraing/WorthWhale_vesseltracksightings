#Converting GPX files to CSV for the 2017 folder
library(plotKML)
library(tidyverse)
library(janitor)
library(rgdal) 


#first, set the wd to the vesseltracksightings
setwd("C:/Users/sidg0/Documents/Bren/WorthWhale/Research_Vessel_Tracks/WorthWhale_vesseltracksightings/2017")
gpx_sightings2017 <- list.files() #list the files within the 2017 folder 
# Initialise empty data frame -- set up for loop
gpx_full <- NULL

for (i in 1:length(gpx_sightings2017)[1]) {
  # - Select first file from the list and import data into R object
  tracklist <- readGPX(gpx_sightings2017[i], metadata = FALSE,
                     bounds = FALSE,
                     waypoints = FALSE,
                     routes = FALSE)
  # extract latitude, longituDe, elevation, time, name and comments and apppend to R dataframe
  tracksdf<- tracklist$tracks
  # append dataframe from last index to a full waypoint object
  gpx_full <- bind_rows(gpx_full, tracksdf)
}
head(gpx_full)
#TEST
# gpx_raw <- readGPX(gpx_sightings2017[2:4],
#                    metadata = FALSE,
#                    bounds = FALSE,
#                    waypoints = FALSE,
#                    routes = FALSE)

#TEST
#head(gpx_raw)

#TEST
# gpx_filepath = file.path("C:/Users/sidg0/Documents/Bren/WorthWhale/Research_Vessel_Tracks/WorthWhale_vesseltracksightings/2017", gpx_sightings2017)
# gpx_dataset <- do.call("rbind",lapply(gpx_filepath,FUN=function(files){ readGPX(files, metadata = FALSE,
#                                                                                 bounds = FALSE,
#                                                                                 waypoints = FALSE,
#                                                                                 routes = FALSE)}))

#i= gpx_sightings2017[1:5] Need to figure out how to loop all the gpx files into the code frew provided

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