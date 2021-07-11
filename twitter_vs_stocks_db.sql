-- Create tables
CREATE TABLE stock (
    date DATE NOT NULL,
    close_price FLOAT NOT NULL,
    change FLOAT NOT NULL,
    PRIMARY KEY (date)
);

CREATE TABLE tweets_text (
    date DATE NOT NULL,
    text VARCHAR NOT NULL,
    FOREIGN KEY (date) REFERENCES stock (date)
);

SELECT * FROM stock;
SELECT * FROM tweets_text;


SELECT stock.date,
    tweets_text.text
FROM stock
INNER JOIN tweets_text
ON stock.date = tweets_text.date;
