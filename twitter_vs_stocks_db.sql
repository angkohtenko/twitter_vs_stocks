-- Create tables
CREATE TABLE stock (
    stock_date DATE NOT NULL,
    close_price FLOAT NOT NULL,
    change FLOAT NOT NULL,
    PRIMARY KEY (stock_id)
);

CREATE TABLE tweets_text (
    tweet_date DATE NOT NULL,
    text VARCHAR NOT NULL,
    FOREIGN KEY (stock_date) REFERENCES stock (stock_date)
);

SELECT * FROM stock;
SELECT * FROM tweets_text;