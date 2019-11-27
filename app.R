#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


#Import library
library(shiny)

#Import data
data("Titanic")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Titanic"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            h4("First Set (Blue)"),
            selectInput('survived', 'Survived', c("Yes", "No"), selected = "Yes"),
            selectInput('age', 'Age', c("Child", "Adult"), selected = "Adult"),
            selectInput('sex', 'Sex', c("Male", "Female"), selected = "Male"),
            br(),
            
            h4("Second Set (Red)"),
            selectInput('survived2', 'Survived', c("Yes", "No"), selected = "No"),
            selectInput('age2', 'Age', c("Child", "Adult"), selected = "Adult"),
            selectInput('sex2', 'Sex', c("Male", "Female"), selected = "Male")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("barPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$barPlot <- renderPlot({
        # Simple Bar Chart
        
        x    <- Titanic
        values <- rbind( x[, Sex = input$sex, Age = input$age, Survived = input$survived], x[, Sex = input$sex2, Age = input$age2, Survived = input$survived2] ) 
        barplot(values, main = "Survived by Class", names.arg = names(values), xlab = "Class", ylab = "Counts", col = c("darkblue","red"), beside=TRUE)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
