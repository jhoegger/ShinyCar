library(shiny)
library(UsingR)
library(datasets)
data(mtcars)

###Make the data tidy
mtcars$vs   <-as.factor(mtcars$vs)
mtcars$am[mtcars$am==0]<-"Auto"
mtcars$am[mtcars$am==1]<-"Manual"
mtcars$am   <-as.factor(mtcars$am)
mtcars$carb <-as.factor(mtcars$carb)

shinyServer(
    function(input, output){
        #output selected values
        output$onumCly <- renderPrint({input$idCyl})
        output$onumGears <- renderPrint({input$idGears})
        output$ocarCount <- renderPrint({
        numCyl <- {input$idCyl}
        numGears <- {input$idGears}
        #show the total number of items selected
        submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
        nrow(submtcars)
        })
        
        #generate the summary of the model
        output$fitSum <- renderPrint({
        numCyl <- {input$idCyl}
        numGears <- {input$idGears}
        fit <- lm(mpg ~ am, mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,])
        bestFit <- step(fit, direction = "backward")
        summary(bestFit)
        })

        #return a boxplot of MPG vs. transmission type            
        output$newBoxplot <- renderPlot({
            numCyl <- {input$idCyl}
            numGears <- {input$idGears}
            submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
            boxplot(submtcars$mpg~submtcars$am,col=c("light blue", "light green"),
                    ylab="mpg",xlab="transmission",main="MPG vs Transmission")
        })
        
        #return the pairs plot of all variables 
        output$newPairs <- renderPlot({
            numCyl <- {input$idCyl}
            numGears <- {input$idGears}
            submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
            pairs(submtcars, panel=panel.smooth, 
            main="Car Analysis", col=3)
        })

        #return the residual plot and diagnostics
        output$newBestFit <- renderPlot({
            numCyl <- {input$idCyl}
            numGears <- {input$idGears}
            submtcars <- mtcars[mtcars$cyl<=numCyl & mtcars$gear<=numGears,]
            fit <- lm(mpg ~ am, submtcars)
            bestFit <- step(fit, direction = "backward")
            par(mfrow=c(2, 2))
            plot(bestFit)
        })
    }
)