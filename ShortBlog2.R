packages <- c("tidyverse", "reshape2", "fauxnaif", "gganimate", "ggthemes",
              "stringr", "gridExtra", "gifski", "png", "ggrepel", "scales",
              "lubridate", "paletteer", "GGally", "systemfonts", "extrafont",
              "colorspace", "sf", "rnaturalearth", "ggmap",
              "rnaturalearthdata", "paletteer", "stringr", "haven",
              "plotly", "ggridges")

lapply(packages, require, character.only = TRUE)

library(vdemdata)

dim(vdem) #27,380 observations of 4170 variables 

summary(vdem$year)

#Online media Fractionalization 
summary(vdem$v2smmefra) #page 327 of vdem codebook 

#Election Turnout
summary(vdem$v2eltrnout) #page 72 of vdem codebook

# I want to only look at years beyond 2010 (from class)
vdem %>%
  filter(year >= 2010,  v2smonex >= 1)-> recent_vdem

recent_vdem %>%
  ggplot(aes(x = v2smmefra_osp, y = v2eltrnout, color = v2x_polyarchy)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "#8E0B0B") +
  scale_color_hp(house = "Gryffindor", name = "Electoral Democracy Index") +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", title = "How Online Media Fractionalization Impacts Voter Turnout") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  ylim(0,100)-> basic_plot

ggsave("pointplot.png", basic_plot)



ggplotly(basic_plot)
basic_plot <- plot_ly
basic_plot <- basic_plot %>%
  add_trace(
    type = 'scatter',
    mode = 'markers',
    x = "v2smmefra_osp",
    y = "v2eltrnout",
    text = country_name,
    hovertemplate = paste(
      "<b>%{text}</b><br><br>",
      "%{yaxis.title.text}: %{y:$,.0f}<br>",
      "%{xaxis.title.text}: %{x:.0%}<br>",
      "Number Employed: %{marker.size:,}",
      "<extra></extra>"
    )
  ) 
fig <- fig %>%
  layout(legend = list(orientation = 'h', y = -0.3))







# Want to create a violin plot by category. Categorizing the variables:
recent_vdem %>% 
  mutate(
    # Create categories
    v2smmefra_osp_cat = dplyr::case_when(
      v2smmefra_osp <= 1 ~ "Low",
      v2smmefra_osp > 1 &  v2smmefra_osp <= 2 ~ "Moderate",
      v2smmefra_osp > 2 &  v2smmefra_osp <= 3 ~ "Medium",
      v2smmefra_osp > 3 &  v2smmefra_osp <= 4 ~ "High"
    ),
    # Convert to factor
    v2smmefra_osp_cat = factor(
      v2smmefra_osp_cat,
      level = c("Low", "Moderate", "Medium", "High")
    ),
    v2eltrnout_cat = dplyr::case_when(
      v2eltrnout <= 60 ~ "Low",
      v2eltrnout > 60 &  v2eltrnout <= 73 ~ "Moderate",
      v2eltrnout > 73 &  v2eltrnout <= 85 ~ "Medium",
      v2eltrnout > 85 ~ "High"
    ),
    # Convert to factor
    v2eltrnout_cat = factor(
      v2eltrnout_cat,
      level = c("Low", "Moderate", "Medium", "High")
    ),
  )-> recent_vdem



library(harrypotter)

#Violin Plot code:
recent_vdem %>% 
  group_by(v2smmefra_osp_cat) %>%
  ggplot(aes(x = v2smmefra_osp_cat, y = v2eltrnout, fill = v2smmefra_osp_cat)) +
  geom_violin() + 
  geom_vline(xintercept = mean(recent_vdem$v2smmefra_osp_cat, na.rm = T), 
             color = "black", lwd = 1, lty = "dotted") + 
  scale_fill_hp(discrete = TRUE, option = "Mischief", name = "Level of Media \n Fractionalization") +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", 
       title = "Media Fractionalization and Electoral Turnout") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  ylim(0,100)-> violin_plot

ggsave("violin_plot.png", violin_plot)

recent_vdem %>%
  mutate(count(v2smmefra_osp_cat))-> v2smmefra_osp_cat_count

recent_vdem %>% 
  ggplot(aes(x = v2smmefra_osp_cat, fill = v2smmefra_osp_cat)) +
  geom_histogram(stat = "count") + 
  scale_fill_hp(discrete = TRUE, option = "Mischief", name = "Level of Media \n Fractionalization") +
  labs(x = "Level of Online Media Fractionalization", y = "Number Of Countries", 
       title = "Number of Countries by Level of Fractionalization") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino"))-> hist_plot1
  

