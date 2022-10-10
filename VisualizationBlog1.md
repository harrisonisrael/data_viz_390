# Visualization Blog 1


### A Good Visualization- From Business Insider

![GoodVisual.png](https://github.com/harrisonisrael/data_viz_390/blob/main/GoodVisual.png)

There isn't necessarily a ton of information on the above chart, but I think that's what makes it a really good graph, especially with such a contentious and important issue. The graph is very easy to read and understand, which I think is necessary for the average reader who might stumble across this graph (it is hard to misread it's data). The graph also allows you to see the percentages when you mouse over either the blue bars or the red bars. I think that if I were to suggest one thing to make this graphic just a little bit better, it would be to add gender to the data to see the split of males and females within each political category that beleive abortion shoul dbe legal. In order to recreate this graph, I would use ggplot, specifically the code of geom_bar. I would group the four categories into two (the data in previous graphs had legal in all cases, legal in most cases, illegal in all cases, and illegal in most casses, so you would have to group the data in order to only have two groups). You would then have to use geom_bar to graph the data. You would have to adjust the colors of the bars, and add the title and the graph's key. 

Click [here](https://www.businessinsider.com/abortion-access-in-america-maps-charts-if-roe-falls-2018-8#a-supermajority-of-democrats-support-keeping-abortion-legal-while-conservative-republicans-favor-making-it-illegal-moderates-are-more-split-7) to explore the graph further.

### A Lousy Visualization - From Bloomberg.com
![Screen Shot 2022-10-04 at 9.36.09 PM.png)](https://github.com/harrisonisrael/data_viz_390/blob/main/Screen%20Shot%202022-10-04%20at%209.56.06%20PM.png)

This Bloomberg image is incredibly difficult to read. The dots for each country are incredibly small and the overall scale for the chart is very off, with most of the dots clumped around the bottom of the chart. You also are only able to see the label for one country at a time. While this does reduce clutter if the graph was otherwise labeled, it makes it nearly impossible to compare multiple countries. I would suggest that the graph adjusts its scale in order to make the relevant data more of a focus, as well as increasing the size of each country dot. I also would suggest limiting the number of countries on the chart in order to either add labels that are clear or to make comparisons between countries far easier. 

Click [here](https://www.bloomberg.com/graphics/2022-us-gun-violence-world-comparison/?leadSource=uverify%20wall) to explore the graph further. 

### My Own Visualization

![firearms_crimeindex_img.png)](https://github.com/harrisonisrael/data_viz_390/blob/main/firearms_crimeindex_img.png)

The above graph takes data about the number of firearms in a country per 100 people, and Numbeo's crime index rating to see how the amount of firearms in a country influences the amount of crime in the country. The crime index rating is a relative estimation of the overall amount of crime in a country. The index believes that a number lower than 20 is a very low amount of crime, 20-40 is a low amount, 40-60 is a moderate amount of crime, and any rating above 60 is a high amount of crime. The **blue** dot represents the United States, the **green** dot represents Australia, and the **orange** dot represents Canada. Country's whose number of firearms per 100 people exceeds 30 are labled. To create the table, I removed all of the data that was listed as N/A and renamed all the variables so they were easier to work with. I then used the geom_point function to create the graph, hanging the labels of some of the points, along with the colors. I also used the facet_wrap function to sort the data by region. This graph is far from perfect, and could use more manipulation and more advanced coding to be improved. For starters, the label for the United States (the blue dot) is not visibile on the graph. I also wish to see a regression line on each individual grpah, but was unable to find the code (and get it to work) to do so, and would look towards doing this as I learn more about ggplot and about visualization.
