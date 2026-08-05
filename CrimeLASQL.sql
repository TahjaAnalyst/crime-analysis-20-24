-- Changing DateTime to DATE
ALTER TABLE CrimeLA
ALTER COLUMN Date_Rptd DATE;

ALTER TABLE CrimeLA
ALTER COLUMN DATE_OCC DATE;

ALTER TABLE CrimeLA
ALTER COLUMN TIME_OCC TIME(0);

-- Replacing negative ages with absolute values
UPDATE CrimeLA
SET 
    Vict_Age = ABS(Vict_Age)
WHERE Vict_Age < 0 ;

-- Replacing NULLS with known values
UPDATE CrimeLA
SET Vict_Descent = COALESCE(Vict_Descent, 'X')
WHERE Vict_Descent IS NULL;

UPDATE CrimeLA
SET Vict_Sex = COALESCE(Vict_Sex, 'X')
WHERE Vict_Sex IS NULL;

-- Cleaning up data types
ALTER TABLE CrimeLA
ALTER COLUMN LAT FLOAT;

ALTER TABLE CrimeLA
ALTER COLUMN LON FLOAT;

-- Removing extra spaces in location column

ALTER TABLE CrimeLA
ADD corrected_location varchar(50);

UPDATE CrimeLA
SET corrected_location = REPLACE(REPLACE(REPLACE(LOCATION, ' ', '><'), '<>',''), '><', ' ')
;
-- Creating cleaned view

CREATE VIEW crime_cleaned AS 
SELECT DR_NO as Record_Number, DATE_OCC, MONTH(DATE_OCC) AS Month, YEAR(DATE_OCC) AS Year, TIME_OCC, AREA, Crm_Cd_Desc, Weapon_Used_Cd, LAT, LON
FROM CrimeLA;


-- View Types of Crime ALL

CREATE VIEW crime_types AS 
SELECT Crm_Cd_Desc, COUNT(Crm_Cd_Desc) AS CrimeTypes
FROM CrimeLA
WHERE Crm_Cd_Desc IS NOT NULL
GROUP BY Crm_Cd_Desc;

-- Areas of Crime

CREATE VIEW Crime_Areas AS
SELECT AREA_NAME, COUNT(AREA_NAME) AS Arrests
FROM CrimeLA
GROUP BY AREA_NAME;

-- Times of crime bucketed

CREATE VIEW MonthlyArrests AS 
SELECT MONTH(DATE_OCC) AS Month, YEAR(DATE_OCC) AS Year, COUNT(*) AS CrimeCount
FROM CrimeLA
GROUP BY MONTH(DATE_OCC), YEAR(DATE_OCC);

CREATE VIEW TimeArrests AS 
SELECT 
    FORMAT(DATE_BUCKET(MINUTE, 60, CAST(TIME_OCC AS DATETIME2)), 'HH:mm') AS time_bucket,
    COUNT(*) AS Arrests
FROM CrimeLA
GROUP BY DATE_BUCKET(MINUTE, 60, CAST(TIME_OCC AS DATETIME2));

-- Victims View

CREATE VIEW Victim_Dem AS
SELECT Vict_Age, Vict_Sex, Vict_Descent, COUNT(*) Total_Victims
FROM CrimeLA
GROUP BY Vict_Age, Vict_Sex, Vict_Descent
;

-- Further condensing the types of crimes using CASE statements

CREATE VIEW Crime_Categories AS
SELECT 
CASE 
    WHEN Crm_Cd_Desc LIKE '%THEFT%' OR Crm_Cd_Desc LIKE '%BURGLARY%' OR Crm_Cd_Desc LIKE '%SHOPLIFTING%'
    OR Crm_Cd_Desc LIKE '%STOLEN%' OR Crm_Cd_Desc LIKE '%ROBBERY%' OR Crm_Cd_Desc LIKE '%PICKPOCKET%'THEN 'THEFT'
    WHEN Crm_Cd_Desc LIKE '%BATTERY%' OR Crm_Cd_Desc LIKE '%ASSAULT%' OR Crm_Cd_Desc LIKE '%THREAT%' OR Crm_Cd_Desc LIKE '%ABUSE%' OR Crm_Cd_Desc LIKE '%HOMICIDE%' OR Crm_Cd_Desc LIKE '%MURDER%' OR Crm_Cd_Desc LIKE '%MANSLAUGHTER%'
    OR Crm_Cd_Desc LIKE '%WEAPON%' OR Crm_Cd_Desc LIKE '%SHOT%' OR Crm_Cd_Desc LIKE '%BOMB%' THEN 'VIOLENT'
    WHEN Crm_Cd_Desc LIKE '%SEX%' OR Crm_Cd_Desc LIKE '%RAPE%' OR Crm_Cd_Desc LIKE '%LEWD%' THEN 'SEXUAL'
    WHEN Crm_Cd_Desc LIKE '%VANDALISM%' THEN 'VANDALISM'
    ELSE 'OTHER'
END AS CrimeTypes, COUNT(*) AS Arrests
FROM CrimeLA
GROUP BY    
CASE
    WHEN Crm_Cd_Desc LIKE '%THEFT%' OR Crm_Cd_Desc LIKE '%BURGLARY%' OR Crm_Cd_Desc LIKE '%SHOPLIFTING%'
    OR Crm_Cd_Desc LIKE '%STOLEN%' OR Crm_Cd_Desc LIKE '%ROBBERY%' OR Crm_Cd_Desc LIKE '%PICKPOCKET%'THEN 'THEFT'
    WHEN Crm_Cd_Desc LIKE '%BATTERY%' OR Crm_Cd_Desc LIKE '%ASSAULT%' OR Crm_Cd_Desc LIKE '%THREAT%' OR Crm_Cd_Desc LIKE '%ABUSE%' OR Crm_Cd_Desc LIKE '%HOMICIDE%' OR Crm_Cd_Desc LIKE '%MURDER%' OR Crm_Cd_Desc LIKE '%MANSLAUGHTER%'
    OR Crm_Cd_Desc LIKE '%WEAPON%' OR Crm_Cd_Desc LIKE '%SHOT%' OR Crm_Cd_Desc LIKE '%BOMB%' THEN 'VIOLENT'
    WHEN Crm_Cd_Desc LIKE '%SEX%' OR Crm_Cd_Desc LIKE '%RAPE%' OR Crm_Cd_Desc LIKE '%LEWD%' THEN 'SEXUAL'
    WHEN Crm_Cd_Desc LIKE '%VANDALISM%' THEN 'VANDALISM'
    ELSE 'OTHER'
END;
