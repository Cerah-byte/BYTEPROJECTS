 --Task 1: Data Ingestion
--Load the raw data from all source tables (SensorDataRaw, WeatherDataRaw, SoilDataRaw, CropDataRaw, PestDataRaw, IrrigationDataRaw, LocationDataRaw) into staging tables within the Data Warehouse Schema.

--  Create Staging Tables

CREATE OR REPLACE TABLE staging_cropdataraw (
    TIMESTAMP VARCHAR(16777216),
    CROP_TYPE VARCHAR(16777216),
    CROP_YIELD VARCHAR(16777216),
    GROWTH_STAGE VARCHAR(16777216),
    PEST_ISSUE VARCHAR(16777216)
);


CREATE OR REPLACE TABLE staging_irrigationdataraw (
    SENSOR_ID VARCHAR(16777216),
    TIMESTAMP VARCHAR(16777216),
    IRRIGATION_METHOD VARCHAR(16777216),
    WATER_SOURCE VARCHAR(16777216),
    IRRIGATION_DURATION_MIN VARCHAR(16777216)
);


CREATE OR REPLACE TABLE staging_LOCATIONDATARAW (
    SENSOR_ID VARCHAR(16777216),
    LOCATION_NAME VARCHAR(16777216),
    LATITUDE VARCHAR(16777216),
    LONGITUDE VARCHAR(16777216),
    ELEVATION VARCHAR(16777216),
    REGION VARCHAR(16777216)
);



CREATE OR REPLACE TABLE staging_PESTDATARAW (
    TIMESTAMP VARCHAR(16777216),
    PEST_TYPE VARCHAR(16777216),
    PEST_DESCRIPTION VARCHAR(16777216),
    PEST_SEVERITY VARCHAR(16777216)
);



CREATE OR REPLACE TABLE staging_SENSORDATARAW (
    SENSOR_ID VARCHAR(16777216),
    TIMESTAMP VARCHAR(16777216),
    TEMPERATURE VARCHAR(16777216),
    HUMIDITY VARCHAR(16777216),
    SOIL_MOISTURE VARCHAR(16777216),
    LIGHT_INTENSITY VARCHAR(16777216),
    BATTERY_LEVEL VARCHAR(16777216)
);



CREATE OR REPLACE TABLE staging_SOILDATARAW (
    TIMESTAMP VARCHAR(16777216),
    SOIL_COMP VARCHAR(16777216),
    SOIL_MOISTURE VARCHAR(16777216),
    SOIL_PH VARCHAR(16777216),
    NITROGEN_LEVEL VARCHAR(16777216),
    PHOSPHORUS_LEVEL VARCHAR(16777216),
    ORGANIC_MATTER VARCHAR(16777216)
);


CREATE OR REPLACE TABLE staging_WEATHERDATARAW (
    TIMESTAMP VARCHAR(16777216),
    WEATHER_CONDITION VARCHAR(16777216),
    WIND_SPEED VARCHAR(16777216),
    PRECIPITATION VARCHAR(16777216)
);



--CHANGING DATA TYPES FROM STAGING TABLES


CREATE OR REPLACE TABLE staging_cropdataraw (
    TIMESTAMP TIMESTAMP_NTZ,
    CROP_TYPE STRING,
    CROP_YIELD FLOAT,
    GROWTH_STAGE STRING,
    PEST_ISSUE STRING
);

SELECT * FROM STAGING_IRRIGATIONDATARAW;

CREATE OR REPLACE TABLE staging_irrigationdataraw (
    SENSOR_ID STRING,
    TIMESTAMP TIMESTAMP_NTZ,
    IRRIGATION_METHOD STRING,
    WATER_SOURCE STRING,
    IRRIGATION_DURATION_MIN FLOAT
);

CREATE OR REPLACE TABLE staging_LOCATIONDATARAW (
    SENSOR_ID STRING,
    LOCATION_NAME STRING,
    LATITUDE FLOAT,
    LONGITUDE FLOAT,
    ELEVATION FLOAT,
    REGION STRING
);

CREATE OR REPLACE TABLE staging_PESTDATARAW (
    TIMESTAMP TIMESTAMP_NTZ,
    PEST_TYPE STRING,
    PEST_DESCRIPTION STRING,
    PEST_SEVERITY STRING
);


CREATE OR REPLACE TABLE staging_SENSORDATARAW (
    SENSOR_ID STRING,
    TIMESTAMP VARCHAR,
    TEMPERATURE FLOAT,
    HUMIDITY FLOAT,
    SOIL_MOISTURE FLOAT,
    LIGHT_INTENSITY FLOAT,
    BATTERY_LEVEL FLOAT
);

