# Final Blog Assignment

**Gun Violence and Gun Control Laws in the U.S.**

*CW: Gun Violence*


*To see the code for this final blog post, click [here.](FinalProj.R)*

  On July 4th, 2022, Highland Park held their annual Fourth of July parade. The parade featured local community members, girl scout troops, local bands, daycare classes, and more, and was supposed to be a joyous summer celebration. Families and spectators lined the downtown streets of Highland Park in order to watch the parade, many waving flags or dressed in red, white, and blue. The celebration took a turn for the worse when a gunman opened fire from the roof of a business beside the parade route, firing over 70 shots with a high-powered rifle. Seven people were killed, while thirty-one others were injured. 

Across the country in Maine, I was working as an overnight camp counselor for the summer. One of my campers, a fourteen year old who grew up and lives in Glencoe, Illinois, was pulled from activities for the day and had a phone call with his parents, where he learned one of his family friends had been killed in the attack. Two of my other campers, who grew up in Parkland, Florida and were in the adjoining middle school when the shooting in the high school took place, also have seen the horrible impacts of such gun violence. While mass shootings are not nearly the most prominent way in which people die from gun violence, they prove time and time again that something must change in order to protect our children, our families, and our citizens. This blog post seeks to prove that gun control laws can be effective in reducing gun violence, and urges the United States to begin to implement sweeping gun control to **finally** actually make a change. 


I first wanted to get a better idea of what gun violence in the United States looked like in 2022. As of November 20th, 2022, there had been **604 mass shootings** in the U.S. (a mass shooting being any shooting event in which 4 or more people were shot, not including the shooter). To get a better idea of where these shootings were occuring, and to see if there were any patterns in their distribution, I created an interactive map in RStudio, which allows users to see where shootings are occurring, as well as their date and how many people were injured or killed. As shown by the map at the link below, there is no obvious pattern to mass shootings, which seemingly can occur anywhere in the U.S. They do seem to be concentrated in states that have a higher population density, but the map proves that widespread gun control will be needed to change the current state of the U.S.

