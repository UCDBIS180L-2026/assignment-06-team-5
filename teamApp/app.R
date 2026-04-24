library(shiny)
library(tidyverse)
# other libraries here

rice <- read_csv("./RiceDiversity.44K.MSU6.Phenotypes.csv") %>% 
  rename("ID"=NSFTVID)
load("./adm_results.Rdata")

rice <- left_join(rice, select(.data=adm_results, "ID"=ID, "pop"=assignedPop)) %>% 
  select(pop,where(is.numeric))
summary(rice)

# Define UI for application 
ui <- fluidPage(#create the overall page
  
  # Application title
  titlePanel("Rice Data by Population"),
  
  # Some helpful information
  helpText("This application allows you to see the correlation between",
           "traits based on population.  Please use the drop down menu", 
           "below to choose traits for plotting"),
  
  # Sidebar with two drop down menus to input which trait will be plotted
  sidebarLayout(
    sidebarPanel(
      selectInput("trait1", #the input variable that the value will go into
                   "Choose the first trait to display:",
                   colnames(rice)[colnames(rice) != "pop"]
      ),
      selectInput("trait2", #the input variable that the value will go into
                  "Choose the second trait to display:",
                  colnames(rice)[colnames(rice) != "pop"]
      ),
      checkboxGroupInput("pops",
                         "Choose population(s) to plot:",
                         unique(sort(rice$pop))
      )),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("pointPlot")
    )
  )
)

# Define server logic 
server <- function(input, output) {
  
  output$pointPlot <- renderPlot({
    
    plotTrait1 <- as.name(input$trait1)
    plotTrait2 <- as.name(input$trait2)
  
    pl <- rice %>% 
      filter(pop %in% input$pops) %>% 
      ggplot(rice, mapping = aes(x = !! plotTrait1,
                                 y = !! plotTrait2,
                                 color = pop)) +
      labs(
        title = paste(input$trait1, "vs", input$trait2, "by Population"),
        x = input$trait1,
        y = input$trait2,
        color = "Population"
      ) +
      scale_fill_brewer(palette = "Dark2")
    
    pl + geom_point() + scale_fill_discrete()
  
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
