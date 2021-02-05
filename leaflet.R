library(leaflet)
set.seed(2016-04-25)
df <- data.frame(lat= runif(50,min = 39.2, max = 39.3),
                 lng = runif(50, min = -76.6, max  = -76.5))
df %>%
        leaflet() %>%
        addTiles() %>%
        addCircleMarkers()
        #addMarkers(clusterOptions = markerClusterOptions())

