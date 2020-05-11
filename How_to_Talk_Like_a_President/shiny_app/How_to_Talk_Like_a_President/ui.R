
dashboardPage(
    skin = "blue",
    dashboardHeader(title = 'How to Talk Like a President', titleWidth = 385),
    dashboardSidebar(
        width = 385,
        sidebarMenu(
            menuItem(h4('Dynamic Dashboard'), tabName = 'dashboard'), #, icon = icon('map')
            menuItem(h4('Data'), tabName = 'data'), #, icon = icon('database')
            menuItem(h4('About'), tabName = 'about')
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
                            
                            tabPanel(h4("Intro"),
                                     h5(Intro_pt1),
                                     br(),
                                     h5(Intro_pt2),
                                     br(),
                                     fluidRow(
                                         column(4, ""),
                                         column(4, img(src='bald_eagle.jpg', align = "center", height = '140px', width = '80%'))
                                     ),
                                     h5(Intro_pt2_1),
                                     htmlOutput("text_blurb"),
                                     br(),
                                     h5(Intro_pt3),
                                     br(),
                                     status = 'success'
                                     ),
                            
                            tabPanel(h4("Geography"), 
                                     fluidRow(
                                         column(1, ""),
                                         column(2, sliderInput("geography_slider", sep = "", label = h4("Presidential Term Year"), min = 0, max = 8, value = c(0,8))),
                                         column(2, radioButtons("geography_radio", label = h4("Comparison Graph"), choices = list("Google Trend" = 0, "S & P 500" = 1, "POTUS Approval" = 2), selected = 0)),
                                         column(2, radioButtons("geography_scale_radio", label = h4("Geographical Scale"), choices = list("Countries" = 0, "States" = 1), selected = 0)),
                                         column(2, selectizeInput(inputId = "country",
                                                                  label = "Country",
                                                                  choices = unique(Country_Names$Country_Name))),
                                         column(2, selectizeInput(inputId = "state",
                                                                  label = "State",
                                                                  choices = unique(State_Names$State.Name)))
                                         ),
                                     plotlyOutput("GG_Geography_Top"),
                                     plotlyOutput("GG_Geography_Bottom")
                                     ),

                            tabPanel(h4("Policy"),
                                     fluidRow(
                                         column(1, ""),
                                         column(2, sliderInput("policy_slider", sep = "", label = h4("Presidential Term Year"), min = 0, max = 8, value = c(0,8))),
                                         column(2, radioButtons("policy_radio", label = h4("Comparison Graph"), choices = list("Google Trend" = 0, "S & P 500" = 1, "POTUS Approval" = 2), selected = 0)),
                                         column(3, selectizeInput(inputId = "policy_type",
                                                                  label = "Policy Category",
                                                                  choices = unique(Policy$policy_type),
                                                                  selected = unique(Policy$policy_type)[3]
                                                                  )),
                                         #column(3, verbatimTextOutput("value")),
                                         column(3, selectizeInput(inputId = "keyword",
                                                                  label = "Keyword",
                                                                  choices = unique(Policy$policy)
                                                                  ))
                                         ),
                                     plotlyOutput("GG_Policy_Top"),
                                     plotlyOutput("GG_Policy_Bottom")
                                     ),
                            
                            tabPanel(h4("Metrics"), 
                                     fluidRow(
                                         column(2, sliderInput("nation_slider", sep = "", label = h4("Presidential Term Year"), min = 0, max = 8, value = c(0,8)))
                                         ),
                                     h5(Metrics_pt1),
                                     h5(Metrics_pt2),
                                     h5(Metrics_pt3),
                                     h5(Metrics_pt4)
                                     ),
                            
                            tabPanel(h4("Exploration"),
                                     h5(Exploration_pt1),
                                     #br(),
                                     h5(Exploration_pt2),
                                     br(),
                                     fluidRow(
                                         column(2, ""),
                                         column(3, sliderInput("exploration_slider", sep = "", label = h4("Presidential Term Year"), min = 0, max = 8, value = c(0,8))),
                                         column(2, radioButtons("exploration_sec_y_axis_radio", label = h4("Comparison Graph"), choices = list("Google Trend" = 0, "S&P 500" = 1, "POTUS Approval" = 2), selected = 0)),
                                         column(2, textInput("exploration_text", label = h4("Text Input (lowercase)"), value = "Enter text..."))
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
                            tabPanel(h4("Source"), 
                                     h5('President George W. Bush Press Briefings: '),
                                     tags$a(href="https://georgewbush-whitehouse.archives.gov/news/briefings/", h5("https://georgewbush-whitehouse.archives.gov/news/briefings/"))
                                     ),
                            tabPanel(h4("Press Briefing Word Count"), 
                                     h5(),
                                     box(DT::dataTableOutput("Press_Briefing_Word_Count"), width = 12)),
                            tabPanel(h4("Google Trends"),
                                     h5('Data source: Google Trends'),
                                     tags$a(href="https://www.google.com/trends", h5("https://www.google.com/trends")),
                                     box(DT::dataTableOutput("Google_Trends"), width = 12)
                                     ),
                            tabPanel(h4("POTUS Approval"),
                                     h5('Data source: The American Presidency Project'),
                                     tags$a(href="https://www.presidency.ucsb.edu/statistics/data/presidential-job-approval", h5("https://www.presidency.ucsb.edu/statistics/data/presidential-job-approval")),
                                     box(DT::dataTableOutput("POTUS_Approval"), width = 12)
                                     ),
                                     br(),
                            tabPanel(h4("S&P 500"),
                                     h5('Data source: Yahoo Finance'),
                                     tags$a(href="https://finance.yahoo.com/quote/%5EGSPC/history?period1=-1325635200&period2=1588896000&interval=1mo&filter=history&frequency=1mo", h5("https://finance.yahoo.com/quote")),
                                     br(),
                                     box(DT::dataTableOutput("SP500"), width = 12)
                                     )
                            )
                        )
                    ),
            
            tabItem(tabName = 'about',
                    fluidRow(
                        tabBox(
                            title = "",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "tabset1", width = '100%',
                            tabPanel(h4("The Project"), 
                                     h5('Is this centered?')
                                     ),
                            tabPanel(h4("The Coder"), 
                                     h5()
                                     )
                            ),
                        align = "center"
                        )
                    )
            )
        )
    )


