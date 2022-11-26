library(shiny)
library(shinydashboard)


# PREENCHER O SIDEBAR COM MENUS, SELETORES E BOTÕES

# header ----
header <- dashboardHeader(title = "Emprego Formal na Mineração", disable = F)

# sidebar ----
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green")))

# body ----
body <- 
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              
              fluidRow(
                tabBox(
                  title = "First tabBox",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabset1", height = "250px",
                  tabPanel("Tab1", "First tab content"),
                  tabPanel("Tab2", "Tab content 2")
                ),
                tabBox(
                  side = "right", height = "250px",
                  selected = "Tab3",
                  tabPanel("Tab1", "Tab content 1"),
                  tabPanel("Tab2", "Tab content 2"),
                  tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
                )
              ),
              fluidRow(
                tabBox(
                  title = tagList(shiny::icon("gear"), "tabBox status"),
                  tabPanel("Tab1",
                           "Currently selected tab from first box:",
                           verbatimTextOutput("tabset1Selected")
                  ),
                  tabPanel("Tab2", "Tab content 2")))
              
              
      ),
      
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
    )
  )

  
  
  
   


# dashboardPage ----
shinyUI(
  dashboardPage(header, sidebar, body)
  )



