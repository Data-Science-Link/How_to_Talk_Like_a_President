
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  observe({
    updateSelectInput(session = session,
                      inputId = 'keyword',
                      choices = unique(Policy[Policy$policy_type == input$policy_type, 'policy']),
                      selected = unique(Policy[Policy$policy_type == input$policy_type, 'policy'][1]))
  })


  output$GG_Geography_Top<-renderPlotly({
    
    if (input$geography_scale_radio == 0) {
      george_mod = 
        george %>% 
        select(., month_year, term_year_bush, !!input$country) %>% 
        filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = george_mod, aes_string(x = 'month_year', y = input$country)) +
        labs(title = 'Country Occurrence in Press Briefings', x = '', y = '') +
        theme_bw() + 
        theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
              axis.text=element_text(size = axis_text_sz),
              axis.title=element_text(size = axis_title_sz,face="bold"),
              legend.position='none')
    } else {
      george_mod = 
        george %>% 
        select(., month_year, term_year_bush, !!input$state) %>% 
        filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = george_mod, aes_string(x = 'month_year', y = input$state)) +
        labs(title = 'State Occurrence in Press Briefings', x = '', y = '') +
        theme_bw() + 
        theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
              axis.text=element_text(size = axis_text_sz),
              axis.title=element_text(size = axis_title_sz,face="bold"),
              legend.position='none')
    }
    
    ggplotly()
    
  })
  
  output$GG_Geography_Bottom<-renderPlotly({
    
    george_mod = 
      george %>% 
      select(., month_year, term_year_bush) %>% 
      filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
      drop_na()
    
    if (input$geography_radio == 0){
      
      if (input$geography_scale_radio == 0){
        
        auxiliary_mod = 
          auxiliary %>% 
          select(., month_year, term_year_bush, !!input$country) %>% 
          filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
          drop_na()
        ggplot() +
          geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = input$country)) + 
          xlim(min(george_mod$month_year), max(george_mod$month_year)) +
          labs(title = 'Country Occurrence in Google Trends', x = '', y = '') +
          theme_bw() + 
          theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
                axis.text=element_text(size = axis_text_sz),
                axis.title=element_text(size = axis_title_sz,face="bold"),
                legend.position='none')
        
      } else {
        
        auxiliary_mod = 
          auxiliary %>% 
          select(., month_year, term_year_bush, !!input$state) %>% 
          filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
          drop_na()
        ggplot() +
          geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = input$state)) + 
          xlim(min(george_mod$month_year), max(george_mod$month_year)) +
          labs(title = 'State Occurrence in Google Trends', x = '', y = '') +
          theme_bw() + 
          theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
                axis.text=element_text(size = axis_text_sz),
                axis.title=element_text(size = axis_title_sz,face="bold"),
                legend.position='none')
        
      }

    } else if (input$geography_radio == 1) {
      auxiliary_mod = 
        auxiliary %>% 
        select(., month_year, term_year_bush, SP_500) %>% 
        filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'SP_500'), color="purple") + 
        xlim(min(george_mod$month_year), max(george_mod$month_year)) +
        labs(title = 'S&P 500 Performance', x = '', y = '') +
        theme_bw() + 
        theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
              axis.text=element_text(size = axis_text_sz),
              axis.title=element_text(size = axis_title_sz,face="bold"),
              legend.position='none')
    } else {
      auxiliary_mod = 
        auxiliary %>% 
        select(., month_year, term_year_bush, Approving, Disapproving, Unsure) %>% 
        filter(., term_year_bush >= input$geography_slider[1], term_year_bush <= input$geography_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'Approving'), color="green") + 
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'Disapproving'), color="red") +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'Unsure')) +
        xlim(min(george_mod$month_year), max(george_mod$month_year)) +
        labs(title = 'Presidential Approval', x = '', y = '') +
        theme_bw() + 
        theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
              axis.text=element_text(size = axis_text_sz),
              axis.title=element_text(size = axis_title_sz,face="bold"),
              legend.position='none')
    }
    
    ggplotly()
    
  })

  
  output$GG_Policy_Top<-renderPlotly({
    george_mod = 
      george %>% 
      select(., month_year, term_year_bush, !!input$keyword) %>% 
      filter(., term_year_bush >= input$policy_slider[1], term_year_bush <= input$policy_slider[2]) %>% 
      drop_na()
    ggplot() +
      geom_path(data = george_mod, aes_string(x = 'month_year', y = input$keyword)) +
      labs(title = 'Policy Occurrence in Press Briefings', x = '', y = '') +
      theme_bw() + 
      theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
            axis.text=element_text(size = axis_text_sz),
            axis.title=element_text(size = axis_title_sz,face="bold"),
            legend.position='none')
    
    ggplotly()
    })
  
  
  output$GG_Policy_Bottom<-renderPlotly({
    
    george_mod = 
      george %>% 
      select(., month_year, term_year_bush) %>% 
      filter(., term_year_bush >= input$policy_slider[1], term_year_bush <= input$policy_slider[2]) %>% 
      drop_na()
    
    if (input$policy_radio == 0){
      auxiliary_mod = 
        auxiliary %>% 
        select(., month_year, term_year_bush, !!input$keyword) %>% 
        filter(., term_year_bush >= input$policy_slider[1], term_year_bush <= input$policy_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = input$keyword)) + 
        xlim(min(george_mod$month_year), max(george_mod$month_year)) +
        labs(title = 'Policy Occurrence in Google Trends', x = '', y = '') +
        theme_bw() + 
        theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
              axis.text=element_text(size = axis_text_sz),
              axis.title=element_text(size = axis_title_sz,face="bold"),
              legend.position='none')
    } else if (input$policy_radio == 1) {
      auxiliary_mod = 
        auxiliary %>% 
        select(., month_year, term_year_bush, SP_500) %>% 
        filter(., term_year_bush >= input$policy_slider[1], term_year_bush <= input$policy_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'SP_500'), color="purple") + 
        xlim(min(george_mod$month_year), max(george_mod$month_year)) +
        labs(title = 'S&P 500 Performance', x = '', y = '') +
        theme_bw() + 
        theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
              axis.text=element_text(size = axis_text_sz),
              axis.title=element_text(size = axis_title_sz,face="bold"),
              legend.position='none')
    } else {
      auxiliary_mod = 
        auxiliary %>% 
        select(., month_year, term_year_bush, Approving, Disapproving, Unsure) %>% 
        filter(., term_year_bush >= input$policy_slider[1], term_year_bush <= input$policy_slider[2]) %>% 
        drop_na()
      ggplot() +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'Approving'), color="green") + 
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'Disapproving'), color="red") +
        geom_path(data = auxiliary_mod, aes_string(x = 'month_year', y = 'Unsure')) +
        xlim(min(george_mod$month_year), max(george_mod$month_year)) +
          labs(title = 'Presidential Approval', x = '', y = '') +
          theme_bw() + 
          theme(plot.title = element_text(size = title_text_sz, hjust = 0.5),
                axis.text=element_text(size = axis_text_sz),
                axis.title=element_text(size = axis_title_sz,face="bold"),
                legend.position='none')
    }
    
    ggplotly()
    
  })
  
  # show data using DataTable
  output$Press_Briefing_Word_Count <- DT::renderDataTable({
    datatable(george, rownames=FALSE, options = list(scrollX = TRUE))
  })
  
  # show data using DataTable
  output$Google_Trends <- DT::renderDataTable({
    datatable(Google_Table, rownames=FALSE, options = list(scrollX = TRUE))
  })
  
  # show data using DataTable
  output$POTUS_Approval <- DT::renderDataTable({
    POTUS_filter = auxiliary %>% 
      select(., year, month, Approving, Disapproving, Unsure) %>% 
      drop_na()
    datatable(POTUS_filter, rownames=FALSE)
  })
  
  # show data using DataTable
  output$SP500 <- DT::renderDataTable({
    SP500_filter = auxiliary %>% 
      select(., year, month, SP_500) %>% 
      drop_na()
    datatable(SP500_filter, rownames=FALSE)
  })
  
  
  output$text_blurb <- renderText({
      paste(Intro_pt2_2, Intro_pt2_3, Intro_pt2_4, Intro_pt2_5, Intro_pt2_6, Intro_pt2_7, sep="<br>")
    })
      
  }
)


