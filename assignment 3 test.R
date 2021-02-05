install.packages("opendatatoronto", repos = "http://cran.us.r-project.org",
                 dependencies = TRUE)
library(opendatatoronto)
library(dplyr)
library(plotly)
# get package
package <- show_package("64b54586-6180-4485-83eb-81e8fae3b8fe")

# get all resources for this package
resources <- list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe")
datastore_resources <- filter(resources, tolower(format) %in%
                                      c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data$`Reported Date` <- as.Date(data$`Reported Date`)

data2 <- data %>% count(`Reported Date`, `Age Group`)
names(data2)[3] <- "Count"
plot_ly(data = data2, y = ~Count, x = ~`Reported Date`, color = ~`Age Group`
        , mode = 'bar')
