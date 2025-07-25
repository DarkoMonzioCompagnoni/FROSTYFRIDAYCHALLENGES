-- SET DATABASE 
USE DATABASE FROSTYFRIDAY;

-----------------
--START UP CODE--
-----------------

CREATE OR REPLACE TABLE WEEK_87 AS
SELECT 
  'Happy Easter' AS greeting,
  ARRAY_CONSTRUCT('DE', 'FR', 'IT', 'ES', 'PL', 'RO', 'JA', 'KO', 'PT') AS language_codes;

--CHECK--
SELECT * FROM week_87;

------------
--SOLUTION--
------------

SELECT 
  value::VARCHAR AS language_code, 
  SNOWFLAKE.CORTEX.TRANSLATE(greeting, 'en', value) AS translated_greeting
FROM WEEK_87,
LATERAL FLATTEN(input => language_codes);
