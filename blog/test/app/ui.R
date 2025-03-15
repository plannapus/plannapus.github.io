library(shiny)
library(shinyWidgets)
# Javascript functions for the logarithmic scale
JS.logify <-"function logifySlider (sliderId) {
    // regular number style
    $('#'+sliderId).data('ionRangeSlider').update({
      'prettify': function (num) { return (Math.pow(10, num).toFixed(2)); }
    })
}"
JS.onload <-"$(document).ready(function() {
  setTimeout(function() {
    logifySlider('W')
  }, 5)})"

ui <- fluidPage(
  tags$head(tags$script(HTML(JS.logify))),
  tags$head(tags$script(HTML(JS.onload))),
  titlePanel("Raup Coiling model for Mollusks"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(input="W",label="Whorl Expansion Rate (W)",
                  min = 0, max = 5, value = 0.301, step = .0001),
      sliderInput(input="D",label="Umbilicus opening (D)", 
                  min=0, max=0.9,value=0.3,step=0.01),
      sliderInput(input="S",label="Shape of opening (S)", 
                  min=0.1, max=5,value=1,step=0.01),
      sliderInput(input="RT",label="Rate of translation (T)",
                  min=0, max=35,value=2,step=0.1),
    ),
    mainPanel(
      rglwidgetOutput("coilrgl",width=800, height=800)
    )
  )
)