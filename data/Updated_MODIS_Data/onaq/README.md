# AppEEARS Point Sample Extraction Readme  

## Table of Contents  

1. Request Parameters  
2. Request File Listing  
3. Point Sample Extraction Process  
4. Data Quality  
    4.1. Moderate Resolution Imaging Spectroradiometer (MODIS)  
    4.2. NASA MEaSUREs Shuttle Radar Topography Mission (SRTM) Version 3 (v3)  
    4.3. Gridded Population of the World (GPW) Version 4 (v4)  
    4.4. Suomi National Polar-orbiting Partnership (S-NPP) NASA Visible Infrared Imaging Radiometer Suite (VIIRS)  
    4.5. Soil Moisture Active Passive (SMAP)  
    4.6. MODIS Simplified Surface Energy Balance (SSEBop) Actual Evapotranspiration (ETa)  
    4.7. eMODIS Smoothed Normalized Difference Vegetation Index (NDVI)  
    4.8. Daymet  
    4.9. U.S. Landsat Analysis Ready Data (ARD)  
    4.10. Ecosystem Spaceborne Thermal Radiometer Experiment on Space Station (ECOSTRESS)  
    4.11. Advanced Spaceborne Thermal Emission and Reflection Radiometer (ASTER) Global Digital Elevation Model (GDEM) Version 3 (v3) and Global Water Bodies Database (WBD) Version 1 (v1)  
    4.12. NASA MEaSUREs NASA Digital Elevation Model (DEM) Version 1 (v1)  
5. Data Caveats  
6. Documentation  
7. Sample Request Retention  
8. Data Product Citations  
9. Software Citation  
10. Feedback  

## 1. Request Parameters  

    Name: ONAQ  

    Date Completed:** 2020-09-10T23:44:25.883499  

    Id: 5d4bcd40-c89d-4bfe-9e66-766d55cd51c7  

    Details:  

        Start Date: 01-01-2012  

        End Date: 09-01-2020
    
        Layers:  

            _250m_16_days_NDVI (MOD13Q1.006)  
            _250m_16_days_VI_Quality (MOD13Q1.006)  
            _250m_16_days_NDVI (MYD13Q1.006)  
            _250m_16_days_VI_Quality (MYD13Q1.006)  
            band_1 (eMODIS_Smoothed_NDVI.001)  
    
        Coordinates:  

            4343, NEON.D15.ONAQ.DP1.00033, 40.1800068151579, -112.455133434405  
            4344, NEON.D15.ONAQ.DP1.00033, 40.1800068151579, -112.453052429932  
            4345, NEON.D15.ONAQ.DP1.00033, 40.1800068151579, -112.450971425459  
            4445, NEON.D15.ONAQ.DP1.00033, 40.1784168649682, -112.450971425459  
            4444, NEON.D15.ONAQ.DP1.00033, 40.1784168649682, -112.453052429932  
            4443, NEON.D15.ONAQ.DP1.00033, 40.1784168649682, -112.455133434405  
            4543, NEON.D15.ONAQ.DP1.00033, 40.1768268775211, -112.455133434405  
            4544, NEON.D15.ONAQ.DP1.00033, 40.1768268775211, -112.453052429932  
            4545, NEON.D15.ONAQ.DP1.00033, 40.1768268775211, -112.450971425459  
    
    Version: This request was processed by AppEEARS version 2.45  

## 2. Request File Listing  

- Comma-separated values file with data extracted for a specific product
  - ONAQ-MOD13Q1-006-results.csv
- Comma-separated values file with data extracted for a specific product
  - ONAQ-MYD13Q1-006-results.csv
- Comma-separated values file with data extracted for a specific product
  - ONAQ-eMODIS-Smoothed-NDVI-001-results.csv
- Text file with data pool URLs for all source granules used in the extraction
  - ONAQ-granule-list.txt
