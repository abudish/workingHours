# Reading and preparing data
library(ggplot2)
library(reshape2)
library(readxl)
library(ggthemes)

df <- read_xlsx("data/Working hours per week (1985 - 2007).xlsx")
df <- melt(df, id="Working hours per week")
colnames(df) <- c("country", "year", "hours_per_week")



# Define server logic
shinyServer(function(input, output) {

        output$time_series <- renderPlot({
                year_range <- input$years[1]:input$years[2]
                selected_countries <- subset(df, (year %in% year_range) & (country==input$country | country==input$country2))
                # data=subset(df, (year %in% year_range) & country==input$country)
                
                ggplot(data=selected_countries,
                       aes(x=year, y=hours_per_week, colour=country, group=country)) + 
                        geom_line(size=1.5) +
                        geom_point(size=2, shape=21, fill="red") +
                        ggtitle(paste("Working hours per week,", input$country, "and", input$country2)) +
                        theme_hc() +
                        scale_colour_hc() +
                        theme(plot.title = element_text(hjust = 0.5, size = 22),
                              text = element_text(size = 15)) +
                        labs(y= "Working hours per week", x="Years")
                
                        #coord_cartesian(ylim = c(25, 57))
                
        })
        
        output$mytable  <-  renderDataTable({
                year_range <- input$years[1]:input$years[2]
                selected_countries <- subset(df, (year %in% year_range) & (country==input$country | country==input$country2))
                selected_countries
        })
        
        output$`t-test` <- renderPrint({
                year_range <- input$years[1]:input$years[2]
                hours_per_week_country1 <- subset(df, (year %in% year_range) & country==input$country, select = hours_per_week)
                hours_per_week_country2 <- subset(df, (year %in% year_range) & country==input$country2, select = hours_per_week)
                t.test(hours_per_week_country1, hours_per_week_country2)
        })
})
