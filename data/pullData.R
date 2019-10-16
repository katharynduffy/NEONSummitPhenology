library(tidyverse)
library(neonUtilities)
library(data.table)
library(phenocamapi)
library(lubridate)
library(jpeg)
library(phenocamr)
library(XML)
library(RCurl)
library(rlist)


sites <- c("HARV", "OSBS", "CPER")

###  flux data ###
## from tutorial https://www.neonscience.org/eddy-data-intro

zipsByProduct(dpID="DP4.00200.001", package="basic", 
              site=sites, 
              startdate="2018-06", enddate="2018-07",
              savepath="neonsummit/data", 
              check.size=F)

flux_dpid <- "DP4.00200.001"
flux <- stackEddy(filepath=paste0(getwd(), "/neonsummit/data/filesToStack00200"),
                  level="dp04")


### in situ phenology ###
phe_dpid <- 'DP1.10055.001'
zipsByProduct(dpID='DP1.10055.001', package ="basic", 
              site=sites, 
              savepath="neonsummit/data", 
              check.size = F)

stackByTable(phe_dpid, filepath=paste0(getwd(), "neonsummit/data/filesToStack10055"), 
             savepath = paste0(getwd(), "/filesToStack10055"), folder=T)  



### phenocam data ###
ls("package:phenocamr")

#get list of sites 
theurl <- getURL("https://phenocam.sr.unh.edu/webcam/network/table/",.opts = list(ssl.verifypeer = FALSE) )
cameraList <- readHTMLTable(theurl, which = 1, stringsAsFactors=FALSE)
neonCamera <- filter(cameraList, grepl('NEON', Camera))
neonCamera <- neonCamera[substr(neonCamera$Camera, 10, 13)%in%sites,]

phenos <- get_phenos()

landWater <- 'DP1.20002'
understory <- 'DP1.00042'
canopy <- 'DP1.00033'

neonCamera$dp <- ifelse(grepl('DP1.00033', neonCamera$Camera), "canopy", 
                        ifelse(grepl('DP1.00042', neonCamera$Camera), "understory",
                               ifelse(grepl('DP1.20002', neonCamera$Camera), "landWater", NA)))



listUpper <- unique(neonCamera$Camera[grepl('DP1.00033', neonCamera$Camera)])

getwd()
list.files(getwd())
rois <- get_rois()


cam_df <- data.frame()
for (i in 1:length(neonCamera$Camera[neonCamera$dp=="understory"])){
  temp_cam <- neonCamera$Camera[neonCamera$dp=="understory"][i]
  download_phenocam(temp_cam, 
                               frequency=1)
  temp_df <- read_phenocam(file.path(tempdir(), paste(temp_cam, "_UN_")
  cam_df <- rbind(cam_df, temp_df)
  df <- read_phenocam(file.path(tempdir(),"NEON.D01.HARV.DP1.00033_DB_1000_1day.csv"))
  
  rm(temp_cam)
  rm(temp_df)
}

# download_phenocam(site = "NEON.D01.HARV.DP1.00033",
#                   frequency = 1)

list.files(tempdir())
df <- read_phenocam(file.path(tempdir(),"NEON.D01.HARV.DP1.00033_DB_1000_1day.csv"))