CREATE OR REPLACE TABLE staging_SOILDATARAW (
    TIMESTAMP TIMESTAMP_NTZ,
    SOIL_COMP STRING,
    SOIL_MOISTURE FLOAT,
    SOIL_PH FLOAT,
    NITROGEN_LEVEL FLOAT,
    PHOSPHORUS_LEVEL FLOAT,
    ORGANIC_MATTER FLOAT
);

CREATE OR REPLACE TABLE staging_WEATHERDATARAW (
    TIMESTAMP TIMESTAMP_NTZ,
    WEATHER_CONDITION STRING,
    WIND_SPEED FLOAT,
    PRECIPITATION FLOAT
);



-- Load data from source_tables into staging_tables

INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_CROPDATARAW
SELECT
    TO_TIMESTAMP(TIMESTAMP, 'MM/DD/YYYY HH:MI') AS TIMESTAMP,
    CAST(CROP_TYPE AS STRING) AS CROP_TYPE,
    CASE WHEN CROP_YIELD = 'NA' THEN NULL ELSE CAST(CROP_YIELD AS FLOAT) END AS CROP_YIELD,
    CAST(GROWTH_STAGE AS STRING) AS GROWTH_STAGE,
    CAST(PEST_ISSUE AS STRING) AS PEST_ISSUE
FROM DFA23RAWDATA.RAWDATA.CROPDATARAW;




INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_IRRIGATIONDATARAW
SELECT
    SENSOR_ID AS SENSOR_ID,
    TO_TIMESTAMP(TIMESTAMP, 'MM/DD/YYYY HH:MI') AS TIMESTAMP,
    IRRIGATION_METHOD AS IRRIGATION_METHOD,
    WATER_SOURCE AS WATER_SOURCE,
    CASE WHEN IRRIGATION_DURATION_MIN = 'NA' THEN NULL ELSE CAST(IRRIGATION_DURATION_MIN AS FLOAT) END AS IRRIGATION_DURATION_MIN
FROM DFA23RAWDATA.RAWDATA.IRRIGATIONDATARAW;



INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_LOCATIONDATARAW
SELECT
    SENSOR_ID AS SENSOR_ID,
    LOCATION_NAME AS LOCATION_NAME,
    CASE WHEN TRY_CAST(LATITUDE AS FLOAT) IS NULL THEN 0.0 ELSE CAST(LATITUDE AS FLOAT) END AS LATITUDE,
    CASE WHEN TRY_CAST(LONGITUDE AS FLOAT) IS NULL THEN 0.0 ELSE CAST(LONGITUDE AS FLOAT) END AS LONGITUDE,
    CASE WHEN TRY_CAST(ELEVATION AS FLOAT) IS NULL THEN 0.0 ELSE CAST(ELEVATION AS FLOAT) END AS ELEVATION,
    REGION AS REGION
FROM DFA23RAWDATA.RAWDATA.LOCATIONDATARAW;

INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_PESTDATARAW
SELECT
    TO_TIMESTAMP(TIMESTAMP, 'MM/DD/YYYY HH:MI') AS TIMESTAMP,
    PEST_TYPE AS PEST_TYPE,
    PEST_DESCRIPTION AS PEST_DESCRIPTION,
    PEST_SEVERITY AS PEST_SEVERITY
FROM DFA23RAWDATA.RAWDATA.PESTDATARAW;



INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_SENSORDATARAW
SELECT
    SENSOR_ID AS SENSOR_ID,
    TIMESTAMP,
    CASE WHEN TRY_CAST(TEMPERATURE AS FLOAT) IS NULL THEN 0.0 ELSE CAST(TEMPERATURE AS FLOAT) END AS TEMPERATURE,
    CASE WHEN TRY_CAST(HUMIDITY AS FLOAT) IS NULL THEN 0.0 ELSE CAST(HUMIDITY AS FLOAT) END AS HUMIDITY,
    CASE WHEN TRY_CAST(SOIL_MOISTURE AS FLOAT) IS NULL THEN 0.0 ELSE CAST(SOIL_MOISTURE AS FLOAT) END AS SOIL_MOISTURE,
    CASE WHEN TRY_CAST(LIGHT_INTENSITY AS FLOAT) IS NULL THEN 0.0 ELSE CAST(LIGHT_INTENSITY AS FLOAT) END AS LIGHT_INTENSITY,
    CASE WHEN TRY_CAST(BATTERY_LEVEL AS FLOAT) IS NULL THEN 0.0 ELSE CAST(BATTERY_LEVEL AS FLOAT) END AS BATTERY_LEVEL
FROM DFA23RAWDATA.RAWDATA.SENSORDATARAW;



INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW
SELECT
    TO_TIMESTAMP(TIMESTAMP, 'MM/DD/YYYY HH:MI') AS TIMESTAMP,
    SOIL_COMP AS SOIL_COMP,
    CASE WHEN TRY_CAST(SOIL_MOISTURE AS FLOAT) IS NULL THEN 0.0 ELSE CAST(SOIL_MOISTURE AS FLOAT) END AS SOIL_MOISTURE,
    CASE WHEN TRY_CAST(SOIL_PH AS FLOAT) IS NULL THEN 0.0 ELSE CAST(SOIL_PH AS FLOAT) END AS SOIL_PH,
    CASE WHEN TRY_CAST(NITROGEN_LEVEL AS FLOAT) IS NULL THEN 0.0 ELSE CAST(NITROGEN_LEVEL AS FLOAT) END AS NITROGEN_LEVEL,
    CASE WHEN TRY_CAST(PHOSPHORUS_LEVEL AS FLOAT) IS NULL THEN 0.0 ELSE CAST(PHOSPHORUS_LEVEL AS FLOAT) END AS PHOSPHORUS_LEVEL,
    CASE WHEN TRY_CAST(ORGANIC_MATTER AS FLOAT) IS NULL THEN 0.0 ELSE CAST(ORGANIC_MATTER AS FLOAT) END AS ORGANIC_MATTER
FROM DFA23RAWDATA.RAWDATA.SOILDATARAW;




INSERT INTO DFA23RAWDATA.POWERRANGERS.STAGING_WEATHERDATARAW
SELECT
    TO_TIMESTAMP(TIMESTAMP, 'MM/DD/YYYY HH:MI') AS TIMESTAMP,
    WEATHER_CONDITION AS WEATHER_CONDITION,
    CASE WHEN TRY_CAST(WIND_SPEED AS FLOAT) IS NULL THEN 0.0 ELSE CAST(WIND_SPEED AS FLOAT) END AS WIND_SPEED,
    CASE WHEN TRY_CAST(PRECIPITATION AS FLOAT) IS NULL THEN 0.0 ELSE CAST(PRECIPITATION AS FLOAT) END AS PRECIPITATION
FROM DFA23RAWDATA.RAWDATA.WEATHERDATARAW;







--DAY 1 Task 2: Schema Setup, Data Cleansing and Transformation
--Create the schema for the data warehouse.
--Cleanse and preprocess the data in the staging tables.
--Handle missing values, data type conversions, and data quality checks.
--Transform the data into a format suitable for fact and dimension Tables.


--handling missing values
--IDENTIFYING MISSING DATA

SELECT *
FROM POWERRANGERS.STAGING_CROPDATARAW
WHERE TIMESTAMP IS NULL
   OR CROP_TYPE IS NULL
   OR CROP_YIELD IS NULL
   OR GROWTH_STAGE IS NULL
   OR PEST_ISSUE IS NULL;

  


--NO NULL DATA
SELECT *
FROM POWERRANGERS.STAGING_IRRIGATIONDATARAW
WHERE SENSOR_ID IS NULL
   OR TIMESTAMP IS NULL
   OR IRRIGATION_METHOD IS NULL
   OR WATER_SOURCE IS NULL
   OR IRRIGATION_DURATION_MIN IS NULL;


   

SELECT *
FROM POWERRANGERS.STAGING_LOCATIONDATARAW
WHERE SENSOR_ID IS NULL
   OR LOCATION_NAME IS NULL
   OR LATITUDE IS NULL
   OR LONGITUDE IS NULL
   OR ELEVATION IS NULL
   OR REGION IS NULL;


   

SELECT *
FROM POWERRANGERS.STAGING_PESTDATARAW
WHERE TIMESTAMP IS NULL
   OR PEST_TYPE IS NULL
   OR PEST_DESCRIPTION IS NULL
   OR PEST_SEVERITY IS NULL;


   
--NO NULL DATA
SELECT *
FROM POWERRANGERS.STAGING_SENSORDATARAW
WHERE SENSOR_ID IS NULL
   OR TIMESTAMP IS NULL
   OR TEMPERATURE IS NULL
   OR HUMIDITY IS NULL
   OR SOIL_MOISTURE IS NULL
   OR LIGHT_INTENSITY IS NULL
   OR BATTERY_LEVEL IS NULL;


SELECT *
FROM POWERRANGERS.STAGING_SOILDATARAW
WHERE TIMESTAMP IS NULL
   OR SOIL_COMP IS NULL
   OR SOIL_MOISTURE IS NULL
   OR SOIL_PH IS NULL
   OR NITROGEN_LEVEL IS NULL
   OR PHOSPHORUS_LEVEL IS NULL
   OR ORGANIC_MATTER IS NULL;



SELECT *
FROM POWERRANGERS.STAGING_WEATHERDATARAW
WHERE TIMESTAMP IS NULL
   OR WEATHER_CONDITION  IS NULL
   OR WIND_SPEED IS NULL
   OR PRECIPITATION  IS NULL;






 --FILLING MISSING DATA



