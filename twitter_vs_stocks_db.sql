-- Create tables
CREATE TABLE tesla_stocks (
    date DATE NOT NULL,
	open FLOAT NOT NULL,
	high FLOAT NOT NULL,
	low FLOAT NOT NULL,
	close FLOAT NOT NULL,
	volume REAL NOT NULL,
    change FLOAT,
    PRIMARY KEY (date)
);


CREATE TABLE tweets_data_2010_2020 (
    date DATE NOT NULL,
	text VARCHAR NOT NULL,
	tokenized_text VARCHAR NOT NULL,
	like_count INT NOT NULL,	
	reply_count INT NOT NULL,
	retweet_count INT NOT NULL
);

SELECT * FROM stock;
SELECT * FROM tweets_text;

-- Merge two tables
SELECT tesla_stocks.date,
	tweets_data_2010_2020.tokenized_text,
	tesla_stocks.close,
	tesla_stocks.change
INTO twitter_vs_stocks
FROM tesla_stocks
INNER JOIN tweets_data_2010_2020
ON tesla_stocks.date = tweets_data_2010_2020.date;

