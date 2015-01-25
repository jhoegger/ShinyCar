shinyUI(pageWithSidebar(
    headerPanel("Motor Trends Car Analysis for 1973-74"),
    sidebarPanel(
        h3('Cylinder & Gear Selection'),
        #Add a slide bar to select the number of cylinders
        sliderInput('idCyl', 'Select the minimum number of cylinders', value=6, min=4, max=8, step=2),
        h4('Number of Cylinders'),
        verbatimTextOutput("onumCly"),
        #Add a slide bar to select the number of gears        
        sliderInput('idGears', 'Select the minimum number of gears', value=4, min=4, max=5, step=1),
        h4('Number of Gears'),
        verbatimTextOutput("onumGears"),
        #show the summary data from the model fit
        h4('Fit summary'),
        verbatimTextOutput("fitSum")
        
        ),
    mainPanel(
        p('Using the Motor Trends Car Analysis for 1973-74 data set I am interested in'),
        p('exploring the relationship between a set of variables and miles per gallon (MPG).'),
        h4('Number of cars in the model'),
        verbatimTextOutput("ocarCount"), #get the count of the number of cars in the model
        plotOutput('newBoxplot'),   #newBoxplot is defined on the server
        plotOutput('newPairs')      #newPairs is defined on the server
        )
))