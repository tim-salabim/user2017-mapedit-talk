library(mapedit)
library(mapview)
library(sf)
# library(rmapshaper)

### most basic call to draw things
drawn = editMap()
drawn
mapview(drawn)

### edit existing map
m = leaflet() %>%
  addTiles() %>%
  addPolygons(data = franconia)

drawn_on_map = editMap(m)

drawn_on_map

m %>% addFeatures(drawn_on_map$finished,
                  fillColor = "magenta",
                  color = "magenta",
                  fillOpacity = 0.6)



### edit existing features
franc = st_cast(franconia[1:5, ], "POLYGON")
edited = editFeatures(franc, record = TRUE)
mapview(edited)



### select features
selected = selectFeatures(franconia)
selected
mapview(selected)


### "real-world" examples ====================================================
MODIS::getTile()


## centroids
mapview(franconia) + st_centroid(franconia)

pol = sf::st_cast(franconia[2, ], "POLYGON")[2, ]
cntrd = sf::st_centroid(pol)
mapview(pol) + cntrd

cntrd_new = editFeatures(cntrd, map = mapview(pol))
mapview(pol) + cntrd_new


### recorder playback
mapedit:::playback(edited)




# mapview(drawn_on_map[-c(4)],
#         col.regions = list("red", "green", "purple"),
#         color = list("red", "green", "purple"),
#         hide = TRUE)

# mapview(drawn_on_map$finished, col.regions = "magenta") + franconia




# ### in the pipe
# leaflet() %>%
#   addFeatures((sel <<- selectFeatures(franconia)),
#               popup = popupTable(sel)) %>%
#   addTiles() %>%
#   addMouseCoordinates()



# franc = rmapshaper::ms_simplify(as(franconia[1:5, ], "Spatial"))
# modified = editFeatures(franc, record = TRUE)
#
# mapview(modified)
#
# mapedit:::playback(modified)
