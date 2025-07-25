-- SET DATABASE 
USE DATABASE FROSTYFRIDAY;

-----------------
--START UP CODE--
-----------------

-- Get training data

CREATE STAGE IF NOT EXISTS frosty_aws_stage
  URL = 's3://frostyfridaychallenges/';

CREATE OR REPLACE TABLE WEEK_90 AS 
SELECT 
    $1::TIMESTAMP_NTZ AS SALE_DATE, 
    $2::INT AS PRODUCT_ID,
    $3::INT AS QUANTITY_SOLD,
    $4::INT AS UNIT_PRICE,
    $5/100::FLOAT AS TAX_PCT,
    $6/100::FLOAT AS DCT_PCT
FROM @FROSTY_AWS_STAGE/challenge_90
WHERE $1 != 'Date';

-- See what Snowflake has to say forecasting-wise about the below:

CREATE OR REPLACE TABLE WEEK_90_F LIKE WEEK_90;
ALTER TABLE WEEK_90_F DROP COLUMN QUANTITY_SOLD;

INSERT INTO WEEK_90_F VALUES 
(TO_TIMESTAMP_NTZ('2023-10-29'), 1000, 450, 0.1, 0.02),
(TO_TIMESTAMP_NTZ('2023-10-29'), 1001, 150, 0.15, 0.02),
(TO_TIMESTAMP_NTZ('2023-10-29'), 1002, 100, 0.13, 0.18),
(TO_TIMESTAMP_NTZ('2023-10-29'), 1003, 170, 0.11, 0.03),
(TO_TIMESTAMP_NTZ('2023-10-29'), 1004, 300, 0.04, 0.03);

------------
--SOLUTION--
------------

-- Check training data
select * from week_90;

-- creating the forecast instance "training" using data in week_90

CREATE SNOWFLAKE.ML.FORECAST model(
  INPUT_DATA => SYSTEM$REFERENCE('TABLE', 'week_90'),
  SERIES_COLNAME => 'PRODUCT_ID',
  TIMESTAMP_COLNAME => 'SALE_DATE',
  TARGET_COLNAME => 'QUANTITY_SOLD'
  );

-- generate the forecast calling the model on the week_90_f table

CALL model!FORECAST(
  INPUT_DATA => SYSTEM$REFERENCE('TABLE', 'week_90_f'),
  SERIES_COLNAME => 'PRODUCT_ID',
  TIMESTAMP_COLNAME =>'SALE_DATE'
);
