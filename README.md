# Twitter versus Stocks Analysis
## Overview of analysis
Posts in social media often cause changes in the stock market that may lead to unpredictable losses in one's investment portfolio.
In this project we analyse which words are more powerful and what influence they may have. Will they bring losses or profits to our portfolio? :moneybag:

As an example, we take tweets posted by Elon Musk and investigate how they may impact Tesla's stock prices.

Using [Twitter API](https://developer.twitter.com/en/docs/twitter-api) we collected [all posts made by Elon Musk in 2021](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tweets_data.csv) along with counts of likes, replies, and retweets. 
We merged it with another dataset of Elon's tweets for 2011-2020 found on [Kaggle](https://www.kaggle.com/ayhmrba/elon-musk-tweets-2010-2021).
All Elon's reposts and replies were excluded from analysis.

[Yahoo_fin library](http://theautomatic.net/yahoo_fin-documentation/) was used to get historical [Tesla's stock price data](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tesla_stocks.csv) for the same period. 

Classification and LDA models were built to analyse datasets.

## Communication protocol
There are five members in our team. The role of each team member will vary every week to ensure that everyone can gain experience in different areas of the project. A Slack channel was created to support communication amongst the team, and will be used to assign tickets, provide updates, and discuss any issues. The team will additionally have meetings twice a week to go over project progress and next steps.

## Project outline
1.	[Getting and storing data](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Getting_cleaning_preprocessing_data.ipynb)
    - Twitter data
      - Pull data from Twitter API and clean it
      - Pull tweets data from [Kaggle for 2011-2020](https://www.kaggle.com/ayhmrba/elon-musk-tweets-2010-2021) and clean it
      - Merge 2 datasets and export to [tweets_data_2010_2020_ungrouped.csv](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Data/tweets_data_2010_2020_ungrouped.csv) for Tableau dashboard
      - Preprocess data for machine learning (ML)
      - Upload cleaned data to PostgreSQL database and export to [tweets_data_2010_2020.csv](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Data/tweets_data_2010_2020.csv)
    - Stocks data
      - Pull data from Yahoo fin library
      - Clean data
      - Upload cleaned data to PostgreSQL database and export to [tesla_stocks.csv](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tesla_stocks.csv)
2.	SQL Database
    - Create [ERD schema](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Images/erd_schema.png)
    - Create [tables](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/twitter_vs_stocks_db.sql) to store tweets and stock data
    - Merge 2 tables and export to [twitter_vs_stocks.csv](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/twitter_vs_stocks.csv)
3.	Machine Learning Model
    - [Latent Dirichlet Allocation (LDA) Modelling](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/LDA.ipynb)
      - Preprocess data
      - Build LDA model
    - [Classification](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Classification_modelling.ipynb)
      - Preprocess data
      - Build classification model
4.	[Tableau dashboard](https://public.tableau.com/app/profile/kimberly.charbonneau/viz/TweetsvsStocks/TweetsvsStocks?publish=yes)
5.	Create presentation in [Google Slides](https://docs.google.com/presentation/d/1Pb_6SnwPIEJ_NzMGAOPzZYnDsY0nk0oNaf4ZpPRE4Cg/edit#slide=id.ge523cfaeaa_0_3)

## Technologies, languages, tools, and algorithms

![languages_tools.png](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Images/languages_tools.png)

## Data exploration and preliminary analysis
437 posts were pulled from Twitter API directly for the period January 1 - July 18, 2021. We extended the dataset by adding tweets from 2011 till 2020 found on [Kaggle]( https://www.kaggle.com/ayhmrba/elon-musk-tweets-2010-2021). All replies were excluded, so only 4,629 tweets were included for analysis.

During analysis we revealed that Elon Musk posted significantly more tweets since 2018.

<img src="https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/tweets_by_year.png" width="400" height="600"/>

"Tesla" was the most commonly tweeted word, followed by "model".

![word_cloud](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/word_cloud.png)

Tesla stock prices soared since September 2019 and reached a peak in January 2021.

![Tesla_stock_prices](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/Tesla_stock_price.png)

The most Tesla shares were traded on February 4th 2020.

![Tesla_traded_volume](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/Tesla_traded_volume.png)

The greatest increase in closing price was seen on January 8th 2021, while the greatest decrease was seen on September 8th 2020. Elon Musk posted a few tweets these days.

![Change_closing_price](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/Change_closing_price.png)

A correlation between the number of likes and stock trading volume can be seen at some periods of time.

![ Like_count_vs_volume_traded](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/Like_count_vs_volume_traded.png)

## Database

We used SQL query language to upload the datasets to a Postgres database. Then, using the `INNER JOIN`, we merged the two datasets to create a third dataset called *twitter_vs_stocks*. The [twitter_vs_stocks](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/twitter_vs_stocks.csv) combines the data from both datasets using the `date` as the ID. This table displays the `tokenized_text` versus the `close` amount for each date. In addition, the `change` column shows, for each date, whether the stock price has increased or decreased in comparison with the previous day’s amount after Elon Musk has posted the tweet.

## Machine Learning Models

### Latent Dirichlet Allocation (LDA) Modelling

For topic modelling in this project, we used Latent Dirichlet Allocation (LDA). The modelling procedure is divided into 4 stages: 
 - clean the data
 - create a bag of words
 - identify the number of subjects
 - run the LDA algorithm

As LDA is an unsupervised ML model, the model uses a whole dataset as input; It shouldn't be split into training and testing subsets.

After obtaining data we removed NaN values, duplicates, and any unnecessary columns, as well as formatted data types. The ```pandas``` library was used to clean the data and join the twitter datasets.
To preprocess the data for LDA, we applied a few text cleaning techniques:
-	Ignoring case; We made all words lowercase.
-	Ignoring punctuation; We tokenized text.
-	Ignoring words that don’t contain much information; We used the ```nltk``` library to get English stop words and extended the list based on available data.
-	Reducing words to their stem; We used the ```PorterStemmer``` algorithm.

Following the cleaning process, the bag of words stage was used to extract the most popular words in tweets with their counts.

<img src="https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/word_counts.png" width="150" height="200"/>

Elon Musk used 8,197 words in his tweets; an enormous number of features to analyse. However, Latent Dirichlet Allocation (LDA) is a probabilistic transformation of bag-of-words counts to a lower-dimensional topic space. It classifies the text data on a topic-by-topic basis, which means disregarding its original position in the text while maintaining its frequency. In terms of coherence score, the degree of semantic similarity between a topic's high scoring words is used to quantify its coherence. The method chooses the most frequently occurring words in each topic. The coherence score for a specific topic is then calculated by computing and aggregating all pairwise scores (UMass) for each of the words.

The average coherence score per topic for a variety of models trained with varying numbers of topics is shown below. The number of topics for which the average score reaches a peak point is the perfect balance we seek. 



<img src="https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/Coherence_score.png" width="600" height="300"/>

As a result, our best guess for the number of topics is around two. We should keep in mind that a corpus of very short documents (Elon's tweets in our case) is typically more difficult to apply to coherent models than a corpus of longer documents.

![LDA_topics](https://github.com/angkohtenko/twitter_vs_stocks/blob/angela_branch/Images/LDA_topics.png)

Although there is "Tesla" in topic 0, the remaining words are related to SpaceX and its components have a strong relationship with one another.
Topic 1 illustrates that Tesla and its components are clustered together.
So, we can admit that Elon Musk posts mainly about 2 topics: Tesla or SpaceX.

The LDA model maintains a significant number of features, however it doesn't take into account the position of a word in the sentence. It's hard to define the right number of topics as the coherence score will vary from tiny changes in the dataset. Words are often mixed between a few topics and this makes the LDA model less trusted.

### Tweet Classification Modelling

For this supervised learning model, we used the preprocessed data from the SQL database found in the tables `tesla_stocks` and `tweets_data_2010_2020.csv`. We used a SQL query to assemble a dataframe called *tweets_price*. In this dataframe, we have the *tweet, tokens of the tweet, prev_day_close, next_day_close* columns, where the data can be easily viewed. One last column called *close_price_diff* was created. It is the calculation between the **day before and the day of closing** stock price for the date the tweet was posted. This column takes into consideration *weekends* for which we do not have a closing stock price value in the dataset, and the randomness of Elon Musk's posting of tweets. We also made sure to remove from the training models any tweets that had none or less than one tokens inside them, as it ensures for more successful training of the machine learning algorithm. This table can be referenced below:

![alt text](https://github.com/angkohtenko/twitter_vs_stocks/blob/karen_branch/Images/tweets_price.png "tweets_price")

For the Classification model, we decided to use *LogisticRegression* to predict the probability that a tweet of Elon Musk will have an impact on Tesla stock or the probability this event occurs. The advantage of the *LogisticRegression* model is that it can provide us with statistical information on the tweets' significance in relation to the change of stock price. However, a limitation to this model is the assumption that there is *LogisticRegression* between the data and it is prone to overfitting.

We created a Pipeline that used the tokenized tweets via *CountVectorizer*, then *TfidfTransformer* to take into consideration the frequency of each token in the tweet compared to its frequency in the corpus/dataset, and *LogisticRegression* to learn the link between the tweets and the change in stock price. The data was split into **training and testing** sets to minimize discrepancies and ensure a good performance when it encounters unseen data. This was done by using `sklearn`'s `train_test_split` method with a `random_state` of 1 for reproducible results.

The overall accuracy of the model is **57%** which shows that the model is not able to accurately predict a link between a tweet and the change in Tesla stock price. Considering the number of variables that influence the change in stock price, and that not all of Elon Musk's tweets are directly influencing investors, this is an expected result.

However, it is to be noted that when observing the *results_test* data frame, we can see that the model is able to correctly identify the most **positive** tweets. This shows the model is able to make good **Natural Language Processing (NLP)** deduction calls on tokens and is able to learn from the data.

![alt text](https://github.com/angkohtenko/twitter_vs_stocks/blob/karen_branch/Images/predicted_proba_test.png "predicted_proba_test")

## Dashboard

A [dashboard](https://public.tableau.com/app/profile/kimberly.charbonneau/viz/TweetsvsStocks/TweetsvsStocks?publish=yes) was created using Tableau to showcase the exporatory analysis of the twitter and stock datasets. An interactive component was created whereby users can filter the graphs by year to show the changes in Tweets over time. An additional interactive component will be created with findings from the machine learning model whereby users can filter the change in stock price by a key word.

A presentation had additionally been drafted in [Google Slides.](https://docs.google.com/presentation/d/1Pb_6SnwPIEJ_NzMGAOPzZYnDsY0nk0oNaf4ZpPRE4Cg/edit#slide=id.p)