- JSON request file which can be used in AppEEARS to create a new request
  - ONAQ-request.json
- xml file
  - ONAQ-MOD13Q1-006-metadata.xml
- xml file
  - ONAQ-MYD13Q1-006-metadata.xml
- xml file
  - ONAQ-eMODIS-Smoothed-NDVI-001-metadata.xml  

## 3. Point Sample Extraction Process  

Datasets available in AppEEARS are served via OPeNDAP (Open-source Project for a Network Data Access Protocol) services. OPeNDAP services allow users to concisely pull pixel values from datasets via HTTPS requests. A middleware layer has been developed to interact with the OPeNDAP services. The middleware make it possible to extract scaled data values, with associated information, for pixels corresponding to a given coordinate and date range.

**NOTE:**  

- Requested date ranges may not match the reference date for multi-day products. AppEEARS takes an inclusive approach when extracting data for sample requests, often returning data that extends beyond the requested date range. This approach ensures that the returned data includes records for the entire requested date range.  
- For multi-day (8-day, 16-day, Monthly, Yearly) MODIS and S-NPP NASA VIIRS datasets, the date field in the data tables reflects the first day of the composite period.  
- If selected, the SRTM v3, ASTER GDEM v3 and Global Water Bodies Database v1, and NASADEM v1 product will be extracted regardless of the time period specified in AppEEARS because it is a static dataset. The date field in the data tables reflects the nominal SRTM date of February 11, 2000.  
- If the visualizations indicate that there are no data to display, proceed to downloading the .csv output file. Data products that have both categorical and continuous data values (e.g. MOD15A2H) are not able to be displayed within the visualizations within AppEEARS.  

## 4. Data Quality  

When available, AppEEARS extracts and returns quality assurance (QA) data for each data file returned regardless of whether the user requests it. This is done to ensure that the user possesses the information needed to determine the usability and usefulness of the data they get from AppEEARS. Most data products available through AppEEARS have an associated QA data layer. Some products have more than one QA data layer to consult. See below for more information regarding data collections/products and their associated QA data layers.  

### 4.1. MODIS (Terra, Aqua, & Combined)

All MODIS land products, as well as the MODIS Snow Cover Daily product, include quality assurance (QA) information designed to help users understand and make best use of the data that comprise each product. Results downloaded from AppEEARS and/or data directly requested via middleware services contain not only the requested pixel/data values but also the decoded QA information associated with each pixel/data value extracted.  

- See the MODIS Land Products QA Tutorials: <https://lpdaac.usgs.gov/resources/e-learning/> for more QA information regarding each MODIS land product suite.  
- See the MODIS Snow Cover Daily product user guide for information regarding QA utilization and interpretation.  

### 4.2. NASA MEaSUREs SRTM v3 (30m & 90m)  

SRTM v3 products are accompanied by an ancillary "NUM" file in place of the QA/QC files. The "NUM" files indicate the source of each SRTM pixel, as well as the number of input data scenes used to generate the SRTM v3 data for that pixel.  

- See the user guide: <https://lpdaac.usgs.gov/documents/179/SRTM_User_Guide_V3.pdf> for additional information regarding the SRTM "NUM" file.  

### 4.3. GPW v4  

The GPW Population Count and Population Density data layers are accompanied by two Data Quality Indicators datasets. The Data Quality Indicators were created to provide context for the population count and density grids, and to provide explicit information on the spatial precision of the input boundary data. The data context grid (data-context1) explains pixels with "0" population estimate in the population count and density grids, based on information included in the census documents. The mean administrative unit area grid (mean-admin-area2) measures the mean input unit size in square kilometers. It provides a quantitative surface that indicates the size of the input unit(s) from which the population count and density grids were created.  

### 4.4. S-NPP NASA VIIRS

All S-NPP NASA VIIRS land products include quality information designed to help users understand and make best use of the data that comprise each product. For product-specific information, see the link to the S-NPP VIIRS products table provided in section 5.  

