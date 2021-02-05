#install.packages("opendatatoronto", repos = "http://cran.us.r-project.org", dependencies = TRUE)
#install.packages("tidyverse","lubridate")
library(opendatatoronto)
library(tidyverse)
library(lubridate)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # get package
    package <- show_package("7e876c24-177c-4605-9cef-e50dd74c617f")
    
    # get all resources for this package
    resources <- list_package_resources("7e876c24-177c-4605-9cef-e50dd74c617f")
    # identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
    datastore_resources <- filter(resources, tolower(format) %in% c('zip', 'geojson'))
    # load the first datastore resource as a sample
    data <- filter(datastore_resources, name == "Bike share ridership 2020") %>% get_resource()
    data2 <-  data$`2020-06.csv`
    data2[grepl("Time",names(data2))] <- 
        lapply(data2[grepl("Time",names(data2))], parse_date_time, orders = "mdy HM")
    data2$Dur <- as.numeric(data2$End.Time - data2$Start.Time,units="mins")
    data2 <- data2[1:176,]
    data3 <- data2[1:176,]
    anni <- data2$Dur[data2$User.Type=="Annual Member"]
    cas <- data2$Dur[data2$User.Type=="Casual Member"]
    dif <- round((mean(anni)-mean(cas)),2)
    output$dif <- renderText({c("The difference between the mean Annual pass usage and casual pass is :", 
        dif," minutes")})
    output$distPlot <- renderPlot({
        minx <- input$dur[1]
        maxx <- input$dur[2]
        
        ifelse(input$freq==TRUE,
               data3 <- data2[data2$User.Type == "Casual Member",],
               data3 <- data2)
        
        g <- ggplot(data3, aes(x=Dur, fill = User.Type)) + geom_histogram() + 
            xlim(minx,maxx) + labs(x="Trip Duration", y="Count")
g
    })

})
