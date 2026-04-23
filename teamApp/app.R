library(shiny)
# other libraries here

# data loading and one-time processing here
rice <- read_csv("./teamApp/RiceDiversity.44K.MSU6.Phenotypes.csv")

# Define UI for application 
ui <- fluidPage( #create the overall page
    #UI code here
  )


# Define server logic 
server <- function(input, output) {
  
  rice %>% 
    ggplot(rice, mapping = aes(x = trait1,
                               y = trait1)) +
    geom_point()
}

# Run the application 
shinyApp(ui = ui, server = server)