**NOTE:**  

- The S-NPP NASA VIIRS Surface Reflectance data products VNP09A1 and VNP09H1 contain two quality layers: `SurfReflect_State` and `SurfReflect_QC`. Both quality layers are provided to the user with the request results. Due to changes implemented on August 21, 2017 for forward processed data, there are differences in values for the `SurfReflect_QC` layer in VNP09A1 and `SurfReflect_QC_500` in VNP09H1.  
- Refer to the S-NPP NASA VIIRS Surface Reflectance User's Guide Version 1.1: <https://lpdaac.usgs.gov/documents/123/VNP09_User_Guide_V1.1.pdf> for information on how to decode the `SurfReflect_QC` quality layer for data processed before August 21, 2017. For data processed on or after August 21, 2017, refer to the S-NPP NASA VIIRS Surface Reflectance User's guide Version 1.6: <https://lpdaac.usgs.gov/documents/124/VNP09_User_Guide_V1.6.pdf>  

### 4.5. SMAP  

SMAP products provide multiple means to assess quality. Each data product contains bit flags, uncertainty measures, and file-level metadata that provide quality information. Results downloaded from AppEEARS and/or data directly requested via middleware services contain not only the requested pixel/data values, but also the decoded bit flag information associated with each pixel/data value extracted. For additional information regarding the specific bit flags, uncertainty measures, and file-level metadata contained in this product, refer to the Quality Assessment section of the user guide for the specific SMAP data product in your request: <https://nsidc.org/data/smap/smap-data.html>  

### 4.6. SSEBop Actual Evapotranspiration (ETa)  

The SSEBop evapotranspiration monthly product does not have associated quality indicators or data layers. The data are considered to satisfy the quality standards relative to the purpose for which the data were collected.

### 4.7. eMODIS Smoothed Normalized Difference Vegetation Index (NDVI)  

The smoothed eMODIS NDVI product does not have associated quality indicators or data layers. The data are considered to satisfy the quality standards relative to the purpose for which the data were collected.  

### 4.8. Daymet  

Daymet station-level daily weather observation data and the corresponding Daymet model predicted data for three Daymet model parameters: minimum temperature (tmin), maximum temperature (tmax), and daily total precipitation (prcp) are available. These data provide information into the regional accuracy of the Daymet model for the three station-level input parameters. Corresponding comma separated value (.csv) files that contain metadata for every surface weather station for the variable-year combinations are also available. <https://daac.ornl.gov/cgi-bin/dsviewer.pl?ds_id=1391>  

### 4.9. U.S. Landsat ARD  

Quality assessment bands for the U.S. Landsat ARD data products are produced from Level 1 inputs with additional calculations derived from higher-level processing. A pixel quality assessment band describing the general state of each pixel is supplied with each AppEEARS request. In addition to the pixel quality assessment band, Landsat ARD data products also have additional bands that can be used to evaluate the usability and usefulness of the data. These include bands that characterize radiometric saturation, as well as parameters specific to atmospheric correction. Refer to the U.S. Landsat ARD Data Format Control Book (DFCB): <https://www.usgs.gov/media/files/landsat-analysis-ready-data-ard-data-format-control-book-dfcb> for a full description of the quality assessment bands for each product (L4-L8) as well as guidance on interpreting each band’s bit-packed data values.

### 4.10. ECOSTRESS  

