library(shiny)
library(shinydashboard)


# PREENCHER O SIDEBAR COM MENUS, SELETORES E BOTÕES

# header ----
header <- dashboardHeader(title = "Emprego Formal na Mineração", titleWidth = 450)

# sidebar ----
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Estoques",
             tabName = "tab_estoques"),
    menuItem("Variações",
             tabName = "tab_variacoes"),
    menuItem("Salários",
             tabName = "tab_salarios")))

# body ----
body <-
  dashboardBody(tabItems(
    tabItem(tabName = "tab_estoques",
            
            fluidRow(
              tabBox(
                title = "Extração Mineral",
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "tabset1",
                height = "250px",
                tabPanel("Tab1", "First tab content"),
                tabPanel("Tab2", "Tab content 2")
              ),
              tabBox(
                height = "250px",
                selected = "Tab3",
                tabPanel("Tab1", "Tab content 1"),
                tabPanel("Tab2", "Tab content 2"),
                tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
              )
            ),
            fluidRow(
              tabBox(
                title = tagList(shiny::icon("gear"), "tabBox status"),
                tabPanel(
                  "Tab1",
                  "Currently selected tab from first box:",
                  verbatimTextOutput("tabset1Selected")
                ),
                tabPanel("Tab2", "Tab content 2")
              )
            )),
    
    tabItem(tabName = "tab_variacoes",
            h2("variações interanuais")),
    tabItem(tabName = "tab_salarios",
            h2("Salários de admissão e desligamento"))
  ))







# dashboardPage ----

shinyUI(dashboardPage(header, sidebar, body,
                      skin = 'yellow'))
