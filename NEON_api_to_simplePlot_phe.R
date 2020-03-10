
library(tidyverse)
library(dplyr, quietly=T)
library(lubridate)


##pull all available data for a site from the NEON API

library(neonUtilities)
sitesOfInterest <- c("HARV", "ONAQ", "OSBS", "DSNY", "ABBY")
## 
dpid <- as.character('DP1.10055.001') #phe data
 
pheDat <- loadByProduct(dpID="DP1.10055.001",
                     site = sitesOfInterest,
                     package = "basic",
                     check.size = FALSE)

# unlist all data frames
list2env(pheDat ,.GlobalEnv)

## unlist dataframes individually
# perind <- pheDat$phe_perindividual
# stint <- pheDat$phe_statusintensity 
# annual <- pheDat$phe_perindividualperyear


#remove duplicate records
phe_statusintensity <- select(phe_statusintensity, -uid)
phe_statusintensity <- distinct(phe_statusintensity)

#Format dates (native format is 'factor' silly R)
phe_statusintensity$date <- as.Date(phe_statusintensity$date, "%Y-%m-%d")
phe_statusintensity$editedDate <- as.Date(phe_statusintensity$editedDate, "%Y-%m-%d")
phe_statusintensity$year <- substr(phe_statusintensity$date, 1, 4)
phe_statusintensity$monthDay <- format(phe_statusintensity$date, format="%m-%d")


si_last <- phe_statusintensity %>%
  group_by(individualID, date, phenophaseName) %>%
  filter(editedDate==max(as.Date(editedDate)))

### remove first year of data from each site ### Typically partial season
## optional ##
# si_last <- si_last %>%
#   group_by(siteID) %>%
#   filter(year!=min(year))

### add perindividual info (taxonID etc...)
phe_perindividual <- select(phe_perindividual, individualID, growthForm, taxonID, editedDate)
phe_perindividual <- distinct(phe_perindividual)

ind_last <- phe_perindividual %>%
  group_by(individualID) 

ind_last <- select(ind_last, -editedDate)

si_last <- left_join(si_last, ind_last)


### use this to subset to any set of variables you may want to plot
df <- filter(si_last, 
             siteID=='PUUM'
             #year=='2018'
             & phenophaseStatus=='yes'
             & taxonID%in%c('MEPO5', 'ACKO')
             #& growthForm=='Deciduous broadleaf'
             & phenophaseName%in%c('Open flowers')
             #& phenophaseIntensity !=""
)
df <- distinct(df)

# reorganize levels to optimize plot - by placing 'leaves' first in order, this send this to the back of the plot. 
# otherwise, may layer in front of and obscure other phenophases.

df$phenophaseName <- factor(df$phenophaseName, levels = c("Leaves", "Colored leaves", "Falling leaves",   "Young leaves", "Young needles",  "Initial growth", "Increasing leaf size","Breaking leaf buds", "Breaking needle buds", "Open flowers", "Open pollen cones"))

df$phenophaseIntensity <- factor(df$phenophaseIntensity, levels = c("NA", ">= 95%", "< 5%", "5-24%", "25-49%", "50-74%", "75-94%", NA))

### density plot  - layered curves
ggplot(df, aes(x=date, y = stat(count), color=phenophaseIntensity)) +
  #ggplot(df, aes(x=dayOfYear, ..count.., fill=phenophaseIntensity, color=phenophaseIntensity)) +  
  #geom_density(position="stack")+  # stacks data vertically
  #geom_density(alpha=0.8)+  # sensitivity of the curves
  #ggtitle("Leaves and Increasing Leaf Size status - D03")+
  geom_density()+  
  facet_wrap(~taxonID, scale="free_y")+ # places taxonID in separate windows
  xlim(min(df$date)-15, max(df$date)+15) # x-axis scales by date

## histogram
ggplot(df, aes(x=date, fill=phenophaseIntensity)) +
  ggtitle("")+
  geom_histogram(binwidth = 5) 
  facet_wrap(~taxonID, scale="free_y") 
#ylim(0,500)+
#xlim(50, 350)
