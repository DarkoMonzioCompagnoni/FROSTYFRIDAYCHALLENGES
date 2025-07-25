------------------
-- STARTUP CODE --
------------------

-- Create a table named fruit_salad
CREATE OR REPLACE TABLE fruit_salad (
    fruits VARCHAR(255)
);

-- Insert sample frutis into the fruit_salad
INSERT INTO fruit_salad (fruits) VALUES
('apple'),
('apricot'),
('banana'),
('pineapple'),
('oranges'),
('kiwi'),
('strawberry'),
('grape'),
('watermelon'),
('pear'),
('peach'),
('strawberry'),
('blueberry'),
('mango'),
('lemon'),
('lime'),
('papaya'),
('cherry'),
('plum'),
('fig'),
('passion fruit'),
('raspberry'),
('blackberry'),
('nectarine'),
('cantaloupe'),
('apricot'),
('tangerine'),
('guava'),
('dragon fruit');

--------------
-- SOLUTION --
--------------


SELECT fruits, JAROWINKLER_SIMILARITY('strawberry',fruits) AS SIMILARITY
FROM FRUIT_SALAD
ORDER BY SIMILARITY DESC;
