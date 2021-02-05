library(shiny)
library(miniUI)

myfirstgadget <- function (){
        ui <- miniPage(
                gadgetTitleBar("My first gadget")
        )
        
        server <- function(input, output, session){
                observeEvent(input$done, {stopApp ()})
        }
        runGadget(ui,server)
}