Quality information varies by product for the ECOSTRESS product suite. Quality information for ECO2LSTE.001, including the bit definition index for the quality layer, is provided in section 2.4 of the User Guide: <https://lpdaac.usgs.gov/documents/423/ECO2_User_Guide_V1.pdf>. Results downloaded from AppEEARS contain the requested pixel/data values and also the decoded QA information associated with each pixel/data value extracted. No quality flags are produced for the ECO3ETPTJPL.001, ECO4WUE.001, or ECO4ESIPTJPL.001 products. Instead, the quality flags of the source data are available in the ECO3ANCQA.001 data product and a cloud mask is available in the ECO2CLD.001 product. The `ETinst` layer in the ECO3ETPTJPL.001 product does include an associated uncertainty layer that is provided with each request for ‘ETinst’ in AppEEARS. Each radiance layer in the ECO1BMAPRAD.001 product has a linked quality layer (Data Quality Indicators). ECO2CLD.001 and ECO3ANCQA.001 are separate quality products that are also available for download in AppEEARS.  

### 4.11. ASTER GDEM v3 and Global Water Bodies Database v1  

ASTER GDEM v3 data are accompanied by an ancillary "NUM" file in place of the QA/QC files. The "NUM" files refer to the count of ASTER Level-1A scenes that were processed for each pixel or the source of reference data used to replace anomalies. The ASTER Global Water Bodies Database v1 products do not contain QA/QC files.  

- See Section 7 of the ASTER GDEM user guide: <https://lpdaac.usgs.gov/documents/434/ASTGTM_User_Guide_V3.pdf> for additional information regarding the GDEM "NUM" file.  
- See Section 7 of the ASTER Global Water Bodies Database user guide: <https://lpdaac.usgs.gov/documents/436/ASTWBD_User_Guide_V1.pdf> for a comparison with the SRTM Water Body Dataset.  

### 4.12. NASA MEaSUREs NASADEM v1 (30m)  

NASADEM v1 products are accompanied by an ancillary "NUM" file in place of the QA/QC files. The "NUM" files indicate the source of each NASADEM pixel, as well as the number of input data scenes used to generate the NASADEM v1 data for that pixel.  

- See the NASADEM user guide: <https://lpdaac.usgs.gov/documents/592/NASADEM_User_Guide_V1.pdf> for additional information regarding the NASADEM "NUM" file.  

## 5. Data Caveats  

### 5.1. SSEBop Actual Evapotranspiration (ETa)  

- A list of granule files is not provided for the SSEBop ETa data product. The source data for this product can be obtained by using the download interface at: <https://earlywarning.usgs.gov/fews/datadownloads/Continental%20Africa/Monthly%20ET%20Anomaly>.  

### 5.2. eMODIS Smoothed Normalized Difference Vegetation Index (NDVI)  

- The raw data values within the smoothed eMODIS NDVI product represent scaled byte data with values between 0 and 200. To convert the scaled raw data to smoothed NDVI (smNDVI) data values, the user must apply the following conversion equation:  

      smNDVI = (0.01 * Raw_Data_Value) - 1

- A list of granule files is not provided for the SSEBop ETa data product. The source data for this product can be obtained by using the download interface at: <https://phenology.cr.usgs.gov/get_data_smNDVI.php>.  

### 5.3. ECOSTRESS  

- ECOSTRESS data products are natively stored in swath format. To fulfill AppEEARS requests for ECOSTRESS products, the data are first from the native swath format to a georeferenced output. This requires the use of the requested ECOSTRESS product files and the corresponding ECO1BGEO: <https://doi.org/10.5067/ECOSTRESS/ECO1BGEO.001> files for all products except for ECO1BMAPRAD.001. ECO1BMAPRAD.001 contains latitude and longitude arrays within each file that are then used in the resampling process.  
The conversion leverages the pyresample package’s: <https://pyresample.readthedocs.io/en/stable/> kd_tree algorithm: <https://pyresample.readthedocs.io/en/latest/swath.html#pyresample-kd-tree> using nearest neighbor resampling. The conversion resamples to a Geographic (lat/lon) coordinate reference system (EPSG: 4326), which is defined as the ‘native projection’ option for ECOSTRESS products in AppEEARS.  

## 6. Documentation  

Documentation for data products available through AppEEARS are listed below.

### 6.1. MODIS Land Products(Terra, Aqua, & Combined)  

