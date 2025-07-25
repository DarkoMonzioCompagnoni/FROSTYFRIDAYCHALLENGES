--------------
-- SOLUTION --
--------------

CREATE OR REPLACE USER user1 
PASSWORD = 'abc123'
;

-- Creating the authentication policy --
CREATE AUTHENTICATION POLICY access_only_via_snowflake_ui_with_username_password
  CLIENT_TYPES = ('SNOWFLAKE_UI')
  AUTHENTICATION_METHODS = ('PASSWORD')
  COMMENT = 'user can access only via the Snowflake UI using username
  and password';

-- Assigning the authentication policy to the user --
ALTER USER user1 SET AUTHENTICATION POLICY access_only_via_snowflake_ui_with_username_password;