*Click [here](https://harrisonisrael.github.io/data_viz_390/) for an interactive map of all mass shootings that have occurred in the US in 2022.*

<br />
<br />
	
At the heart of the gun control debate is the idea that individuals have the right to bear arms, with many even suggesting that more guns would make the United States more safe. Is there validity to this claim? In order to investigate this, I created a graph to see if the number of guns in a state was correlated with the number of gun-related deaths that occurred in the state. 
Using data from the CDC, I created the following scatter plot and regression, which does demonstrate that states with more guns also have more gun-related deaths, disproving the argument that ???more guns are safer???. 

 ![This graph is a the relationship between number of guns and gun violence rates.png](https://github.com/harrisonisrael/data_viz_390/blob/main/ownership_plot.png)

*Here is the [interactive version of the graph](https://plotly.com/~harrisonisrael/3/) with the percentage of guns in relation to the gun death rate by state.*

<br />
<br />

I also wanted to see if this was related to the number of gun laws that a state has. There is wide variety in the number of gun control laws that states have, with Idaho having the fewest number of laws, with only 1, which is the elementary gun control provision prohibiting guns from being carried on elementary school property. Otherwise, no other forms of gun control exist in the state (aside from any federal, countrywide laws). California has the highest number of gun controls at 107, and thus is the strictest state on guns. 

  Using data from the CDC and https://www.statefirearmlaws.org/, created by Boston University, I created another graph and regression to see if there was any correlation between the number of gun laws a state has (just purely the number of laws) and the gun-related death rate for the state. A correlation in this graph would demonstrate purely that gun control laws are effective in a general sense. While there certainly could be unintended correlations between the types of people that vote for gun control laws and the state's firearm-related death rate, the graph does demonstrate that, regardless, gun control laws are effective at reducing the gun-related death rate.
  
   ![This graph is a the relationship between number of gun control laws and gun violence rates.png](https://github.com/harrisonisrael/data_viz_390/blob/main/laws_plot.png)
  
*Here is the [interactive version of the graph](https://plotly.com/~harrisonisrael/1/) with the number of gun control laws in relation to the gun death rate by state.*

<br />
<br />



  New England is an incredibly interesting region to look at and perhaps demonstrates the points shown in the graphs above very clearly. In New England, three states have strict gun control laws, while three states have very lax laws. Massachusetts has 103 gun control provisions in their state laws, and has one of the lowest firearm-related death rates, followed by Connecticut with 92 laws and Rhode Island with 54 laws. Neighboring states, Maine, New Hampshire, and Vermont each have 11, 9, and 20 gun control laws, respectively. The below map shows that the three states with more gun control laws also have much lower suicide by firearm rates. I chose this measure, rather than just purely the gun death rate, to demonstrate that these trends are applicable across intent and situation, as reducing suicides by guns are another incredibly important reason gun control should be enacted. 
  
  ![This graph is a map of New England.png](https://github.com/harrisonisrael/data_viz_390/blob/main/newengland.png)
  
  <br />
  <br />

After seeing that states with more guns have more deaths, and states with more laws have less deaths (and also less guns), I was left wondering what actual laws could be effective at limiting such deaths and injuries. The laws across the country vary greatly, and can therefore be hard to study. While the number of laws a state has certainly has an impact, specific laws might be better at reducing gun violence death rates than others. The RAND corporation created a dataset which included data on two specific laws, a Permit to Purchase law and Universal Background Checks, both of which are often brought up by those urging for gun control. How many states already had these in place? Are they common laws? The bar chart below shows how many states have implemented each of these laws. 

![This graph is a histogram about how many states have gun control laws.png](https://github.com/harrisonisrael/data_viz_390/blob/main/numberofstates.png)

<br />
<br />

  Additionally, the RAND data set also includes a measurement on the percentage of suicides done by guns, as well as many general measurements of how many guns exist in each state (they all report relatively similar numbers, but for this paper I used the GSS estimate, or the General Social Survey estimate because it was done the most often. Other surveys, like those by the Pew Research Center and Gallup were only done a few times, whereas the GSS had reports from nearly every year). Certain states implemented the Permit to Purchase law or the Universal Background Check law (or both) during the time this data was being collected, so I decided to exploit these changes to see if these laws actually caused a decrease in the overall number of guns. I conducted three specific case studies around three states that implemented these laws: Maryland, Iowa, and Connecticut. Maryland implemented Universal background checks in 1996 and the Permit to Purchase law in 2013, both marked on the graph below. As shown, the percentage of male suicides done by guns hovered around 60% prior to the implementation of background checks, and after the implication dropped to around 50%, where it has remained since, demonstrating that these laws can be effective at reducing deaths. 
  
  ![This graph is about Maryland.png](https://github.com/harrisonisrael/data_viz_390/blob/main/maryland.png)


  In Iowa and Connecticut, both a Permit to Purchase Law and Universal Background Checks were implemented at the same time, in 1990 and 1995, respectively. Though the effect is not as pronounced in Iowa, there, like Maryland, the percentage of suicides that were done by guns hovered around 60% prior to the laws, and is now down to around 50%. In Connecticut, it was at around 50% before the laws, but is now down to below 40% and has seen an overall downward trend since the laws were enacted (where as the state was experience an increase in the percentage of suicides done by guns prior to 1995). It is important to note that these graphs merely show preliminary research and not actual controlled experimentation. Correlates are not controlled for in any of the graphs created. However, the sentiment and takeaways are still important: **gun control laws can have an effect on death rates.**
  
  
![This graph is about Iowa.png](https://github.com/harrisonisrael/data_viz_390/blob/main/iowa.png)


![This graph is about Connecticut.png](https://github.com/harrisonisrael/data_viz_390/blob/main/conneceticut.png)

  I also wanted to see if the implementation of these laws impacted the overall number of guns in a state. Using Pennsylvania, which implemented just Universal Background checks in 1995, as well as their GSS estimate for the percentage of guns per capita, you can see that the overall trend for the number of guns in the state has been decreasing. However, when isolating the data into two groups, pre-1995 and post-1995, you can also see that much of the decrease has taken place after the law was implemented, where before, the GSS estimate was hovering around 0.48, and after it has hovered around 0.42. 
  
  ![This graph is about Pennsylvania.png](https://github.com/harrisonisrael/data_viz_390/blob/main/pennsylvania.png)
  
  <br />
  <br />

  Gun control is necessary to help prevent any events like that in Highland Park on July 4th from happening ever again. States with the strictest gun control (the highest number of laws) see the lowest death rates from guns. Places with less guns also see lower death rates. These lower rates occur, not just across overall gun-related death rates, but also across intent and event type (homicide, suicide, accident). As shown by the four case studies above, using Maryland, Iowa, Connecticut, and Pennsylvania, Universal Background Checks and Permit to Purchase laws can both be effective at reducing gun violence. 

  The situation in the U.S., as shown not only by the map of the 604 mass shootings so far this year, but also on the plots of firearm death rates, is dire. Gun control laws are effective at fixing the problem. The solution could not be clearer. I am often reminded of July 4th, where I spent much of the day trying to console a teenage who???s family friend was had just been murdered in Mass Shooting close to his hometown, and close to the place where I go to school. Those heartbreaking phone calls shouldn???t have to happen, and as shown by the preliminary research above, effective gun control laws could be the solution to preventing gun violence in any form across the country. 
  
  
  **Works Cited**
   <br />
   
  ???CDC Wonder.??? Centers for Disease Control and Prevention, Centers for Disease Control and Prevention, 2022, https://wonder.cdc.gov/controller/datarequest/D158;jsessionid=8AF99C8B0D0B3D97A024CAFA2E74. 
   <br />
   
  Cherney, Samantha, Andrew R. Morral, Terry L. Schell, Sierra Smucker, and Emily Hoch, Development of the RAND State Firearm Law Database and Supporting Materials. Santa Monica, CA: RAND Corporation, 2022. https://www.rand.org/pubs/tools/TLA243-2-v2.html.
   <br />
   
???Gun Violence Archive.??? Gun Violence Archive, Gun Violence Archive, 20 Nov. 2022, https://www.gunviolencearchive.org/reports/mass-shooting. 
Learish, Jessica, and Elisha Fieldstadt. ???Gun Map: Ownership by State.??? CBS News, CBS Interactive, 14 Apr. 2022, https://www.cbsnews.com/pictures/gun-ownership-rates-by-state/52/. 
 <br />
 
Shapiro, Emily, and Ivan Pereria. ???Highland Park Parade Mass Shooting Suspect Charged with 7 Counts of First-Degree Murder.??? ABC News, ABC News Network, 5 July 2022, https://abcnews.go.com/US/shooting-reported-4th-july-parade-chicago-suburb-highland/story?id=86186529. 
 <br />
 
Siegel, Michael. ???State-by-State Firearm Law Data.??? State Firearm Laws, Boston University , 2021, https://www.statefirearmlaws.org/. 
???Stats of the States - Firearm Mortality.??? Centers for Disease Control and Prevention, Centers for Disease Control and Prevention, 1 Mar. 2022, https://www.cdc.gov/nchs/pressroom/sosmap/firearm_mortality/firearm.htm. 
