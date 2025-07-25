----------------
-- SETUP CODE --
----------------

create or replace stage frosty_stage
    url = 's3://frostyfridaychallenges/'
;

CREATE OR REPLACE FILE FORMAT frosty_csv
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('\\N', 'NULL', '');

create or replace table week_139 as 
select
    $1 as id,
    $2 as student,
    $3 as rating,
    $4 as review_text
from
    @frosty_stage/challenge_139 (
        file_format=>'frosty_csv'
;

------------
--SOLUTION--
------------

SELECT SNOWFLAKE.CORTEX.ENTITY_SENTIMENT(LISTAGG(review_text,'/'),['Content', 'Teaching']) FROM week_139;
