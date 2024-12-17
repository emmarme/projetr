Quelques aides pour l'installation et l'utilisation de notre package !

Pour installer le package R:

devtools::install_github("emmarme/projetr")

Pour lancer l'App Shiny sur le cancer du seins:

shiny::runApp(system.file("shiny_cancer_du_sein.R", package="projetr"))

Pour Lancer l'App Shiny sur la gymnastique:

shiny::runApp(system.file("shiny-gymnastique.R", package="projetr"))
