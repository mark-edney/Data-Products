library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Toronto Bike Rental June 2020"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("dur",
                        "Trip Duration:",
                        min = 0,
                        max = 500,
                        value = c(0,500)),
            
            checkboxInput("freq",
                        "Exclude annual users:",
                        value = FALSE
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            renderText("The difference between the mean annual and the mean casual user is:"),
            textOutput("dif"),
            h3("UI Documentation:"),
            ("The UI uses a user inputted slider to limit the x values on the histograph.
                                 The user can also use the check box to remove users with annual passes."),
            h3("Server Documentation:"),
            ("The server downloads and install the necessary packages. It also needs
            to download the data with the Open Toronto package.
            It then filters and cleans up the data. The server than calculates 
            the difference between the average Annual usage and the Casual pass usage for the month.
            The server receives the values inputted from the UI.
            The server uses the checkbox option to limit the data, removing annual pass users.
            The server finally plots the data"),
        )
    )
))
