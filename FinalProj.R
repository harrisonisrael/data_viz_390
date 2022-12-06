packages <- c("tidyverse", "reshape2", "fauxnaif", "gganimate", "ggthemes",
              "stringr", "gridExtra", "gifski", "png", "ggrepel", "scales",
              "lubridate", "paletteer", "GGally", "systemfonts", "extrafont",
              "colorspace", "sf", "rnaturalearth", "ggmap",
              "rnaturalearthdata", "paletteer", "stringr", "haven", 
              "plotly", "ggridges")

lapply(packages, require, character.only = TRUE)

loadfonts(device = "all")

massshootings <- read_csv("massshootings.csv")
view(massshootings)

library(leaflet)
library(htmltools)
library(htmlwidgets)
library(harrypotter)

massshootings$new_date <- format(as.Date(massshootings$`Incident Date`), "%D")

tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 30%;
    text-align: left;
    padding-left: 5px; 
    padding-right: 5px; 
    background: rgba(255,255,255,0.75);
    font-size: 16px;
  }
"))
tag.map.caption <- tags$style(HTML("
  .leaflet-control.map-caption { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 30%;
    text-align: left;
    padding-left: 5px; 
    padding-right: 5px; 
    background: rgba(255,255,255,0.75);
    font-size: 8px;
  }
"))

title <- tags$div(
  tag.map.title, HTML("Mass Shootings in the U.S., 2022")
)  

caption <- tags$div(
  tag.map.caption, HTML("Data Source: Gun Violence Archive (GVA) at <a href='https://www.gunviolencearchive.org/reports/mass-shooting'>this website</a>")
)  

massshootings %>%
  leaflet() %>%
  setView(-103.4617, 44.58, zoom = 4) %>%
  addTiles() %>%
  addMarkers(~longitude, ~latitude, 
             popup = ~paste("<style> div.leaflet-popup-content {width:500px !important;}</style> <b>Date:</b>", Incident_Date, "<br>", 
                            "<b>Killed</b>:", Killed,
                            "<b>Injured</b>:", Injured), 
             clusterOptions = markerClusterOptions()) %>%
  addControl(title, position = "topleft", className="map-title") %>%
  addControl(caption, position = "bottomleft", className = "caption")->massshootings_map


saveWidget(massshootings_map, file = "massshootings.html", 
           knitrOptions = c(fig.width = 10), 
           title = "Mass Shootings in the U.S., 2022")

api_create(massshootings_map, filename = "massshootings_map_file")



#######
# Number of Guns and Gun Death Rates Correlation?

CDCdeaths <- read_csv("CDCdeaths.csv")

CDCdeaths %>%
  filter(YEAR == 2020) %>%
  ggplot(aes(x = GUNS, y = RATE, color = DEATHS)) +
  geom_point(alpha = 0.5, size = 2.5, aes(text = STATE)) +
  geom_smooth(method = "lm", color = "#8E0B0B", se = FALSE, size = 1) +
  scale_color_hp(house = "Gryffindor", name = "Number of Gun Deaths") +
  labs(x = "Percentage of Homes with Guns", y = "Number of Gun Deaths per 100,000 of the Total Population", title = "Do States with More Guns have Higher Rates of Gun-Related Deaths?") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35), 
        panel.grid.major.x = element_line(color = "gray", size = 0.15),
        text = element_text(family = "Palatino")) +
  ylim(0,30) +
  xlim(0,70)-> ownership_plot

ggplotly(ownership_plot) -> gunownership_interactive

saveWidget(gunownership_interactive, file = "gunownership_interactive.html", 
           knitrOptions = c(fig.width = 10), 
           title = "Gun Deaths and Gun Ownership Rates")

api_create(gunownership_interactive, filename = "gunownership_interactive_file")


ggsave("ownership_plot.png", ownership_plot)



CDCdeaths %>%
  filter(YEAR == 2016) %>%
  ggplot(aes(x = LAWS, y = RATE, color = GUNS)) +
  geom_point(alpha = 0.7, size = 2.5, aes(text = STATE)) +
  geom_smooth(method = "lm", color = "#9F9F9F", se = FALSE, size = 0.8) +
  scale_color_hp(house = "Hufflepuff", name = "Percentage of Households \n with Guns") +
  labs(x = "Number of Gun Laws", y = "Number of Gun Deaths per 100,000 of the Total Population", title = "Do States with Less Gun Laws have Higher Rates of Gun-Related Deaths?") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35), 
        panel.grid.major.x = element_line(color = "gray", size = 0.15),
        text = element_text(family = "Palatino")) +
  ylim(0,30) +
  xlim(0,100)-> laws_plot

ggplotly(laws_plot) -> lawsplot_interactive

saveWidget(lawsplot_interactive, file = "lawsplot_interactive.html", 
           knitrOptions = c(fig.width = 10), 
           title = "Number of Gun Laws and Gun Deaths")

