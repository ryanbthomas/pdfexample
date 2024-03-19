#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    #tags$head(
    #    tags$script(src="pdflib/build/pdf.mjs", type = "text/javascript"),
    #    tags$script(src="pdflib/web/viewer.mjs", type = "text/javascript")
    #    ),
    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput("pdf_file", label = "Select pdf file")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           uiOutput("pdf_viewer")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    observeEvent(input$pdf_file, {
        file.copy(input$pdf_file$datapath, "www/example.pdf")
    })
    
    output$pdf_viewer <- renderUI({
        req(input$pdf_file)
        shiny::tags$iframe(id = "pdf-js-viewer", style = "height:600px; width:100%", src = "pdflib/web/viewer.html?file=example.pdf")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
