-- Set the current database context to 'FROSTYFRIDAY'
USE DATABASE FROSTYFRIDAY;

------------------
-- STARTUP CODE --
------------------
CREATE STAGE frosty_aws_stage_week68
  URL = 's3://frostyfridaychallenges/challenge_68/';

LIST @frosty_aws_stage_week68;

--------------
-- SOLUTION --
--------------

CREATE TABLE data (
col variant
);

COPY INTO data 
    FROM @frosty_aws_stage_week68
    file_format = (type = json);

-- checking the json file
SELECT * FROM data, 
LATERAL FLATTEN(INPUT=>COL);

-- parsing json file

CREATE TABLE data (
col variant
);

COPY INTO data 
    FROM @frosty_aws_stage_week68
    file_format = (type = json);

-- parsing the json file
CREATE TABLE spanish_speaking_countries AS
SELECT 
    value:country::VARCHAR AS country,
    value:density::INT AS density,
    value:pop2023::INT AS pop2023
FROM data,
LATERAL FLATTEN(input => data.col) AS t(country, density, pop2023);
