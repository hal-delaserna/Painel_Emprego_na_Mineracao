library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(reactable)
options(shiny.reactlog = TRUE, launch.browser = TRUE)

# Para alternar entre tabela e gráfico: radioGroupButtons
# com tabela e gráfico em tabBox



# HEADER ----

header <-
  dashboardHeader(title = "Emprego Formal na Mineração", 
                  titleWidth = 350)

# SIDEBAR ----

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Setor Mineral",
             tabName = "Tab_SetorMineral"
             # ,menuSubItem("Estoques", tabName = 'tab_nome1'),
             # menuSubItem("Saldos", tabName = 'tab_nome2')
             ),
    menuItem("Extrativa Mineral",
             tabName = "tab_Extrativa"),
    menuItem("Transformação Mineral",
             tabName = "tab_Transformacao")))

# BODY ----

body <-
  dashboardBody(tabItems(
    tabItem(
      tabName = "Tab_SetorMineral"
      ,h3("Extrativa e Transformação Mineral")
      
      ,fluidRow(
        column(width = 3, offset = 1,
        radioGroupButtons(
          inputId = "id_radioGroupButtons_Setor"
          ,choices = c("A", "B")
          ,checkIcon = list(
            yes = icon("square-check", "table-list"),
            no = icon("square", "table-list"))
        )))
      ,fluidRow(
        tabBox(
          id = "tabBox_Setor",
          height = "250px",
          tabPanel("Tab1", "First tab content"),
          tabPanel("Tab2", "Tab content 2")
        )
      )
    ),
# TAB_EXTRATIVA ---- 
    tabItem(tabName = "tab_Extrativa"
            ,h2("Extrativa Mineral")

#_Trimestre ----            
            ,fluidRow(
              column(offset = 0,width = 6
                     ,sliderTextInput(
                       inputId = "id.Trimestre.select",
                       label = "Trimestre",
                       choices = TRIMESTRES,
                       selected = TRIMESTRES[c(length(TRIMESTRES)-3,length(TRIMESTRES))]
                       ))
#_UFs ----  
              ,column(offset = 0,width = 6
                      ,selectInput(
                        inputId = "id.UF.select",
                        label = "UF",
                        choices = list(`Estado` = UF),
                        multiple = T, selected = UF
                      )
              ),
              
              actionButton(inputId = "id.Atualizar.button", label = "Ok")
            ),
              
#_tabBox_Extrativa ----            
            # ,fluidRow(
              tabBox(
                id = "tabBox_Extrativa",
                height = "100%",width = '100%',
                tabPanel("Tab1", "CNAE 2.0 Divisão"
                         
                         ,fluidRow(
                           column(width = 4
                         ,plotOutput('id.Graf.Trimestre'))
                          ,column(width = 4
                         ,plotOutput("id.Graf.Divisao"))
                         )),
                tabPanel("Tab2",reactableOutput("id.Tb.Divisao")))
              # )
              ),
# TAB_Transformacao ----
    tabItem(tabName = "tab_Transformacao"
            ,h2("Transformação Mineral")
    ,fluidRow(
      tabBox(
        id = "tabBox_Transformacao",
        height = "250px",
        tabPanel("Tab1", "First tab content"),
        tabPanel("Tab2", "Tab content 2")
      )
      )
    )
    )
  )







# dashboardPage ----

shinyUI(dashboardPage(header, sidebar, body,
                      skin = 'yellow'))












