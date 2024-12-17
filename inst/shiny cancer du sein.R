
library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)  # Ajoutez la bibliothèque plotly

# URL du fichier RDS sur GitHub
url <- "https://raw.githubusercontent.com/emmarme/projetr/refs/heads/master/data.csv"

# Télécharger le fichier RDS
download.file(url, destfile = "data.csv")

# Charger le fichier RDS dans R
data <- read.csv("data.csv")

# Interface utilisateur
ui <- dashboardPage(
  dashboardHeader(title = 'Menu'),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", icon = icon("th"), tabName = "widgets"),
      menuItem("Histogramme", tabName = "histogramme"),
      menuItem("Boxplot", tabName = "boxplot"),
      menuItem("Graphique interactif", tabName = "graphiqueinterractif")
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
      tabItem(tabName = "histogramme",
              fluidPage(
                h2("Histogrammes"),
                fluidRow(
                  box(plotOutput("hist_radius_mean")),
                  box(plotOutput("hist_area_mean")),
                  box(plotOutput("hist_smoothness_se"))
                ),
                fluidRow(
                  box(plotOutput("hist_radius_se")),
                  box(plotOutput("hist_smoothness_worst")),
                  box(plotOutput("hist_symmetry_worst"))
                )
              )
      ),
      tabItem(tabName = "boxplot",
              fluidPage(
                h2("Boxplots"),
                fluidRow(
                  box(plotOutput("boxplot_radius_mean")),
                  box(plotOutput("boxplot_area_mean")),
                  box(plotOutput("boxplot_smoothness_se"))
                ),
                fluidRow(
                  box(plotOutput("boxplot_radius_se")),
                  box(plotOutput("boxplot_smoothness_worst")),
                  box(plotOutput("boxplot_symmetry_worst"))
                )
              )
      ),
      tabItem(tabName = "graphiqueinterractif",
              fluidPage(
                h2("Bougez le curseur !"),
                sliderInput("slider_graph", "Choisissez un paramètre:", 
                            min = 0, max = max(data$radius_mean), value = 100, step = 10),
                plotlyOutput("interactive_plot")  # Graphique interactif
              )
      )
    )
  )
)

# Serveur
server <- function(input, output) {
  
  # Histogrammes
  output$hist_radius_mean <- renderPlot({
    hist(data$radius_mean, main = "Histogramme radius_mean", col = "lightblue", border = "white")
  })
  output$hist_area_mean <- renderPlot({
    hist(data$area_mean, main = "Histogramme area_mean", col = "lightblue", border = "white")
  })
  output$hist_smoothness_se <- renderPlot({
    hist(data$smoothness_se, main = "Histogramme smoothness_se", col = "lightblue", border = "white")
  })
  output$hist_radius_se <- renderPlot({
    hist(data$radius_se, main = "Histogramme radius_se", col = "lightblue", border = "white")
  })
  output$hist_smoothness_worst <- renderPlot({
    hist(data$smoothness_worst, main = "Histogramme smoothness_worst", col = "lightblue", border = "white")
  })
  output$hist_symmetry_worst <- renderPlot({
    hist(data$symmetry_worst, main = "Histogramme symmetry_worst", col = "lightblue", border = "white")
  })
  
  # Boxplots avec ggplot2
  output$boxplot_radius_mean <- renderPlot({
    ggplot(data, aes(x = factor(0), y = radius_mean)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = "Boxplot of radius_mean", x = "", y = "radius_mean")
  })
  
  output$boxplot_area_mean <- renderPlot({
    ggplot(data, aes(x = factor(0), y = area_mean)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = "Boxplot of area_mean", x = "", y = "area_mean")
  })
  
  output$boxplot_smoothness_se <- renderPlot({
    ggplot(data, aes(x = factor(0), y = smoothness_se)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = "Boxplot of smoothness_se", x = "", y = "smoothness_se")
  })
  
  output$boxplot_radius_se <- renderPlot({
    ggplot(data, aes(x = factor(0), y = radius_se)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = "Boxplot of radius_se", x = "", y = "radius_se")
  })
  
  output$boxplot_smoothness_worst <- renderPlot({
    ggplot(data, aes(x = factor(0), y = smoothness_worst)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = "Boxplot of smoothness_worst", x = "", y = "smoothness_worst")
  })
  
  output$boxplot_symmetry_worst <- renderPlot({
    ggplot(data, aes(x = factor(0), y = symmetry_worst)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = "Boxplot of symmetry_worst", x = "", y = "symmetry_worst")
  })
  
  # Graphique interactif (avec plotly)
  output$interactive_plot <- renderPlotly({
    # Filtrage des données en fonction du curseur
    filtered_data <- data[data$radius_mean <= input$slider_graph, ]
    
    # Créez un graphique interactif avec plotly
    plot_ly(filtered_data, x = ~radius_mean, y = ~area_mean, 
            type = 'scatter', mode = 'markers', 
            marker = list(color = 'blue')) %>%
      layout(title = 'Graphique interactif des données',
             xaxis = list(title = 'Radius Mean'),
             yaxis = list(title = 'Area Mean'))
  })
}

# Lancer l'application
shinyApp(ui, server)
