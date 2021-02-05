library(shiny)
library(miniUI)
library(googleVis)

M <- gvisMotionChart(Fruits, "Fruit", "Year",
                     options = list(width= 600, height=400))
plot(M)

G <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit",
                options = list(width = 600, height =400))
print(M)
print(G, "chart")
