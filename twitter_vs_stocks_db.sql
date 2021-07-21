
CREATE TABLE tweets_text (
  date DATE NOT NULL,
	text VARCHAR NOT NULL,
	tokenized_text VARCHAR NOT NULL,
	like_count INT NOT NULL,
	reply_count INT NOT NULL,
	retweet_count INT NOT NULL
);

-- Create tables
CREATE TABLE stock (
  date DATE NOT NULL,
	open FLOAT NOT NULL,
	high FLOAT NOT NULL,
	low FLOAT NOT NULL,
	close FLOAT NOT NULL,
	volume REAL NOT NULL,
  change FLOAT,

  PRIMARY KEY (date)
);

SELECT * FROM stock;
SELECT * FROM tweets_text;

-- Merge two tables
SELECT stock.date,
	tweets_text.tokenized_text,
	tweets_text.like_count,
	tweets_text.reply_count,
	tweets_text.retweet_count,
	stock.volume,
	stock.change
INTO twitter_vs_stocks
FROM stock
INNER JOIN tweets_text
ON stock.date = tweets_text.date;

SELECT * FROM twitter_vs_stocks;


