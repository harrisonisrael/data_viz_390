packages <- c("tidyverse", "reshape2", "fauxnaif", "gganimate", "ggthemes",
             "stringr", "gridExtra", "gifski", "png", "ggrepel", "scales",
             "lubridate", "paletteer", "GGally", "systemfonts", "extrafont")
library(paletteer)
library(tidyverse)
library(reshape2)
library(fauxnaif)
library(ggthemes)
library(stringr)
library(gridExtra)
library(haven)
library(gifski)
library(png)
library(ggrepel)
library(scales)
library(lubridate)
library(GGally)
library(systemfonts)
library(extrafont)
library(readxl)



#Loading in the data and selecting relevant columns
polling_data <- read_csv('polling_data.csv')
view(polling_data)

polling_data %>% 
  filter(population == "rv") %>%
  #I decided to only look at the approval rating for registered voters, in order to look at a smaller subsection of the data and to limit/clean up the visualization
  select(president, startdate, enddate, samplesize, approve, disapprove, pollster)-> poll_data

# Standard Error Calculation, as shown in class:
std.error.prop <- function(x, n){
  
  sqrt((x * (100-x))/n)
}

std.error.prop(x = poll_data$approve, n = poll_data$samplesize)

# Calculating Confidence Intervals:
poll_data %>%
  mutate(mean_approve = approve, 
         se_pct = std.error.prop(approve, samplesize), 
         # 95 % CI 
         lower_bound_95 = CIbound(mean_approve, se_pct, 1.96, upper = F), 
         upper_bound_95 = CIbound(mean_approve, se_pct, 1.96, upper = T), 
         # 90 % CI 
         lower_bound_90 = CIbound(mean_approve, se_pct, 1.65, upper = F), 
         upper_bound_90 = CIbound(mean_approve, se_pct, 1.65, upper = T), 
         # 99 % CI 
         lower_bound_99 = CIbound(mean_approve, se_pct, 2.58, upper = F),  
         upper_bound_99 = CIbound(mean_approve, se_pct, 2.58, upper = T))-> poll_data
# With public opinion data with a sample size and average score (in this case, approval rating), confidence intervals are one of the best ways to demonstrate the degree of uncertainty that comes with such averages. The 95% confidence interval is the one I end up using below (though I tested out the graph using all three of the intervals created above) captures a good degree of uncertainty and was the standard in many of my other classes. The confidence intervals demonstrate to what degree the results and changes within Biden's approval ratings are significant. As shown by the graph, while most adjacent confidence intervals overlap, calling into question the degree to which his approval rating is changing over successive polls, the overall approval rating from January to December has decreased and looks to be significant enough to make the judgment that Biden's approval rating has decreased over 2021. I calculated the confidence intervals by setting upper and lowerbounds based on the standard errors and mean approval rating. This is just like how one would calculate confidence intervals by hand, though just on a larger scale!


poll_data$enddate <- as.Date(poll_data$enddate, format = "%m/%d/%y")

poll_data %>%
  filter(pollster == "Morning Consult" | pollster == "Rasmussen Reports/Pulse Opinion Research") %>%
  ggplot(aes(x=enddate, y = mean_approve)) +
  geom_point( 
    size = 2, color = "#196F3D"
  )+
  geom_errorbar(
    aes(ymin = lower_bound_95, 
        ymax = upper_bound_95), 
    width = 2, color = "#27AE60") +
  geom_line(color = "#1E8449") +
  ylim(0,100) + 
  scale_x_date(date_breaks = "1 month", 
               date_minor_breaks = "1 week",
               date_labels = "%b") + 
  theme(panel.background = element_rect(fill = "white",
                                         color = "black"),
         panel.grid.major = element_line(color = "grey"), 
        text = element_text(family = "Palatino")) +
  labs(y = "Approval Rating as a Percentage of Registered Voters", x ="",
       title = "Joe Biden's Appoval Rating, 2021")-> approval_rating
ggsave("approval_rating.png", approval_rating)



gunviolence <- read_excel("/Users/harrisonisrael/Downloads/gunviolence.xlsx")
View(gunviolence) 

gunviolence %>%
  select(firearms100 = 'Estimate of civilian firearms per 100 persons',
         country = 'Country or subnational area',
         pop2017 = 'Population 2017',
         reg_firearms = 'Registered firearms',
         unreg_firearms = 'Unregistered firearms',
         crime_index = 'Crime Index',
         safety_index = 'Safety Index',
         region = 'Region') -> gunviolence_sub


gunviolence_sub %>% 
  ggplot(aes(y = as_factor(region), x = firearms100, 
             fill = as_factor(region))) +
  stat_halfeye(
    adjust = 0.5,
    width = 1.5, 
    ## Here, I am able to show the 95% confidence interval/ data range. This fits neatly into the graph and pairs nicely with the distribution. I am able to show the average with the black dot on the middle of each, along with the range of data. It shows which points are outliers and how the presence of firearms truly varies across regions, ass you are able to see how these intervals overlap. Uncertainty is calculated and showed by the stat_halfeye function itself. 
    .width = c(.5, .95)
  ) + 
  stat_dots(
    aes(color = as_factor(region)),
    side = "bottom", 
    dotsize = 3.5, 
    justification = 1.05, 
    binwidth = 0.2, 
    alpha = 0.5
  ) +
  xlim(0, 63) +
  scale_fill_paletteer_d("ggthemes::excel_Badge", 
                         name = "") +
  scale_color_paletteer_d("ggthemes::excel_Badge", 
                          name = "") + 
  theme(axis.text.x = element_text(size = 14), 
        axis.text.y = element_text(size = 14),
        panel.background = element_rect(fill = "white", color = "grey"), 
        panel.grid.major = element_line(color= "grey"),
        text = element_text(family = "Palatino"), 
        legend.position = "none") + 
  labs(y = "Region", 
       x = "Number of Firearms per 100 people",
       title = "Firearm Presence Across Regions")-> firearm_raincloud


ggsave("firearm_raincloud.png", firearm_raincloud)