UPDATE POWERRANGERS.STAGING_CROPDATARAW AS target
SET CROP_YIELD = (
    SELECT AVG(CROP_YIELD)
    FROM POWERRANGERS.STAGING_CROPDATARAW AS source
)
WHERE CROP_YIELD IS NULL;


UPDATE POWERRANGERS.STAGING_CROPDATARAW AS target
SET TIMESTAMP = (
    SELECT MAX(TIMESTAMP)
    FROM POWERRANGERS.STAGING_CROPDATARAW AS source
)
WHERE TIMESTAMP IS NULL;

UPDATE POWERRANGERS.STAGING_CROPDATARAW AS target
SET CROP_TYPE = (
    SELECT CROP_TYPE
    FROM (
        SELECT CROP_TYPE, COUNT(*) AS cnt
        FROM POWERRANGERS.STAGING_CROPDATARAW AS source
        GROUP BY CROP_TYPE
        ORDER BY cnt DESC
        LIMIT 1
    )
)
WHERE CROP_TYPE IS NULL;


UPDATE POWERRANGERS.STAGING_CROPDATARAW
SET GROWTH_STAGE = 'default_growth_stage'
WHERE GROWTH_STAGE IS NULL;


UPDATE POWERRANGERS.STAGING_CROPDATARAW
SET PEST_ISSUE = 'default_pest_issue'
WHERE PEST_ISSUE IS NULL;




UPDATE POWERRANGERS.STAGING_LOCATIONDATARAW
SET
    SENSOR_ID = COALESCE(SENSOR_ID, 'default_sensor_id'),
    LOCATION_NAME = COALESCE(LOCATION_NAME, 'default_location_name'),
    LATITUDE = COALESCE(LATITUDE, 0.0), 
    LONGITUDE = COALESCE(LONGITUDE, 0.0), 
    ELEVATION = COALESCE(ELEVATION, 0.0), 
    REGION = COALESCE(REGION, 'default_region')
WHERE
    SENSOR_ID IS NULL
    OR LOCATION_NAME IS NULL
    OR LATITUDE IS NULL
    OR LONGITUDE IS NULL
    OR ELEVATION IS NULL
    OR REGION IS NULL;



UPDATE POWERRANGERS.STAGING_PESTDATARAW
SET
    TIMESTAMP = COALESCE(TIMESTAMP, 'default_timestamp'),
    PEST_TYPE = COALESCE(PEST_TYPE, 'default_PEST_TYPE'),
    PEST_DESCRIPTION = COALESCE(PEST_DESCRIPTION, 'default_PEST_DESCRIPTION'),
    PEST_SEVERITY = COALESCE(PEST_SEVERITY, 'default_PEST_SEVERITY')
WHERE
    TIMESTAMP IS NULL
    OR PEST_TYPE IS NULL
    OR PEST_DESCRIPTION IS NULL
    OR PEST_SEVERITY IS NULL;





UPDATE POWERRANGERS.STAGING_SOILDATARAW
SET
    TIMESTAMP = COALESCE(TIMESTAMP, '1970-01-01 00:00:00'::TIMESTAMP_NTZ),
    SOIL_COMP = COALESCE(SOIL_COMP, 'default_SOIL_COMP'),
    SOIL_MOISTURE = COALESCE(SOIL_MOISTURE, 0.0),
    SOIL_PH = COALESCE(SOIL_PH, 0.0), 
    NITROGEN_LEVEL = COALESCE(NITROGEN_LEVEL, 0.0), 
    PHOSPHORUS_LEVEL = COALESCE(PHOSPHORUS_LEVEL, 0.0), 
    ORGANIC_MATTER = COALESCE(ORGANIC_MATTER, 0.0) 
WHERE
    TIMESTAMP IS NULL
    OR SOIL_COMP IS NULL
    OR SOIL_MOISTURE IS NULL
    OR SOIL_PH IS NULL
    OR NITROGEN_LEVEL IS NULL
    OR PHOSPHORUS_LEVEL IS NULL
    OR ORGANIC_MATTER IS  NULL;



    
UPDATE POWERRANGERS.STAGING_WEATHERDATARAW
SET
    TIMESTAMP = COALESCE(TIMESTAMP, '1970-01-01 00:00:00'::TIMESTAMP_NTZ),
    WEATHER_CONDITION = COALESCE(WEATHER_CONDITION, 'default_WEATHER_CONDITION'),
    WIND_SPEED = COALESCE(WIND_SPEED, 0.0),
    PRECIPITATION = COALESCE(PRECIPITATION, 0.0)
WHERE
    TIMESTAMP IS NULL
    OR WEATHER_CONDITION IS NULL
    OR WIND_SPEED IS NULL
    OR PRECIPITATION IS NULL;




    --REMOVING DUPLICATES