- <https://lpdaac.usgs.gov/product_search/?collections=Combined+MODIS&collections=Terra+MODIS&collections=Aqua+MODIS&view=list>

### 6.2. MODIS Snow Products (Terra and Aqua)  

- <https://nsidc.org/data/modis/data_summaries>

### 6.3. NASA MEaSUREs SRTM v3

- <https://lpdaac.usgs.gov/product_search/?collections=MEaSUREs+SRTM&view=list>

### 6.4. GPW v4  

- <http://sedac.ciesin.columbia.edu/binaries/web/sedac/collections/gpw-v4/gpw-v4-documentation.pdf>

### 6.5. S-NPP NASA VIIRS Land Products  

- <https://lpdaac.usgs.gov/product_search/?collections=S-NPP+VIIRS&view=list>

### 6.6. SMAP Products  

- <http://nsidc.org/data/smap/smap-data.html>

### 6.7. SSEBop Actual Evapotranspiration (ETa)  

- <https://earlywarning.usgs.gov/fews/product/66#documentation>

### 6.8. eMODIS Smoothed Normalized Difference Vegetation Index (NDVI)  

- <https://phenology.cr.usgs.gov/get_data_smNDVI.php>

### 6.9. Daymet  

- <https://daac.ornl.gov/cgi-bin/dsviewer.pl?ds_id=1328>
- <https://daymet.ornl.gov/>

### 6.10. U.S. Landsat ARD  

- <https://www.usgs.gov/land-resources/nli/landsat/us-landsat-analysis-ready-data?qt-science_support_page_related_con=0#qt-science_support_page_related_con>

### 6.11. ECOSTRESS  

- <https://lpdaac.usgs.gov/product_search/?collections=ECOSTRESS&view=list>

### 6.12. ASTER GDEM v3 and Global Water Bodies Database v1  

- <https://doi.org/10.5067/ASTER/ASTGTM.003>
- <https://doi.org/10.5067/ASTER/ASTWBD.001>

### 6.13. NASADEM  

- <https://doi.org/10.5067/MEaSUREs/NASADEM/NASADEM_NC.001>  
- <https://doi.org/10.5067/MEaSUREs/NASADEM/NASADEM_NUMNC.001>

## 7. Sample Request Retention  

AppEEARS sample request outputs are available to download for a limited amount of time after completion. Please visit <https://lpdaacsvc.cr.usgs.gov/appeears/help?section=sample-retention> for details.  

## 8. Data Product Citations  

- Didan, K. (2015). MOD13Q1 MODIS/Terra Vegetation Indices 16-Day L3 Global 250m SIN Grid V006. NASA EOSDIS Land Processes DAAC. Accessed 2020-09-10 from https://doi.org/10.5067/MODIS/MOD13Q1.006. Accessed September 10, 2020.
- Didan, K. (2015). MYD13Q1 MODIS/Aqua Vegetation Indices 16-Day L3 Global 250m SIN Grid V006. NASA EOSDIS Land Processes DAAC. Accessed 2020-09-10 from https://doi.org/10.5067/MODIS/MYD13Q1.006. Accessed September 10, 2020.

## 9. Software Citation  

AppEEARS Team. (2020). Application for Extracting and Exploring Analysis Ready Samples (AppEEARS). Ver. 2.45. NASA EOSDIS Land Processes Distributed Active Archive Center (LP DAAC), USGS/Earth Resources Observation and Science (EROS) Center, Sioux Falls, South Dakota, USA. Accessed September 10, 2020. https://lpdaacsvc.cr.usgs.gov/appeears

## 10. Feedback  

We value your opinion. Please help us identify what works, what doesn't, and anything we can do to make AppEEARS better by submitting your feedback at https://lpdaacsvc.cr.usgs.gov/appeears/feedback or to LP DAAC User Services at <https://lpdaac.usgs.gov/lpdaac-contact-us/>  
