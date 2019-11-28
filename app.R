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
            h4("First Set (Blue)"), # Title of the first set of dropdowns
            selectInput('survived', 'Survived', c("Yes", "No"), selected = "Yes"), #survived is our variable, Survived the title of the dropdown, c("Yes", "No") is the choice of the dropdown, Selected is the value by default
            selectInput('age', 'Age', c("Child", "Adult"), selected = "Adult"), #age is our variable, Age the title of the dropdown, c("Child", "Adult") is the choice of the dropdown, Selected is the value by default
            selectInput('sex', 'Sex', c("Male", "Female"), selected = "Male"), #sex is our variable, Sex the title of the dropdown, c("Male", "Female") is the choice of the dropdown, Selected is the value by default
            br(),
            
            h4("Second Set (Red)"), # Title of the second set of dropdowns
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
        #stocking the data in a varible  x
        x    <- Titanic
        #retrieving the user's input
        values <- rbind( x[, Sex = input$sex, Age = input$age, Survived = input$survived], x[, Sex = input$sex2, Age = input$age2, Survived = input$survived2] )
        #ploting the data according to the input
        barplot(values, main = "Survived by Class", names.arg = names(values), xlab = "Class", ylab = "Counts", col = c("darkblue","red"), beside=TRUE)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