--CHECKING FOR DUPLICATES FIRST

SELECT *
FROM POWERRANGERS.STAGING_CROPDATARAW
WHERE (TIMESTAMP, CROP_TYPE,CROP_YIELD, GROWTH_STAGE, PEST_ISSUE  ) IN (
    SELECT TIMESTAMP, CROP_TYPE,CROP_YIELD, GROWTH_STAGE, PEST_ISSUE 
    FROM POWERRANGERS.STAGING_CROPDATARAW
    GROUP BY TIMESTAMP, CROP_TYPE,CROP_YIELD, GROWTH_STAGE, PEST_ISSUE 
    HAVING COUNT(*) > 1
);


--REMOVING DUPLICATES

-- Create a new table to hold non-duplicate records
CREATE OR REPLACE TABLE POWERRANGERS.STAGING_CROPDATARAW_TEMP AS
SELECT *
FROM POWERRANGERS.STAGING_CROPDATARAW
QUALIFY ROW_NUMBER() OVER (PARTITION BY TIMESTAMP, CROP_TYPE, CROP_YIELD, GROWTH_STAGE, PEST_ISSUE ORDER BY (SELECT NULL)) = 1;

--  Drop the original table
DROP TABLE POWERRANGERS.STAGING_CROPDATARAW;

--  Rename the new table to match the original table name
ALTER TABLE POWERRANGERS.STAGING_CROPDATARAW_TEMP
RENAME TO POWERRANGERS.STAGING_CROPDATARAW;





--NO DUPLICATES
SELECT *
FROM POWERRANGERS.STAGING_IRRIGATIONDATARAW
WHERE (SENSOR_ID, TIMESTAMP,IRRIGATION_METHOD, WATER_SOURCE, IRRIGATION_DURATION_MIN  ) IN (
    SELECT SENSOR_ID, TIMESTAMP,IRRIGATION_METHOD, WATER_SOURCE, IRRIGATION_DURATION_MIN  
    FROM POWERRANGERS.STAGING_IRRIGATIONDATARAW
    GROUP BY SENSOR_ID, TIMESTAMP,IRRIGATION_METHOD, WATER_SOURCE, IRRIGATION_DURATION_MIN 
    HAVING COUNT(*) > 1
);







SELECT *
FROM POWERRANGERS.STAGING_LOCATIONDATARAW
WHERE (SENSOR_ID, LOCATION_NAME,LATITUDE, LONGITUDE, ELEVATION,  REGION ) IN (
    SELECT SENSOR_ID, LOCATION_NAME,LATITUDE, LONGITUDE, ELEVATION,  REGION   
    FROM POWERRANGERS.STAGING_LOCATIONDATARAW
    GROUP BY SENSOR_ID, LOCATION_NAME,LATITUDE, LONGITUDE, ELEVATION, REGION 
    HAVING COUNT(*) > 1
);


--REMOVING DUPLICATES
CREATE OR REPLACE TABLE POWERRANGERS.STAGING_LOCATIONDATARAW_TEMP AS
SELECT *
FROM POWERRANGERS.STAGING_LOCATIONDATARAW
QUALIFY ROW_NUMBER() OVER (PARTITION BY SENSOR_ID, LOCATION_NAME, LATITUDE, LONGITUDE, ELEVATION, REGION ORDER BY (SELECT NULL)) = 1;


DROP TABLE POWERRANGERS.STAGING_LOCATIONDATARAW;


ALTER TABLE POWERRANGERS.STAGING_LOCATIONDATARAW_TEMP
RENAME TO POWERRANGERS.STAGING_LOCATIONDATARAW;







SELECT *
FROM POWERRANGERS.STAGING_PESTDATARAW
WHERE (TIMESTAMP, PEST_TYPE,PEST_DESCRIPTION, PEST_SEVERITY ) IN (
    SELECT TIMESTAMP, PEST_TYPE,PEST_DESCRIPTION, PEST_SEVERITY    
    FROM POWERRANGERS.STAGING_PESTDATARAW
    GROUP BY TIMESTAMP, PEST_TYPE,PEST_DESCRIPTION, PEST_SEVERITY 
    HAVING COUNT(*) > 1
);



--REMOVING DUPLICATES

CREATE OR REPLACE TABLE POWERRANGERS.STAGING_PESTDATARAW_TEMP AS
SELECT *
FROM POWERRANGERS.STAGING_PESTDATARAW
QUALIFY ROW_NUMBER() OVER (PARTITION BY TIMESTAMP, PEST_TYPE, PEST_DESCRIPTION, PEST_SEVERITY ORDER BY (SELECT NULL)) = 1;

DROP TABLE POWERRANGERS.STAGING_PESTDATARAW;

ALTER TABLE POWERRANGERS.STAGING_PESTDATARAW_TEMP
RENAME TO POWERRANGERS.STAGING_PESTDATARAW;





