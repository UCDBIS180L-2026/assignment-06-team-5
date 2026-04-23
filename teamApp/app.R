library(shiny)
# other libraries here

rice <- read_csv("../teamApp/RiceDiversity.44K.MSU6.Phenotypes.csv") %>% 
  rename("ID"=NSFTVID)

load("../teamApp/adm_results.Rdata")

pops <- select(.data=adm_results, "ID"=ID, "pop"=assignedPop) 

rice <- left_join(rice, pops)

rice <- as_tibble(rice)
summary(rice)

# Define UI for application 
ui <- fluidPage(#create the overall page
  
  # Application title
  titlePanel("Rice Data by Population"),
  
  # Some helpful information
  helpText("This application allows you to see the correlation between",
           "traits based on population.  Please use the drop down menu", 
           "below to choose traits for plotting"),
  
  # Sidebar with a radio box to input which trait will be plotted
  sidebarLayout(
    sidebarPanel(
      selectInput("trait1", #the input variable that the value will go into
                   "Choose the first trait to display:",
                   colnames(rice)
      ),
      selectInput("trait2", #the input variable that the value will go into
                  "Choose the second trait to display:",
                  colnames(rice)
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
      ggplot(rice, mapping = aes(x = !! plotTrait1,
                                 y = !! plotTrait2
                             ))
    
    pl + geom_point()
  
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
