library(shiny)
library(UsingR)
data(galton)
library(datasets)
data(mtcars)

###Make the data tidy
#mtcars$cyl  <-as.factor(mtcars$cyl)
mtcars$vs   <-as.factor(mtcars$vs)
mtcars$am[mtcars$am==0]<-"Auto"
mtcars$am[mtcars$am==1]<-"Manual"
mtcars$am   <-as.factor(mtcars$am)
#mtcars$gear <-as.factor(mtcars$gear)
mtcars$carb <-as.factor(mtcars$carb)

shinyServer(
    function(input, output){
        output$onumCly <- renderPrint({input$idCyl})
        output$onumGears <- renderPrint({input$idGears})
        output$ocarCount <- renderPrint({
        numCyl <- {input$idCyl}
        numGears <- {input$idGears}
        submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
        nrow(submtcars)
        })

        output$fitSum <- renderPrint({
        numCyl <- {input$idCyl}
        numGears <- {input$idGears}
        fit <- lm(mpg ~ am, mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,])
        bestFit <- step(fit, direction = "backward")
        summary(bestFit)
        })

        output$newBoxplot <- renderPlot({
            numCyl <- {input$idCyl}
            numGears <- {input$idGears}
            submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
            boxplot(submtcars$mpg~submtcars$am,col=c("light blue", "light green"),
                    ylab="mpg",xlab="transmission",main="MPG vs Transmission")
        })
        
        output$newPairs <- renderPlot({
            numCyl <- {input$idCyl}
            numGears <- {input$idGears}
            submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
            pairs(submtcars, panel=panel.smooth, 
            main="Car Analysis", col=3)
        })

        
    }
)