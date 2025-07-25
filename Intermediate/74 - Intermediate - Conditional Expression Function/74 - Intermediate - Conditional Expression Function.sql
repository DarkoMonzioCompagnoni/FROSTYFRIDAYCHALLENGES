-- Set the current database context to 'FROSTYFRIDAY'
USE DATABASE FROSTYFRIDAY;

------------------
-- STARTUP CODE --
------------------

-- Create or replace the 'dates' table with sample dates in various formats
CREATE OR REPLACE TABLE dates (
    birthdate VARCHAR
) AS
SELECT * FROM VALUES
    ('22/09/1968'),
    ('1968-09-22'),
    ('1968-09-22'),
    ('1968-09-22'),
    ('1968-09-22'),
    ('1968-09-22'),
    ('1968-09-22'),
    ('1968-09-22'),
    ('22/09/1968'),
    ('27/08/1985'),
    ('30/07/1967'),
    ('1985-08-27');

--------------
-- SOLUTION --
--------------

-- Create or replace a view 'dates_formatted' to display birthdates in a consistent 'DATE' format
CREATE OR REPLACE VIEW dates_formatted AS
SELECT
    COALESCE(
        TRY_TO_DATE(birthdate, 'YYYY-MM-DD'),
        TRY_TO_DATE(birthdate, 'DD/MM/YYYY')
    ) AS birthdate
FROM dates;

-- Query to check the content of 'dates_formatted'
SELECT * FROM dates_formatted;
