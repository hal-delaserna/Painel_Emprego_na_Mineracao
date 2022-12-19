library(shiny)



shinyServer(function(input, output) {
 
 
 df_Divisao <-
   eventReactive(input$id.Atualizar.button, {
     df_long_cnae_Divisao[df_long_cnae_Divisao$trimestre %in% 
                    TRIMESTRES[
                      as.integer(
                        TRIMESTRES[TRIMESTRES == input$id.Trimestre.select[1]]
                      ):as.integer(
                        TRIMESTRES[TRIMESTRES == input$id.Trimestre.select[2]]
                      )] &
                    df_long_cnae_Divisao$UF_sigla %in% input$id.UF.select, ]
   }, ignoreNULL = F)
 

 
 df_Divisao_Wide <- 
   reactive(
     pivot_wider(df_Divisao(), 
                 names_from = "trimestre", 
                 values_from = "estoque")
   )
 
 
 df_Divisao_Wide <- 
   reactive(
     pivot_wider(df_Divisao(), 
                 names_from = "trimestre", 
                 values_from = "estoque")
   )
 
 
 
 output$id.Graf.Trimestre <-
   renderPlot({
     ggplot(data = df_Divisao(),
            mapping = aes(x = trimestre, y = estoque)) +
       geom_col()
   })
 
 
 output$id.Graf.Divisao <-
   renderPlot({
     ggplot(data = df_Divisao(),
            mapping = aes(x = divisao, y = estoque)) +
       geom_col()
   })

 
  
 
  
 output$id.Tb.Divisao <- 
   renderReactable(
     reactable(df_Divisao_Wide()
               ,filterable = T
               ,compact = T
               ,striped = T
               ,sortable = T
               )
   )
   
   
   
 
 
})












