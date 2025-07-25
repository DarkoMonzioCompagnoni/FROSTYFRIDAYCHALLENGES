-- Set the current database context to 'FROSTYFRIDAY'
USE DATABASE FROSTYFRIDAY;

------------------
-- STARTUP CODE --
------------------

create table week72_employees (
    employeeid int,
    firstname string,
    lastname string,
    dateofbirth date,
    position string
);

-- Creating external stage
CREATE OR REPLACE STAGE frosty_aws_stage
  URL = 's3://frostyfridaychallenges';

--------------
-- SOLUTION --
--------------

-- checking content of stage, folder challenge_72
LIST @frosty_aws_stage;

-- using execute immediate from to check to execute the sql to insert data in week72_employees

EXECUTE IMMEDIATE FROM @frosty_aws_stage/challenge_72/insert.sql;

SELECT * 
FROM WEEK72_EMPLOYEES;

