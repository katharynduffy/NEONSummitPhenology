library(tidyverse)
library(lubridate)
library(neonUtilities)


##pull all available data for a site from the NEON API
sitesOfInterest <- c("HARV", "ONAQ", "OSBS", "DSNY", "ABBY")
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
head(pheDat$phe_perindividual)
head(pheDat$phe_perindividualperyear)
head(pheDat$phe_statusintensity)

#remove duplicate records
phe_statusintensity <- select(pheDat$phe_statusintensity, -uid)
phe_statusintensity <- distinct(phe_statusintensity)
table(phe_statusintensity$phenophaseName)
table(phe_statusintensity$phenophaseStatus)
str(phe_statusintensity)

#Format dates (native format is 'factor' silly R)
phe_statusintensity$date <- as.Date(phe_statusintensity$date, "%Y-%m-%d")
phe_statusintensity$editedDate <- as.Date(phe_statusintensity$editedDate, "%Y-%m-%d")
phe_statusintensity$year <- substr(phe_statusintensity$date, 1, 4)
phe_statusintensity$monthDay <- format(phe_statusintensity$date, format="%m-%d")

phe_statusintensity %>%
  group_by(individualID, date, phenophaseName) %>%
  summarise(n_edits = n_distinct(editedDate)) %>% 
  arrange(desc(n_edits))
filter(si_last, individualID == "NEON.PLA.D01.HARV.00082",
       date == "2017-04-28") %>% View()
si_last <- phe_statusintensity %>%
  group_by(individualID, date, phenophaseName) %>%
  filter(editedDate==max(as.Date(editedDate), na.rm = T))

### remove first year of data from each site ### Typically partial season
## optional ##
# si_last <- si_last %>%
#   group_by(siteID) %>%
#   filter(year!=min(year))

### add perindividual info (taxonID etc...)
phe_perindividual <- select(pheDat$phe_perindividual, individualID, growthForm, taxonID, scientificName)
phe_perindividual %>% select(-individualID) %>% distinct() 
# same species have different growth form
phe_perindividual$growthForm[phe_perindividual$taxonID == "PSMEM"] = "Evergreen conifer"
phe_perindividual$growthForm[phe_perindividual$taxonID == "COCOC"] = "Deciduous broadleaf"
phe_perindividual$growthForm[phe_perindividual$taxonID == "GASH"] = "Evergreen broadleaf"
phe_perindividual <- distinct(phe_perindividual)
phe_perindividual %>% select(-individualID) %>% distinct()
# why the same individual has multiple species IDs?? remove them?
any(duplicated(phe_perindividual$individualID))
filter(phe_perindividual, individualID %in% 
phe_perindividual[which(duplicated(phe_perindividual$individualID)), ]$individualID)
phe_perindividual = phe_perindividual[-which(duplicated(phe_perindividual$individualID)), ]


si_last <- left_join(ungroup(si_last), phe_perindividual, by = "individualID")
si_last = as_tibble(si_last)
saveRDS(si_last, "data_raw/neon_pheno.rds")

table(si_last$phenophaseName)
c("Breaking leaf buds", "Breaking needle buds")
c("Falling leaves")

onset_offset = filter(si_last, phenophaseName %in% 
                        c("Breaking leaf buds", "Breaking needle buds", "Falling leaves"),
                      phenophaseStatus == "yes") %>% 
  mutate(phenophaseName = gsub("leaf |needle ", "", phenophaseName))
table(onset_offset$phenophaseIntensity) 
write_csv(onset_offset, "data_raw/onset_offset_raw.csv")
onset_offset %>% 
  group_by(siteID, plotID, year, taxonID, phenophaseName) %>% 
  summarise(median_doy = median(dayOfYear, na.rm = T),
            mean_doy = mean(dayOfYear, na.rm = T),
            sd_doy = sd(dayOfYear, na.rm = T),
            min_doy = min(dayOfYear, na.rm = T), 
            max_doy = max(dayOfYear, na.rm = T)) %>% 
  write_csv("data_raw/onset_offset_summary.csv")
n_distinct(onset_offset$taxonID)

### use this to subset to any set of variables you may want to plot
df <- filter(
  si_last,
  siteID == 'ONAQ',
  #year=='2018'
  phenophaseStatus == 'yes',
  # taxonID %in% c('MEPO5', 'ACKO'),
  #& growthForm=='Deciduous broadleaf'
  phenophaseName %in% c("Falling leaves")
  #& phenophaseIntensity !=""
)
df <- distinct(df)

# reorganize levels to optimize plot - by placing 'leaves' first in order, this send this to the back of the plot. 
# otherwise, may layer in front of and obscure other phenophases.

df$phenophaseName <- factor(df$phenophaseName, levels = c("Leaves", "Colored leaves", "Falling leaves",   "Young leaves", "Young needles",  "Initial growth", "Increasing leaf size","Breaking leaf buds", "Breaking needle buds", "Open flowers", "Open pollen cones"))

table(df$phenophaseIntensity)
df$phenophaseIntensity <- factor(df$phenophaseIntensity, levels = c("< 5%", "5-24%", "25-49%", "50-74%", "75-94%", ">= 95%"))

ggplot(df, aes(x = dayOfYear)) +
  geom_boxplot() +
  # geom_histogram(binwidth = 5) +
  facet_grid(year ~ taxonID, scale = "free_y") 

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
  ggtitle("") +
  geom_histogram(binwidth = 5) +
  facet_wrap(~taxonID, scale="free_y") 
#ylim(0,500)+
#xlim(50, 350)