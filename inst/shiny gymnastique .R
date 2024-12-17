

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title='Menu'),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", icon = icon("th"), tabName = "widgets"),
      menuItem("Individuel", tabName="individuel"),
      menuItem("Par équipe", tabName="parequipe"),
      menuItem("Par agrée", tabName="paragree",
               menuItem('Femme', tabName='femme'),
               menuSubItem("Poutre", tabName='poutre'),
               menuSubItem("Barres Asymétiques", tabName='barreasymetrique'),
               menuSubItem("Sol", tabName='sol'),
               menuSubItem("Saut Femme", tabName='sautfemme'),
               menuItem('Homme', tabName='homme'),
               menuSubItem("Sol Homme", tabName='solhomme'),
               menuSubItem("Saut Homme", tabName='sauthomme'),
               menuSubItem("Barres Parallèles", tabName='barreparralele'),
               menuSubItem("Barre Fixe", tabName='barrefixe'),
               menuSubItem("Cheval d'Arseau", tabName='chevaldarseau'),
               menuSubItem("Anneaux", tabName='anneaux')
      )
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      tabItem(tabName = "widgets",
                h2("Widgets tab content")
      ),
      tabItem(tabName="individuel",
              fluidPage(
              h2("Individuel Content "))
      ),
      tabItem(tabName="parequipe",
              h2("Par Equipe content")
      ),
      tabItem(tabName="paragree",
              h2("Par Agrée Content")
      ),
      tabItem(tabName='poutre', h2("Poutre content")),
      tabItem(tabName='barreasymetrique', h2("Barres Asymétriques content")),
      tabItem(tabName='barreparralele', h2("Barres Parallèles content")),
      tabItem(tabName='barrefixe', h2("Barres fixe content")),
      tabItem(tabName='chevaldarseau', h2("Cheval d'Arseau content")),
      tabItem(tabName='anneaux', h2("Anneaux content")),
      tabItem(tabName='sol', h2("Sol content")),
      tabItem(tabName='solhomme', h2("Sol Homme content")),
      tabItem(tabName='solfemme', h2("Sol Femme content")),
      tabItem(tabName='saut', h2("Saut content")),
      tabItem(tabName='sautfemme', h2("Saut Femme content")),
      tabItem(tabName='sauthomme', h2("Saut Homme content"))
    )
  )
)

server <- function(input, output) {}
shinyApp(ui, server)



