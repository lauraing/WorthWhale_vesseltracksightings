#Converting GPX files to CSV
library(plotKML)
library(tidyverse)
library(janitor)
library(rgdal) 


#first, set the wd to the vesseltracksightings
setwd("C:/Users/sidg0/Documents/Bren/WorthWhale/Research_Vessel_Tracks/WorthWhale_vesseltracksightings/2017")
gpx_sightings2017 <- list.files() #list the files within the 2017 folder 
gpx_raw <- readGPX(gpx_sightings2017[2:4],
                   metadata = FALSE,
                   bounds = FALSE,
                   waypoints = FALSE,
                   routes = FALSE)

head(gpx_raw)

# gpx_filepath = file.path("C:/Users/sidg0/Documents/Bren/WorthWhale/Research_Vessel_Tracks/WorthWhale_vesseltracksightings/2017", gpx_sightings2017)
# gpx_dataset <- do.call("rbind",lapply(gpx_filepath,FUN=function(files){ readGPX(files, metadata = FALSE,
#                                                                                 bounds = FALSE,
#                                                                                 waypoints = FALSE,
#                                                                                 routes = FALSE)}))

#i= gpx_sightings2017[1:5] Need to figure out how to loop all the gpx files into the code frew provided


# g = readGPX("2017-03-31 20.50.14 Day.gpx",
#             metadata = FALSE,
#             bounds = FALSE,
#             waypoints = FALSE,
#             routes = FALSE)

track_points = Reduce(rbind, gpx_raw$tracks[[1]])

head(track_points)

#write csv
write.csv(track_points,paste0() file = "GPXtoCSV.csv")