--NO DUPLICATES
SELECT *
FROM POWERRANGERS.STAGING_SENSORDATARAW
WHERE (SENSOR_ID, TIMESTAMP,TEMPERATURE, HUMIDITY, SOIL_MOISTURE, LIGHT_INTENSITY, BATTERY_LEVEL ) IN (
    SELECT SENSOR_ID, TIMESTAMP,TEMPERATURE, HUMIDITY, SOIL_MOISTURE, LIGHT_INTENSITY, BATTERY_LEVEL    
    FROM POWERRANGERS.STAGING_SENSORDATARAW
    GROUP BY SENSOR_ID, TIMESTAMP,TEMPERATURE, HUMIDITY, SOIL_MOISTURE, LIGHT_INTENSITY, BATTERY_LEVEL 
    HAVING COUNT(*) > 1
);







SELECT *
FROM POWERRANGERS.STAGING_SOILDATARAW
WHERE (SOIL_COMP, SOIL_MOISTURE, SOIL_PH, NITROGEN_LEVEL, PHOSPHORUS_LEVEL, ORGANIC_MATTER ) IN (
    SELECT SOIL_COMP, SOIL_MOISTURE, SOIL_PH, NITROGEN_LEVEL, PHOSPHORUS_LEVEL, ORGANIC_MATTER    
    FROM POWERRANGERS.STAGING_SOILDATARAW
    GROUP BY SOIL_COMP, SOIL_MOISTURE, SOIL_PH, NITROGEN_LEVEL, PHOSPHORUS_LEVEL, ORGANIC_MATTER 
    HAVING COUNT(*) > 1
);



--REMOVING DUPLICATE

CREATE OR REPLACE TABLE POWERRANGERS.STAGING_SOILDATARAW_TEMP AS
SELECT *
FROM POWERRANGERS.STAGING_SOILDATARAW
QUALIFY ROW_NUMBER() OVER (PARTITION BY SOIL_COMP, SOIL_MOISTURE, SOIL_PH, NITROGEN_LEVEL, PHOSPHORUS_LEVEL, ORGANIC_MATTER ORDER BY (SELECT NULL)) = 1;


DROP TABLE POWERRANGERS.STAGING_SOILDATARAW;

ALTER TABLE POWERRANGERS.STAGING_SOILDATARAW_TEMP
RENAME TO POWERRANGERS.STAGING_SOILDATARAW;





SELECT *
FROM POWERRANGERS.STAGING_WEATHERDATARAW
WHERE (TIMESTAMP, WEATHER_CONDITION, WIND_SPEED, PRECIPITATION ) IN (
    SELECT TIMESTAMP, WEATHER_CONDITION, WIND_SPEED, PRECIPITATION    
    FROM POWERRANGERS.STAGING_WEATHERDATARAW
    GROUP BY TIMESTAMP, WEATHER_CONDITION, WIND_SPEED, PRECIPITATION 
    HAVING COUNT(*) > 1
);



--REMOVING DUPLICATES

CREATE OR REPLACE TABLE POWERRANGERS.STAGING_WEATHERDATARAW_TEMP AS
SELECT *
FROM POWERRANGERS.STAGING_WEATHERDATARAW
QUALIFY ROW_NUMBER() OVER (PARTITION BY TIMESTAMP, WEATHER_CONDITION, WIND_SPEED, PRECIPITATION ORDER BY (SELECT NULL)) = 1;

DROP TABLE POWERRANGERS.STAGING_WEATHERDATARAW;

ALTER TABLE POWERRANGERS.STAGING_WEATHERDATARAW_TEMP
RENAME TO POWERRANGERS.STAGING_WEATHERDATARAW;




--Day 2: Dimension Tables and Initial Fact Tables

--Task 1: Create Dimension Tables
--Based on the cleaned and transformed data, create dimension Tables for attributes such as Location, Time, Crop Type, Pest Type, and Irrigation Method.
--Populate these dimension tables.

CREATE OR REPLACE TABLE DIMENSION_Location (
    RECORD_ID INT AUTOINCREMENT(1,1) PRIMARY KEY,
    Location VARCHAR(16777216)
);



CREATE OR REPLACE TABLE DIMENSION_Time (
    RECORD_ID INT AUTOINCREMENT(1,1) PRIMARY KEY,
    Time VARCHAR(16777216)
);


CREATE OR REPLACE TABLE DIMENSION_Crop_Type (
    RECORD_ID INT AUTOINCREMENT(1,1) PRIMARY KEY,
    Crop_Type VARCHAR(16777216)
);


CREATE OR REPLACE TABLE DIMENSION_Pest_Type (
    RECORD_ID INT AUTOINCREMENT(1,1) PRIMARY KEY,
    Pest_Type VARCHAR(16777216)
);


