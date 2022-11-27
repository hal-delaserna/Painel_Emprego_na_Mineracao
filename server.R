library(shiny)

shinyServer(function(input, output) {
  
  
  # df <-
  #   eventReactive(input$id.Atualizar.button, {
  #     df_long_cnae[df_long_cnae$trimestre %in% input$id.Trimestre.select, ]
  #   }, ignoreNULL = F)
  # 
  # output$id.Graf.Trimestre <-
  #   renderPlot({
  #     ggplot(data = df(),
  #            mapping = aes(x = trimestre, y = estoque)) +
  #       geom_col()
  #   })
})