recent_vdem %>% 
  ggplot(aes(x = v2eltrnout_cat, fill = v2eltrnout_cat)) +
  geom_histogram(stat = "count") + 
  scale_fill_hp(discrete = TRUE, option = "Mischief", name = "Level of Media \n Fractionalization") +
  labs(x = "Level of Online Media Fractionalization", y = "Number Of Countries", 
       title = "Number of Countries by Level of Fractionalization") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino"))-> hist_plot1




#finding what places have the most polarization:

recent_vdem %>%
  filter(v2smmefra_osp >= 3.5) %>%
  ggplot(aes(x = v2eltrnout, fill = country_name)) +
  geom_density() +
  scale_fill_paletteer_d("ggthemes::manyeys", name = "Country") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  xlim(25,100) +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", title = "How Online Media Fractionalization Impacts Voter Turnout")

recent_vdem %>%
  filter(v2smmefra_osp <= 1.25) %>%
  ggplot(aes(x = v2eltrnout, fill = country_name)) +
  geom_density() +
  scale_fill_paletteer_d("ggthemes::manyeys", name = "Country") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  xlim(0,100) +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", title = "How Online Media Fractionalization Impacts Voter Turnout")





#Variables on a world map?
countries_vdem <- unique(vdem$country_name)

world_2 <- ne_countries(country = print(countries_vdem), returnclass = "sf")


ggplot(data = world_2)+ 
  geom_sf(aes()) + 
  theme(
    panel.background = element_blank()
  )

inner_join(world_2, vdem, 
           by = c("geounit" = "country_name")) -> vdem_mapping

vdem_mapping %>% 
  filter(year == 2010) %>%
  ggplot(aes(fill = v2smmefra_osp)) + 
  geom_sf() +
  ggtitle("World map", subtitle = "Media Polarization") +
  scale_fill_hp(house = "Ravenclaw", name = "Media Polarization \n 4 being no polarization") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_blank(), 
        panel.grid.major.x = element_blank(),
        text = element_text(family = "Palatino"))-> mediamap
  
summary(vdem$v2eltrnout)

vdem_mapping %>% 
  filter(year >= 2010) %>%
  filter(!is.na(v2eltrnout)) %>%
  ggplot(aes(fill = v2eltrnout)) + 
  geom_sf() +
  ggtitle("World map", subtitle = "Electoral Turnout") +
  scale_fill_hp(house = "Ravenclaw", name = "Electoral Turnout")+
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_blank(), 
        panel.grid.major.x = element_blank(),
        text = element_text(family = "Palatino"))-> electmap 

grid.arrange(electmap, mediamap) ->sidebysidemap

ggsave("mapimage.png", sidebysidemap)

#over time
vdem %>%
  filter(country_name == "United States")-> US_vdem

vdem %>%
  filter(country_name == "United States of America") %>%
  filter(year >= 2000) %>%
  ggplot(aes(x = year, y = v2smmefra_osp, color = v2eltrnout)) +
  geom_point() + 
  geom_line() +
  scale_color_hp(house = "Gryffindor", name = "Electoral Democracy Index") +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", title = "How Online Media Fractionalization Impacts Voter Turnout") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  ylim(0,100)-> basic_plot

  
vdem %>%
  filter(country_name == "United States of America") %>%
  filter(year >= 2000) %>%
  ggplot(aes(x = year, y = v2eltrnout)) +
  geom_point() + 
  geom_line()
  
vdem %>%
  filter(country_name == "United of States") %>%
  ggplot(aes(x = v2smmefra_osp, y = v2eltrnout, color = v2x_polyarchy)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "#8E0B0B") +
  scale_color_hp(house = "Gryffindor", name = "Electoral Democracy Index") +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", title = "How Online Media Fractionalization Impacts Voter Turnout") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  ylim(0,100)-> basic_plot

  

#hex plot 
recent_vdem %>%
  ggplot(aes(x = v2smmefra_osp, y = v2eltrnout, fill = v2smmefra_osp_cat)) +
  geom_hex(alpha = 0.9) +
  scale_fill_hp(discrete = TRUE, option = "Mischief", name = "Level of Media \n Fractionalization") +
  labs(x = "Online Media Fractionalization", y = "Electoral Voter Turnout", 
       title = "Media Fractionalization and Electoral Turnout") +
  theme(panel.background = element_rect(fill= "white", color = "black"), 
        panel.grid.major.y = element_line(color = "gray", size = 0.3), 
        panel.grid.major.x = element_line(color = "gray", size = 0.3),
        text = element_text(family = "Palatino")) +
  ylim(0,100)-> hexgrid
  
ggsave("hexgrid.png", hexgrid)
  
  