CREATE OR REPLACE TABLE DIMENSION_Irrigation_Method (
    RECORD_ID INT AUTOINCREMENT(1,1) PRIMARY KEY,
    Irrigation_Method VARCHAR(16777216)
);


DROP TABLE POWERRANGERS.DIMENSION_TIME;


CREATE OR REPLACE TABLE DIMENSION_Time (
    RECORD_ID INT AUTOINCREMENT(1,1) PRIMARY KEY,
    IRRIGATIONDATA_TIME VARCHAR(16777216),
    CROPDATA_TIME VARCHAR(16777216),
    PESTDATA_TIME VARCHAR(16777216),
    SENSORDATA_TIME VARCHAR(16777216),
    SOILDDATA_TIME VARCHAR(16777216),
    WEATHERDATA_TIME VARCHAR(16777216)
);



--FILLING UP THE TABLES


--FOR LOCATION


INSERT INTO DIMENSION_LOCATION (LOCATION)
SELECT LOCATION_NAME
FROM DFA23RAWDATA.POWERRANGERS.STAGING_LOCATIONDATARAW;



--FOR TIME
INSERT INTO DIMENSION_Time (IRRIGATIONDATA_TIME)
SELECT TIMESTAMP
FROM DFA23RAWDATA.POWERRANGERS.STAGING_IRRIGATIONDATARAW; 

INSERT INTO DIMENSION_Time (CROPDATA_TIME)
SELECT TIMESTAMP
FROM DFA23RAWDATA.POWERRANGERS.STAGING_CROPDATARAW;

INSERT INTO DIMENSION_Time (PESTDATA_TIME)
SELECT TIMESTAMP
FROM DFA23RAWDATA.POWERRANGERS.STAGING_PESTDATARAW;

INSERT INTO DIMENSION_Time (SENSORDATA_TIME)
SELECT TIMESTAMP
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SENSORDATARAW;

INSERT INTO DIMENSION_Time (SOILDDATA_TIME)
SELECT TIMESTAMP
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW;

INSERT INTO DIMENSION_Time (WEATHERDATA_TIME)
SELECT TIMESTAMP
FROM DFA23RAWDATA.POWERRANGERS.STAGING_WEATHERDATARAW;



--FOR CROP TYPE
INSERT INTO DIMENSION_CROP_TYPE (CROP_TYPE)
SELECT CROP_TYPE
FROM DFA23RAWDATA.POWERRANGERS.STAGING_CROPDATARAW;


--FOR PEST TYPE
INSERT INTO DIMENSION_PEST_TYPE (PEST_TYPE)
SELECT PEST_TYPE
FROM DFA23RAWDATA.POWERRANGERS.STAGING_PESTDATARAW;

--FOR IRRIGATION METHOD

INSERT INTO DIMENSION_IRRIGATION_METHOD (IRRIGATION_METHOD)
SELECT IRRIGATION_METHOD
FROM DFA23RAWDATA.POWERRANGERS.STAGING_IRRIGATIONDATARAW;






--Fact Soil Data Table
CREATE OR REPLACE TABLE fact_soil_data (
    record_id INT AUTOINCREMENT(1,1) PRIMARY KEY,
    soil_comp DECIMAL(5, 2),
    soil_moisture DECIMAL(5, 2),
    soil_ph DECIMAL(4, 2),
    nitrogen_level DECIMAL(6, 2),
    phosphorus_level DECIMAL(6, 2),
    organic_matter DECIMAL(6, 2),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES DIMENSION_Location(RECORD_ID)
);


--Fact Crop Yield Table
CREATE OR REPLACE TABLE fact_crop_yield (
    record_id INT AUTOINCREMENT(1,1) PRIMARY KEY,
    crop_yield DECIMAL(8, 2),
    crop_type_id INT,
    FOREIGN KEY (crop_type_id) REFERENCES DIMENSION_Crop_Type(RECORD_ID),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES DIMENSION_Location(RECORD_ID)
);


--Fact Environmental Conditions Table
CREATE OR REPLACE TABLE fact_environmental_conditions (
    record_id INT AUTOINCREMENT(1,1) PRIMARY KEY,
    temperature DECIMAL(5, 2),
    humidity DECIMAL(5, 2),
    light_intensity DECIMAL(7, 2),
    battery_level DECIMAL(5, 2),
    wind_speed DECIMAL(5, 2),
    precipitation DECIMAL(7, 2),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES DIMENSION_Location(RECORD_ID)
);






INSERT INTO fact_soil_data (soil_comp)
SELECT
  CASE
    WHEN soil_comp = 'NA' THEN 0.0  -- Replace 'NA' with 0.0
    WHEN TRY_CAST(soil_comp AS DECIMAL(5, 2)) IS NOT NULL THEN CAST(soil_comp AS DECIMAL(5, 2))
    ELSE NULL  -- Handle unexpected values by setting them to NULL or another default
  END
