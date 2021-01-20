# This is my app!

library(tidyverse)
library(shiny)

# options for customization CSS, shinythemes, shinyjs (advanced), shiny dashboard or flex dashboard (interactive interface)
# with CSS have to have it in a subfolder www in the same folder
ui <- fluidPage(theme  = "ocean.css",

  navbarPage("THIS IS MY TITLE!",
             tabPanel("Thing 1",
                      sidebarLayout(
                        sidebarPanel("WIDGETS!",
                                     checkboxGroupInput(inputId = "pick_species",
                                                        label = "Choose species:",
                                                        choices = unique(starwars$species))
                                     ),
                        mainPanel("OUTPUT!",
                                  plotOutput("sw_plot"))
                        )
                      ),
             tabPanel("Thing 2"),
             tabPanel("Thing 3")

  )

)

server <- function(input, output) {

  sw_reactive <- reactive({

    starwars %>%
      filter(species %in% input$pick_species)

  })

  output$sw_plot <- renderPlot(
    ggplot(data = sw_reactive(), aes(x = mass, y = height)) +
      geom_point(aes(color = species))
  )

}

shinyApp(ui = ui, server= server)