ggsave("laws_plot.png", laws_plot)



#####
# Rand Data

RANDdata <- read_csv("RANDgun.csv") 

#histogram

RANDdata %>%
  filter(Year == 2016) %>%
  ggplot(aes(x = universl)) +
  geom_bar(na.rm = FALSE, fill = "#145A32") +
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, color = "white", size = 8)+
  labs(x = "Does the State have Universal Background Checks? \n 0 = no, 1 = yes", y = "Number of States", title = "Background Checks") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35), 
        panel.grid.major.x = element_line(color = NA),
        text = element_text(family = "Palatino")) +
  ylim(0,40)-> backgroundchecks

RANDdata %>%
  filter(Year == 2016) %>%
  ggplot(aes(x = permit)) +
  geom_bar(na.rm = FALSE, fill = "#145A32") +
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, color = "white", size = 8)+
  labs(x = "Does the State have a Permit to Purchase Law? \n 0 = no, 1 = yes", y = "Number of States", title = "Permit to Purchase Laws") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35), 
        panel.grid.major.x = element_line(color = NA),
        text = element_text(family = "Palatino")) +
  ylim(0,40)-> permitlaw


grid.arrange(backgroundchecks, permitlaw, nrow = 1) -> numberofstates

ggsave("numberofstates.png", numberofstates)



#ok I want to look at MD, PA, NC, IO, CT, Nebraska, maybe Oregon 

RANDdata %>%
  filter(STATE == "Maryland") %>%
  ggplot(aes(x = Year, y = Male_FS_S, color = universl)) +
  geom_point()+
  geom_line() +
  geom_vline(xintercept = 1996, linetype = "dotted") +
  geom_vline(xintercept = 2013, linetype = "dotted") +
  ylim(0,0.65)+
  xlim(1980,2016) +
  scale_color_hp(house = "Slytherin") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35),
        panel.grid.minor.y = element_line(color = "gray", size = 0.15),
        panel.grid.major.x = element_line(color = NA),
        legend.position = "none",
        text = element_text(family = "Palatino")) +
  labs(y = "Percentage of Male Suicides that are due to Guns", x ="Year",
       title = "Maryland: Do Universal Background Checks Impact the Number \n of Male Suicides by Guns",
       subtitle = "In 1996, Universal Background Checks were added. In 2013, Permit Laws were added") -> maryland_graph

ggsave("maryland.png", maryland_graph)


RANDdata %>%
  filter(STATE == "Pennsylvania") %>%
  ggplot(aes(x = Year, y = GSS, color = universl)) +
  geom_point()+
  geom_smooth(method = "lm", color = "#9BBD9E", se = FALSE)+
  geom_vline(xintercept = 1995, linetype = "dotted") +
  ylim(0,0.65)+
  xlim(1980,2016) +
  scale_color_hp(house = "Slytherin") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35),
        panel.grid.minor.y = element_line(color = "gray", size = 0.15),
        panel.grid.major.x = element_line(color = NA),
        legend.position = "none",
        text = element_text(family = "Palatino")) +
  labs(y = "Percentage of Guns Per Capita, General Social Survey Estimation", x ="Year",
       title = "Pennsylvania: Do Universal Background Checks Impact the \n Number of of Guns",
       subtitle = "In 1995, Universal Background Checks were added.") -> pennsylvania_graph
       
ggsave("pennsylvania.png", pennsylvania_graph)     

RANDdata %>%
  filter(STATE == "Iowa") %>%
  ggplot(aes(x = Year, y = Male_FS_S, color = universl)) +
  geom_point()+
  geom_line() +
  geom_vline(xintercept = 1990, linetype = "dotted") +
  ylim(0,0.65)+
  xlim(1980,2016) +
  scale_color_hp(house = "Slytherin") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35),
        panel.grid.minor.y = element_line(color = "gray", size = 0.15),
        panel.grid.major.x = element_line(color = NA),
        legend.position = "none",
        text = element_text(family = "Palatino")) +
  labs(y = "Percentage of Male Suicides that are due to Guns", x ="Year",
       title = "Iowa: Do Universal Background Checks and Permit Laws \n Impact the Number of Male Suicides by Guns", subtitle = "In 1990, Universal Background Checks and Permit Laws were added.") -> iowa_graph

ggsave("iowa.png", iowa_graph)
 
