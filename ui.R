library(leaflet)

# Choices for drop-downs
vars <- c(
  "Pizzerias" = "superzip",
  "Museos" = "centile",
  "Restaurantes" = "college",
  "Farmacias" = "income",
  "Bares" = "adultpop"
)
vars1 <- c(
  "Quitumbe" = "superzip",
  "Kennedy" = "centile",
  "Jipijapa" = "college",
  "Itchimbia" = "income",
  "Centro Historico" = "adultpop1"
)


navbarPage("Quito", id="nav",

  tabPanel("Mapa Interactivo",
    div(class="outer",

      tags$head(
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),

      # If not using custom CSS, set height of leafletOutput to a number instead of percent
      leafletOutput("map", width="100%", height="100%"),

      # Shiny versions prior to 0.11 should use class = "modal" instead.
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
        draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
        width = 330, height = "auto",

        h2("Locales Comerciales"),

        selectInput("color", "Tipo de local", vars),
        selectInput("size", "Parroquia", vars1, selected = "adultpop1"),
        conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
          # Only prompt for threshold when coloring or sizing by superzip
          numericInput("threshold", "Rango de Calificacion (# de estrellas)", 5)
        ),

        plotOutput("histCentile", height = 200),
        plotOutput("scatterCollegeIncome", height = 250)
      ),

      tags$div(id="cite",
        '____________________Autores: ', tags$em('Ecuador'), ' by BlackBess (Dalozano & RaAguirre, 2020).'
      )
    )
  ),

  tabPanel("Informacion de busqueda",
    fluidRow(
      column(3,
        selectInput("states", "Provincia", c("Pichincha"="", structure(state.abb, names=state.name), "Ecuador, EC"="EC"), multiple=TRUE)
        #selectInput("states", "Provincia", c("Pichincha"="), multiple=TRUE)
      ),
      column(3,
        conditionalPanel("input.states",
          selectInput("cities", "Ciudad", c("Quito"=""), multiple=TRUE)
        )
      ),
      column(3,
        conditionalPanel("input.states",
          selectInput("zipcodes", "Parroquia", c("Parroquia"=""), multiple=TRUE)
        )
      )
    ),
    fluidRow(
      column(1,
        numericInput("minScore", "Puntuacion Minima", min=0, max=5, value=0)
      ),
      column(1,
        numericInput("maxScore", "Puntuacion Maxima", min=0, max=5, value=5)
      )
    ),
    hr(),
    DT::dataTableOutput("Control")
  ),

  conditionalPanel("false", icon("crosshair"))
)
