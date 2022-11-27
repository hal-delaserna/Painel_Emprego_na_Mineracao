library(shiny)
library(shinydashboard)
library(shinyWidgets)

# Para alternar entre tabela e gráfico: radioGroupButtons
# com tabela e gráfico em tabBox



# header ----

header <-
  dashboardHeader(title = "Emprego Formal na Mineração", 
                  titleWidth = 350)

# sidebar ----

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

# body ----

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
    
    tabItem(tabName = "tab_Extrativa"
            ,h2("Extrativa Mineral")
            
            ,fluidRow(
              tabBox(
                id = "tabBox_Extrativa",
                height = "250px",
                tabPanel("Tab1", "First tab content"),
                tabPanel("Tab2", "Tab content 2")
              )
            )),
    
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