RANDdata %>%
  filter(STATE == "Connecticut") %>%
  ggplot(aes(x = Year, y = Male_FS_S, color = universl)) +
  geom_point()+
  geom_line() +
  geom_vline(xintercept = 1995, linetype = "dotted") +
  ylim(0,0.65)+
  xlim(1980,2016) +
  scale_color_hp(house = "Slytherin") +
  theme(panel.background = element_rect(fill= "white", color = NA), 
        panel.grid.major.y = element_line(color = "gray", size = 0.35),
        panel.grid.minor.y = element_line(color = "gray", size = 0.15),
        panel.grid.major.x = element_line(color = NA),
        legend.position = "none",
        text = element_text(family = "Palatino")) +
  labs(y = "Percentage of Male Suicides that are due to Guns", x ="Year",
       title = "Connecticut: Do Universal Background Checks and Permit Laws \n Impact the Number of Male Suicides by Guns", subtitle = "In 1995, Universal Background Checks and Permit Laws were added.")-> connecticut_graph

ggsave("conneceticut.png", connecticut_graph)

######
#State Maps

install.packages("usmap")
library(usmap)

Countydata <- read_csv("Countydata.csv") 

CDCdeaths %>%
  filter(YEAR == 2016) -> CDCdeaths_2016

Countydata %>%
  filter(`InjuryIntent` == "All Firearm Deaths") -> Countydata_filtered

###### 
# Actual Maps!!! Yay
plot_usmap(data = CDCdeaths_2016, values = "RATE", lines = "black") + 
  scale_fill_continuous(low = "white", high = "red", name = "Firearm Death Rate", label = scales::comma) +
  labs(title = "United States",
       subtitle = "Firearm Death Rate by State") + 
  theme(panel.background=element_blank())

plot_usmap(data = CDCdeaths_2016, values = "LAWS", lines = "black") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Firearm Death Rate", label = scales::comma) +
  labs(title = "United States",
       subtitle = "Number of Gun Control Laws") + 
  theme(panel.background=element_blank())


plot_usmap(data = CDCdeaths_2016, values = "RATE", include = c("CT", "ME", "MA", "NH", "VT", "RI"), color = "black") + 
  scale_fill_continuous(low = "white", high = "orange", name = "Firearm Death Rate", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Firearm Death Rate by State in 2016") +
  theme(legend.position = "right")



suiciderates <- read_csv("suiciderates.csv") 

plot_usmap(data = suiciderates, values = "CrudeRate", include = c("CT", "ME", "MA", "NH", "VT", "RI"), color = "black") + 
  scale_fill_continuous(low = "white", high = "red", name = "Firearm Death Rate", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Suicide by Firearm Rate by State in 2016") +
  theme(legend.position = "right") -> newengland_suicide 



plot_usmap(data = CDCdeaths_2016, values = "LAWS", include = c("CT", "ME", "MA", "NH", "VT", "RI"), color = "black") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Number of Laws", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Number of Gun Control Laws by State") +
  theme(legend.position = "right") -> newengland_laws 


grid.arrange(newengland_laws, newengland_suicide, nrow = 1) -> newengland

ggsave("newengland.png", newengland)


### Other maps I made: 

Countydata %>%
  filter(`Injury Intent` == "All Firearm Deaths") %>%
  plot_usmap(regions = "counties", values = "Total Deaths (#)", color = "Red") + 
  scale_fill_continuous(name = "Number of Gun Control laws", label = scales::comma) + 
  theme(legend.position = "right")


plot_usmap(regions = "states", values = CDCdeaths_2016$RATE, color = "blue") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Poverty Percentage Estimates", label = scales::comma) +
  labs(title = "U.S. States",
       subtitle = "This is a blank map of the United States.") + 
  theme(panel.background=element_blank())



plot_usmap(data = Countydata_filtered, values = "TotalDeaths", lines = "black") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Firearm Death Rate", label = scales::comma) +
  labs(title = "United States",
       subtitle = "Number of Gun Control Laws") + 
  theme(panel.background=element_blank())

plot_usmap(data = Countydata_filtered, values = "TotalDeaths",include = c("CT", "ME", "MA", "NH", "VT"))

plot_usmap(regions = "counties", data = Countydata_filtered, values = "TotalDeaths", include = c("CT", "ME", "MA", "NH", "VT"), color = "black") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Poverty Percentage Estimates", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Poverty Percentage Estimates for New England Counties in 2014") +
  theme(legend.position = "right")
                 
counties <- read_csv("counties.csv")

plot_usmap(regions = "counties", data = counties, values = "TotalDeaths", include = c("CT", "ME", "MA", "NH", "VT"), color = "black") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Poverty Percentage Estimates", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Poverty Percentage Estimates for New England Counties in 2014") +
  theme(legend.position = "right")



plot_usmap(data = CDCdeaths_2016, values = "Total Deaths (#)", include = c("CT", "ME", "MA", "NH", "VT"), color = "blue") + 
  scale_fill_continuous(low = "white", high = "blue", name = "Poverty Percentage Estimates", label = scales::comma) + 
  labs(title = "New England Region", subtitle = "Poverty Percentage Estimates for New England Counties in 2014") +
  theme(legend.position = "right")






