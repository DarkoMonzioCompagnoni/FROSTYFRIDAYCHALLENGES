-- Set the current database context to 'FROSTYFRIDAY'
USE DATABASE FROSTYFRIDAY;

------------------
-- STARTUP CODE --
------------------

-- Create or replace the 'departments' table
CREATE OR REPLACE TABLE departments (
    department_name VARCHAR, 
    department_ID INT, 
    head_department_ID INT
);

-- Insert data into the 'departments' table
INSERT INTO departments (department_name, department_ID, head_department_ID) VALUES
    ('Research & Development', 1, NULL), -- The Research & Development department is the top level.
    ('Product Development', 11, 1),
        ('Software Design', 111, 11),
        ('Product Testing', 112, 11),
    ('Human Resources', 2, 1),
        ('Recruitment', 21, 2),
        ('Employee Relations', 22, 2);

-- Checking the contents of the 'departments' table
SELECT * 
FROM departments;

--------------
-- SOLUTION --
--------------

-- Construct a hierarchical tree of department relationships
SELECT
    SYS_CONNECT_BY_PATH(department_name, ' -> ') AS connection_tree, -- Path showing the hierarchy of departments
    department_ID,
    head_department_ID,
    department_name
FROM departments
    START WITH department_name = 'Research & Development' -- The root of the hierarchy
    CONNECT BY 
        head_department_ID = PRIOR department_ID -- Define the parent-child relationship
ORDER BY connection_tree; -- Ensure the result is ordered to reflect the hierarchical structure
