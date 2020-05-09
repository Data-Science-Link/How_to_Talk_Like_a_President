
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    observe({
      updateSelectInput(session, 'keyword',
                        choices = unique(Policy[Policy$policy_type == input$policy_type, 'policy']),
                        selected = unique(Policy[Policy$policy_type == input$policy_type, 'policy'][1]))
    })

  
    output$value <- renderPrint({ 
      Policy_Names_Subset = Policy %>% 
        filter(., policy_type == input$policy_type)
      Policy_Names_Subset = array(Policy_Names_Subset$policy)
      Policy_Names_Subset[1]
      })
    

    output$GG_Total_Nation_Summed_Claims<-renderPlotly({
        ggplotly()
        })
    
    output$GG_Accumulation_for_Nation<-renderPlotly({
        ggplotly(
                if (input$nation_radio == 0){
                } else if (input$nation_radio == 1) {
                } else if (input$nation_radio == 2){
                } else {
                    }
                )
        })
    
    output$GG_Summed_Claim_Cost_by_Top_10_States<-renderPlotly({
        ggplotly()
        })
    
    output$GG_Total_State_Summed_Claims<-renderPlotly({
        ggplotly()
        })
    
    output$GG_Accumulation_for_State<-renderPlotly({
        ggplotly()
        })
    
    output$GG_Summed_Claim_Cost_by_Top_10_Counties<-renderPlotly({
        ggplotly()
        })
  
      output$GG_Amount_PD<-renderPlotly({
        ggplotly()
    })
      
      output$GG_Avg_PD_Losses<-renderPlotly({
          ggplotly()
      })
      
      output$GG_Accumulation_for_Nation_Regression<-renderPlotly({
          if (input$regression == 0) {
          } else if (input$regression == 1) {
          } else {
          }
          ggplotly()
          })
    
      output$GG_Accumulation_for_Nation_Standardized<-renderPlotly({
          ggplotly()
      })
      
      output$GG_Standardized_Accumulation_State<-renderPlotly({
          ggplotly()
      })
      
      # show data using DataTable
      output$table_cleaned <- DT::renderDataTable({
          datatable(filter.raw.df, rownames=FALSE)
      })
      
      # show data using DataTable
      output$table_manipulated <- DT::renderDataTable({
          datatable(Accumulate_DF, rownames=FALSE)
      })
      
      # show data using DataTable
      output$table_major_storms <- DT::renderDataTable({
          datatable(major_storms, rownames=FALSE)
      })
      
      output$text_blurb <- renderText({
          paste(Intro_pt2_2, Intro_pt2_3, Intro_pt2_4, Intro_pt2_5, Intro_pt2_6, Intro_pt2_7, sep="<br>")
      })
      
    }
)


