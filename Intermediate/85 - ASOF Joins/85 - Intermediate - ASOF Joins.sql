-- In the heart of a bustling financial district lies a brokerage firm’s trading floor, where traders make split-second decisions amid a frenzy of activity. Trades and quotes, recorded in separate tables, hold vital information about transactions and market prices.

-- To ensure traders have the latest market data, a critical task emerges: pairing each trade with the most recent quote available at or before its time. Analysts devise a sophisticated SQL query, leveraging temporal joins to seamlessly integrate trade and quote data based on timestamps.

-- Given two tables, trade and quotes, containing transactional data in a financial market, where the trade table records trades and the quotes table records quotes for a specific financial instrument, construct an ASOF join SQL statement to pair each trade record with the most recent quote record available at or before the time of the trade. --

-- START UP CODE --

create or replace temporary table trades (
    type VARCHAR,
    id INT,
    ticker VARCHAR,
    datetime TIMESTAMP_TZ,
    price FLOAT,
    volume INT
);

create or replace temporary table quotes(
    type VARCHAR,
    id INT,
    ticker VARCHAR,
    datetime TIMESTAMP_TZ,
    ask FLOAT,
    bid FLOAT
);
insert into trades values
    ('trade', 2, 'AAPL', '2020-01-06 09:00:30.000+09:00', 305, 1),  
    ('trade', 2, 'AAPL', '2020-01-06 09:01:00.000+09:00', 310, 2),  
    ('trade', 2, 'AAPL', '2020-01-06 09:01:30.000+09:00', 308, 1),  
    ('trade', 3, 'GOOGL', '2020-01-06 09:02:00.000+09:00', 1500, 2),  
    ('trade', 3, 'GOOGL', '2020-01-06 09:03:00.000+09:00', 1520, 3),  
    ('trade', 3, 'GOOGL', '2020-01-06 09:03:30.000+09:00', 1515, 1); 

insert into quotes values
    ('quote', 2, 'AAPL', '2020-01-06 08:59:59.999+09:00', 305, 304),  
    ('quote', 2, 'AAPL', '2020-01-06 09:02:00.000+09:00', 311, 309),  
    ('quote', 3, 'GOOGL', '2020-01-06 09:01:00.000+09:00', 1490, 1485),  
    ('quote', 3, 'GOOGL', '2020-01-06 09:04:00.000+09:00', 1530, 1528);  

SELECT * from quotes;

------------
--solution--
------------

SELECT *
FROM trades ASOF JOIN quotes
  MATCH_CONDITION(trades.datetime >= quotes.datetime)
  ON trades.ticker = quotes.ticker;
