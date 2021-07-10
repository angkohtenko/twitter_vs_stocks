# Create tables
CREATE TABLE stock (
    date DATE NOT NULL,
    close_price FLOAT NOT NULL,
    stock_id INT NOT NULL,
    PRIMARY KEY (stock_id),
);

CREATE TABLE tweets_text (
    date DATE NOT NULL,
    text VARCHAR NOT NULL,
    FOREIGN KEY (stock_id) REFERENCES stock (stock_id)
);
