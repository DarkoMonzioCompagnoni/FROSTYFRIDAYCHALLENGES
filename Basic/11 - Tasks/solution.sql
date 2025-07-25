-- Set the database and schema
use database real_database;
use schema public;

-- Create the stage that points at the data.
create stage week_11_frosty_stage
    url = 's3://frostyfridaychallenges/challenge_11/'
    FILE_FORMAT = (type='csv', SKIP_HEADER=1); 

-- Create the table as a CTAS statement.
create or replace table real_database.public.week11 as
select m.$1 as milking_datetime,
        m.$2 as cow_number,
        m.$3 as fat_percentage,
        m.$4 as farm_code,
        m.$5 as centrifuge_start_time,
        m.$6 as centrifuge_end_time,
        m.$7 as centrifuge_kwph,
        m.$8 as centrifuge_electricity_used,
        m.$9 as centrifuge_processing_time,
        m.$10 as task_used
from @week_11_frosty_stage m;


-- TASK 1: Remove all the centrifuge dates and centrifuge kwph and replace them with NULLs WHERE fat = 3. 
-- Add note to task_used.
create or replace task whole_milk_updates
    schedule = '1400 minutes'
as  
   UPDATE week11
       SET centrifuge_start_time = null, 
       centrifuge_end_time = null, 
       centrifuge_kwph = null, 
       centrifuge_electricity_used = null, 
       centrifuge_processing_time = null,
       task_used = system$current_user_task_name()
WHERE fat_percentage = 3;
SELECT * FROM week11


-- TASK 2: Calculate centrifuge processing time (difference between start and end time) WHERE fat != 3. 
-- Add note to task_used.
create or replace task skim_milk_updates
    after real_database.public.whole_milk_updates
as
     UPDATE week11
     SET centrifuge_processing_time = (centrifuge_end_time -     centrifuge_start_time),
        task_used = system$current_user_task_name()
     WHERE fat != 3;

-- Manually execute the task.
execute task whole_milk_updates;

-- Check that the data looks as it should.
select * from week11;

-- Check that the numbers are correct.
select task_used, count(*) as row_count from week11 group by task_used;
