
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
                                         column(1, ""),
                                         column(3, sliderInput("geography_slider", sep = "", label = h3("Year of Presidential Term"), min = 0, max = 8, value = c(0,8))),
                                         column(2, radioButtons("geography_sec_y_axis_radio", label = h3("Secondary Y Axis"), choices = list("None" = 0, "Google Trend" = 1, "S & P 500" = 4, "POTUS Approval" = 3), selected = 0)),
                                         column(2, radioButtons("geography_scale_radio", label = h3("Geographical Scale"), choices = list("Countries" = 0, "States" = 1), selected = 0)),
                                         column(1, selectizeInput(inputId = "country",
                                                                  label = "Country",
                                                                  choices = unique(Country_Names$Country_Name))),
                                         column(1, selectizeInput(inputId = "state",
                                                                  label = "State",
                                                                  choices = unique(State_Names$State.Name)))
                                         )
                                     ),

                            tabPanel(h3("Policy"),
                                     fluidRow(
                                         column(1, ""),
                                         column(3, sliderInput("policy_slider", sep = "", label = h3("Year of Presidential Term"), min = 0, max = 8, value = c(0,8))),
                                         column(2, radioButtons("policy_sec_y_axis_radio", label = h3("Secondary Y Axis"), choices = list("None" = 0, "Google Trend" = 1, "S & P 500" = 4, "POTUS Approval" = 3), selected = 0)),
                                         column(3, selectizeInput(inputId = "policy_type",
                                                                  label = "Policy Category",
                                                                  choices = unique(Policy$policy_type),
                                                                  selected = unique(Policy$policy_type)[3]
                                                                  )),
                                         #column(3, verbatimTextOutput("value")),
                                         column(2, selectizeInput(inputId = "keyword",
                                                                  label = "Keyword",
                                                                  choices = unique(Policy$policy)
                                                                  ))
                                     )
                                     ),
                            
                            tabPanel(h3("Metrics"), 
                                     fluidRow(
                                         column(2, sliderInput("nation_slider", sep = "", label = h3("Year of Presidential Term"), min = 0, max = 8, value = c(0,8)))
                                         ),
                                     h4(Metrics_pt1),
                                     h4(Metrics_pt2),
                                     h4(Metrics_pt3),
                                     h4(Metrics_pt4)
                                     ),
                            
                            tabPanel(h3("Exploration"),
                                     h4(Exploration_pt1),
                                     #br(),
                                     h4(Exploration_pt2),
                                     br(),
                                     fluidRow(
                                         column(2, ""),
                                         column(3, sliderInput("exploration_slider", sep = "", label = h3("Year of Presidential Term"), min = 0, max = 8, value = c(0,8))),
                                         column(2, radioButtons("exploration_sec_y_axis_radio", label = h3("Secondary Y Axis"), choices = list("None" = 0, "Google Trend" = 1, "S & P 500" = 4, "POTUS Approval" = 3), selected = 0)),
                                         column(2, textInput("exploration_text", label = h3("Text Input (lowercase)"), value = "Enter text..."))
                                         ),
                                     fluidRow(column(3, verbatimTextOutput("value")))
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
                            tabPanel(h3("Source"), 
                                     h4('President George W. Bush Press Briefings: '),
                                     tags$a(href="https://georgewbush-whitehouse.archives.gov/news/briefings/", h4("https://georgewbush-whitehouse.archives.gov/news/briefings/")),
                                     br(),
                                     h4('President Barack H. Obama Press Briefings: '),
                                     tags$a(href="https://obamawhitehouse.archives.gov/briefing-room/press-briefings", h4("https://obamawhitehouse.archives.gov/briefing-room/press-briefings"))
                                     ),
                            tabPanel(h3("Word Count"), 
                                     h4(),
                                     box(DT::dataTableOutput("table_cleaned"), width = 12)),
                            tabPanel(h3("Statistics"), 
                                     h4(),
                                     box(DT::dataTableOutput("table_manipulated"), width = 12)),
                            tabPanel(h3("Google Trends"),
                                     h4('Data source: Google Trends'),
                                     tags$a(href="https://www.google.com/trends", h4("https://www.google.com/trends")),
                                     br(),
                                     box(DT::dataTableOutput("table_major_storms"), width = 12)),
                            tabPanel(h3("POTUS Approval"),
                                     h4('Data source: The American Presidency Project'),
                                     tags$a(href="https://www.presidency.ucsb.edu/statistics/data/presidential-job-approval", h4("https://www.presidency.ucsb.edu/statistics/data/presidential-job-approval")),
                                     br(),
                                     box(DT::dataTableOutput("table_major_storms"), width = 12)),
                            tabPanel(h3("S&P 500"),
                                     h4('Data source: Yahoo Finance'),
                                     tags$a(href="https://finance.yahoo.com/quote/%5EGSPC/history?period1=-1325635200&period2=1588896000&interval=1mo&filter=history&frequency=1mo", h4("https://finance.yahoo.com/quote")),
                                     br(),
                                     box(DT::dataTableOutput("table_major_storms"), width = 12))
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