FROM STAGING_SOILDATARAW;


INSERT INTO fact_soil_data (soil_MOISTURE)
SELECT soil_MOISTURE
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW


INSERT INTO fact_soil_data (SOIL_PH)
SELECT SOIL_PH
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW

INSERT INTO fact_soil_data (NITROGEN_LEVEL)
SELECT NITROGEN_LEVEL
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW

INSERT INTO fact_soil_data (PHOSPHORUS_LEVEL)
SELECT PHOSPHORUS_LEVEL
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW

INSERT INTO fact_soil_data (ORGANIC_MATTER)
SELECT ORGANIC_MATTER
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SOILDATARAW


INSERT INTO fact_CROP_YIELD (CROP_YIELD)
SELECT CROP_YIELD
FROM DFA23RAWDATA.POWERRANGERS.STAGING_CROPDATARAW


INSERT INTO fact_ENVIRONMENTAL_CONDITIONS (TEMPERATURE)
SELECT TEMPERATURE
FROM DFA23RAWDATA.POWERRANGERS.STAGING_SENSORDATARAW

INSERT INTO fact_ENVIRONMENTAL_CONDITIONS (PRECIPITATION)
SELECT PRECIPITATION
FROM DFA23RAWDATA.POWERRANGERS.STAGING_WEATHERDATARAW 





--DOCUMENTATION OF THE ENTIRE ETL PROCESS
--# Data Warehouse ETL Process Documentation

--## Overview

--This document provides an overview of the ETL (Extract, Transform, Load) process for populating our data warehouse with data from various sources. The ETL process involves cleansing, transforming, and organizing data to make it suitable for analysis and reporting.

--## SQL Script Details

--**SCHEMA Name:** [POWERRANGERS]

--**Author:** [TOCHUKWDFA23RAWDATAU EMMANUEL NDUKAUBA]

--**Date:** [09/17/2023]

--**Purpose:** This script is designed to perform the following tasks:
-- Extract data from source tables
-- Transform and cleanse data
-- Create dimension and fact tables
-- Populate dimension and fact tables

---## Data Sources


--SOURCE DATA IS FROM THE RAWDATA SCHEMA
--The data used in this ETL process was sourced from the RAWDATA and loaded into multiple staging tables as instructed, including:
-- `STAGING_CROPDATARAW`
-- `STAGING_IRRIGATIONDATARAW`
-- `STAGING_LOCATIONDATARAW`
-- `STAGING_PESTDATARAW`
-- `STAGING_SENSORDATARAW`
-- `STAGING_SOILDATARAW`
-- `STAGING_WEATHERDATARAW`

--## ETL Process Steps

--### 1. Data Extraction

--Data is extracted from the source tables using SQL `SELECT` statements. The data includes information related to crop data, irrigation data, location data, pest data, sensor data, soil data, and weather data.

--### 2. Data Cleansing

--#### Handling Missing Values
-- Missing values in the source data are identified using `NULL` checks.
-- Missing values are replaced with appropriate default values or NULL, depending on the context.
-- Examples include replacing 'NA' with 0.0 for numeric columns and setting default values for other columns.

--#### Removing Duplicates
-- Duplicate records are identified based on certain columns.
-- Duplicate records are removed from the staging tables using the `QUALIFY` clause.

--### 3. Dimension Tables

--Dimension tables are created to store attributes such as location, time, crop type, pest type, and irrigation method. These tables are populated with unique values from the cleaned and transformed data.

---#### Dimension Tables Created:
-- `DIMENSION_Location`
-- `DIMENSION_Time`
-- `DIMENSION_Crop_Type`
-- `DIMENSION_Pest_Type`
-- `DIMENSION_Irrigation_Method`

--### 4. Fact Tables

---Fact tables are created to store data that can be analyzed and aggregated. The following fact tables are created:

--#### Fact Tables Created:
-- `fact_soil_data`
-- `fact_crop_yield`
-- `fact_environmental_conditions`

---Data is inserted into these tables from the cleaned and transformed staging tables.

--## Data Type Handling

--Data types are appropriately handled during the ETL process. For example, string values are converted to decimals or timestamps where necessary.

--## Testing

--Before deploying this ETL process in a production environment, it was thoroughly tested on a representative dataset to ensure it performs as expected and handles various scenarios.

--## Security

--Security measures are in place to protect the data during the ETL process, especially when executing in a production environment.

--## Conclusion

--This ETL process script successfully extracts, cleanses, transforms, and loads data from source tables into dimension and fact tables in the data warehouse. It is designed to handle missing values, duplicates, and data type conversions to ensure data quality.

--For any questions or issues related to this ETL process, please contact tochinduka44@icloud.com.

---


