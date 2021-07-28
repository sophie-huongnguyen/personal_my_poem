#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(tidyr)
library(dplyr)


# list all the poems
# three pages navigation bar
# page 1: list of all poems order by poem name
poem_list <- read.csv("poem_list.csv")


# Define UI for application that draws a histogram
# Define UI for application that draws a histogram
ui <- fluidPage(
    tags$head(
        # Note the wrapping of the string in HTML()
        tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
      body {
        background-color: black;
        color: white;
      }
      h2 {
        font-family: 'Yusei Magic', sans-serif;
      }
      h3 {
        font-family: 'Yusei Magic', sans-serif;
      }
      pre {
        background-color: black;
        color: white;
        font-family: 'Yusei Magic', sans-serif;
      }
      .shiny-input-container {
        color: #474747;
      }"))
    ),
    
    # Application title
    titlePanel("My poems"),
    
    # Navigate bars with 3 tabs 
    navlistPanel(
        tabPanel("Poem library", 
                 h3("My collection"),
                 tableOutput("poem_list")
        ),
        tabPanel("Game 1",
                 h1("Remember me"),
                 p("Recite the poem drawn"),
                 actionButton(inputId = "draw_poem_name", label = "Draw your poem"),
                 textOutput(outputId = "draw_poem_name__output"),
                 br(),
                 actionButton(inputId = "get_poem__from_name", label = "Answer"),
                 htmlOutput(outputId = "get_poem__from_name__output")
        ),
        tabPanel("Game 2",
                 h1("The rest of me"),
                 p("Draw a cue (a line) then recite the rest of the poem"),
                 actionButton(inputId = "game_poem_cue", label = "Draw your cue")
                 
        ),
        tabPanel("Game 3",
                 h1("All"),
                 p("Print out a poem"),
                 selectInput(inputId = "game_poem_selected", label = "Select your poem", choices = poem_list$poem_name),
                 br(),
                 actionButton(inputId = "get_poem__selected", label = "Show the poem"),
                 htmlOutput("game4_poem_all")
        )
    )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$poem_list <- renderTable(poem_list)

    rv <- reactiveValues(stage1 = 0,
                         draw_poem_name__output = poem_list$poem_name[1],
                         stage2 = 0,
                         stage4 = 0)
    
    # recite a random poem
    observeEvent(input$draw_poem_name, {
        rv$draw_poem_name__output = poem_list$poem_name[sample.int(nrow(poem_list), 1)]
        rv$stage1 = 0
    })
    
    observeEvent(input$get_poem__from_name, {
        rv$stage1 = 1
    })
    
    output$draw_poem_name__output <- renderText({
        rv$draw_poem_name__output
    })
    
    output$get_poem__from_name__output <- renderUI({
        if (rv$stage1 == 1){
            test <- readLines(paste0("poems/", rv$draw_poem_name__output))
            raw_text <- paste(test, collapse = " \n ")
            tags$pre(raw_text)
        } else {
            img(src = "waiting_image.png", width = "50%", height = "auto")
        }

    })

    
    # review a selected poem
    observeEvent(input$game_poem_selected, {
        rv$stage4 = 0
    })
    
    observeEvent(input$get_poem__selected, {
        rv$stage4 = 1
    })
    
    output$game4_poem_all <- renderUI({
        if (rv$stage4 == 1){
            test <- readLines(paste0("poems/", input$game_poem_selected))
            raw_text <- paste(test, collapse = " \n ")
            tags$pre(raw_text)
        } else {
            img(src = "waiting_image.png", width = "50%", height = "auto")}
        }
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
