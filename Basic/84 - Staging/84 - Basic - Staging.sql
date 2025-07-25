-- starting code -- 

CREATE STAGE frosty_aws_stage
  URL = 's3://frostyfridaychallenges/';

LIST @FROSTY_AWS_STAGE/challenge_84/;

CREATE or replace STAGE WEEK84;

-- solution --
COPY FILES
INTO @week84
FROM @frosty_aws_stage
PATTERN='challenge_84/(.*)';
