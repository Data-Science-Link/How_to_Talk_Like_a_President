
dashboardPage(
    skin = "blue",
    dashboardHeader(title = 'How to Talk Like a President', titleWidth = 385),
    dashboardSidebar(
        width = 385,
        sidebarMenu(
            menuItem(h3('Dynamic Dashboard'), tabName = 'dashboard'), #, icon = icon('map')
            menuItem(h3('Data'), tabName = 'data'), #, icon = icon('database')
            menuItem(h3('About'), tabName = 'about')
        )
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tags$body(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = 'dashboard', 
                    fluidRow(
                        tabBox(
                            title = "", id = "tabset1", width = '100%', 
                            
                            tabPanel(h3("Intro"),
                                     h4(Intro_pt1),
                                     br(),
                                     h4(Intro_pt2),
                                     br(),
                                     fluidRow(
                                         column(4, ""),
                                         column(4, img(src='bald_eagle.jpg', align = "center", height = '200px', width = '100%'))
                                     ),
                                     h3(Intro_pt2_1),
                                     htmlOutput("text_blurb"),
                                     br(),
                                     h4(Intro_pt3),
                                     br(),
                                     status = 'success'
                                     ),
                            
                            tabPanel(h3("Geography"), 
                                     fluidRow(
                                         column(2, sliderInput("geography_slider", sep = "", label = h3("Date Range"), min = 1970, max = 2019, value = c(1970,2019))),
                                         column(2, radioButtons("geography_radio", label = h3("Scale"), choices = list("Countries" = 0, "States" = 1), selected = 0))
                                     )
                                     ),
                            
                            tabPanel(h3("Policy"),
                                     fluidRow(
                                         column(2, sliderInput("policy_slider", sep = "", label = h3("Date Range"), min = 1970, max = 2019, value = c(1970,2019))),
                                         column(2, selectizeInput(inputId = "policy_type",
                                                                  label = "Policy Category",
                                                                  choices = unique(Policy$policy_type),
                                                                  selected = unique(Policy$policy_type)[3]
                                                                  )),
                                         column(3, verbatimTextOutput("value")),
                                         column(2, selectizeInput(inputId = "keyword",
                                                                  label = "Keyword",
                                                                  choices = unique(Policy$policy)
                                                                  ))
                                     )
                                     ),
                            
                            tabPanel(h3("Metrics"), 
                                     fluidRow(
                                         column(2, sliderInput("nation_slider", sep = "", label = h3("Date Range"), min = 1970, max = 2019, value = c(1970,2019))),
                                         column(2, radioButtons("nation_radio", label = h3("Filter"), choices = list("States" = 0, "Flood Zone" = 1, 'Census Region' = 2, 'Census Division' = 3), selected = 2))
                                     ),
                                     h4(Metrics_pt1),
                                     h4(Metrics_pt2),
                                     h4(Metrics_pt3),
                                     h4(Metrics_pt4)
                                     ),
                            
                            tabPanel(h3("Exploration"), 
                                     h4(Exploration_pt1),
                                     br()
                                     )
                            )
                        )
                    ),
            tabItem(tabName = 'data',
                    fluidRow(
                        tabBox(
                            title = "",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "tabset1", width = '100%',
                            tabPanel(h3("Cleaned"), 
                                     h4(),
                                     box(DT::dataTableOutput("table_cleaned"), width = 12)),
                            tabPanel(h3("Manipulated"), 
                                     h4(),
                                     box(DT::dataTableOutput("table_manipulated"), width = 12)),
                            tabPanel(h3("Major Storms"), h4('FEMA Designated Major Storms:'),
                                     tags$a(href="https://www.fema.gov/significant-flood-events", h4("https://www.fema.gov/significant-flood-events")),
                                     box(DT::dataTableOutput("table_major_storms"), width = 12)),
                            tabPanel(h3("Raw"), 
                                     h4('FIMA NFIP Redacted Claims Data Set Download Link (Too Large to Host Online):'),
                                     tags$a(href="https://www.fema.gov/media-library/assets/documents/180374", h4("https://www.fema.gov/media-library/assets/documents/180374")))
                            )
                        )
                    ),
            
            tabItem(tabName = 'about',
                    fluidRow(
                        tabBox(
                            title = "",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "tabset1", width = '100%',
                            tabPanel(h3("The Project"), 
                                     h4('Is this centered?')
                                     ),
                            tabPanel(h3("The Coder"), 
                                     h4()
                                     )
                            ),
                        align = "center"
                        )
                    )
            )
        )
    )


