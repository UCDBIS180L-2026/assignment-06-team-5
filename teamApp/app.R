library(shiny)
# other libraries here

rice <- read_csv("RiceDiversity.44K.MSU6.Phenotypes.csv")

rice <- as_tibble(rice)
summary(rice)

# data loading and one-time processing here


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
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
