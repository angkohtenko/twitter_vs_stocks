# Twitter versus Stocks Analysis

## Overview of analysis
Posts in social media often cause changes in the stock market that may lead to unpredictable losses in one's investment portfolio.
In this project we analyse which words are more powerful and what influence they may have. Will they bring losses or profits to our portfolio? :moneybag:

As an example, we take tweets posted by Elon Musk and investigate how they may impact Tesla's stock prices.

Using [Twitter API](https://developer.twitter.com/en/docs/twitter-api) we collected [all posts made by Elon Musk](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tweets_data.csv) for the last year along with counts of likes, replies, and retweets. All Elon's reposts and replies were excluded from analysis.

[Yahoo_fin library](http://theautomatic.net/yahoo_fin-documentation/) was used to get historical [Tesla's stock price data](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tesla_stocks.csv) for the same period. 

## Communication protocol
There are five members in our team. The role of each team member will vary every week to ensure that everyone can gain experience in different areas of the project. A Slack channel was created to support communication amongst the team, and will be used to assign tickets, provide updates, and discuss any issues. The team will additionally have meetings twice a week to go over project progress and next steps.

## Preprocessing data
The data was preprocessed in three stages. First, data were obtained from various resources as stated above. Second, the data were cleaned by removing NaN values, duplicates, and any unnecessary columns, as well as formatting data types. The ```pandas``` library was used clean the data and join the twitter datasets. Finally, once everything was cleaned, NLP preprocessing was undetaken to experiment with string columns.

In order to perform machine learning on tweets, we turned the text content into numerical feature vectors. We have used the most popular and simple method of feature extraction – the bag-of-words model. We counted words and created a model based on how frequently they appear. The order of the words was ignored.
To decrease the size of the vocabulary and the number of features accordingly, we applied a few text cleaning techniques:
-	Ignoring case; We made all words lowercase.
-	Ignoring punctuation; We tokenized text.
-	Ignoring words that don’t contain much information; We used the ```nltk``` library to get English stop words and extended the list based on available data.
-	Reducing words to their stem; We used the ```PorterStemmer``` algorithm.

Count of likes, replies, and retweets were selected as features along with counted words. These metrics reflect the engagement of people, and thus may have an influence on the stock market as well.

As there were hundreds of words counted as features, we applied Principal Component Analysis (PCA) to reduce the number of features to 150. The number of components was chosen based on an explained variance ratio.

The dataset was split into training and testing sets using the ```train_test_split``` method from the ```sklearn``` library with a standard ratio of 3:1. 

## Machine Learning Models

### Latent Dirichlet Allocation (LDA) Modelling

For topic modelling in this project, we used Latent Dirichlet Allocation (LDA). The modelling procedure is divided into four stages. The first step is to clean the data, followed by creating a bag of words, identifying the number of subjects, and finally running the LDA algorithm. 

As previously stated, the data requires cleaning, which includes preparing to remove stop words and tokenize each word. Following the cleaning process, the bag of words stage begins. It is now time to classify the text data on a topic-by-topic basis, which means disregarding its original position in the text while maintaining its frequency. LDA (Latent Dirichlet Allocation) is then a probabilistic transformation of bag-of-words counts to a lower-dimensional topic space. Tweets are regarded as a form of subject distribution. Topics are indicated by the distribution of all terms in the vocabulary. Following that, run the LDA algorithm to determine the number of topics. We chose 5 topics because they were near the top of the list. As a result, we can see that we have five topics with varying correlations.

Topic-1, for example, demonstrates that Tesla and its components have a strong relationship with one another, and almost all of the words in topic-1 are about Tesla production. However, topic-2 illustrates that spaceX and its components are clustered together. It is obvious that it promotes space research. Finally, statistical modelling clearly helps in determining what Elon Musk tweets about. This project's code can be used for a variety of other tasks, such as identifying abstract subjects in a collection of documents.

### Tweet Classification Modelling

For this model, we used the preprocessed data from the `twitter_vs_stocks.csv` and created a new table called *tweets_price* with the *tweet, tokens of the tweet, prev_day_close, next_day_close* and the calculation between the **day before and the day of closing** stock price for the date the tweet was posted under the *close_price_diff column*. This is to take into consideration for *weekends* which do not have a closing stock price value in the dataset, and the randomness of Elon Musk's posting of tweets. We also made sure to remove from the training models any tweets that had no tokens inside them, or had less than one, as it ensures for more successful training of the machine learning algorithm. This table can be referenced below:

![alt text](# "tweets_price")

For the Classification model, we created a Pipeline that used the tokenized tweets via *CountVectorizer*, then *TfidfTransformer* to take into consideration the frequency of each token, and *LogisticRegression* to find the correlation between the tweets and the change in stock price. 

The overall accuracy of the model is **0.57%** which shows that the model is not able to accurately find a correlation between a tweet and the change in Tesla stock. Considering the number of variables that influence the change in stock price this is an expected result, as not all of Elon Musk's tweets are directly influencing investors and are not the only factors that influence the stock market. 

However, it is to be noted that when reading the *results_test* dataframe, the model is able to classify which tweets are **positive** which shows the machine is able to make good **NLP** deduction calls on tokens and is learning from the data. 

![alt text](# "predicted_proba_test")

## Database

We used SQL query language to upload the datasets to a Postgres database. Then, using the `INNER JOIN`, we merged the two datasets to create a third dataset called *twitter_vs_stocks*. The *twitter_vs_stocks* combines the data from both datasets using the `date` as the ID. This table displays the `tokenized_text` versus the `close` amount for each date. In addition, the `change` column shows, for each date, whether the stock price has increased or decreased in comparison with the previous day’s amount after Elon Musk has posted the tweet.

## Dashboard

A [dashboard](https://public.tableau.com/app/profile/kimberly.charbonneau/viz/TweetsvsStocks/TweetsvsStocks?publish=yes) was created using Tableau to showcase the exporatory analysis of the twitter and stock datasets. An interactive component was created whereby users can filters the graphs by year to show the changes in Tweets over time. An additional interactive component will be created with findings from the machine learning model whereby users can filter the change in stock price by a key word.

A presentation had additionally been drafted in [Google Slides.](https://docs.google.com/presentation/d/1Pb_6SnwPIEJ_NzMGAOPzZYnDsY0nk0oNaf4ZpPRE4Cg/edit#slide=id.ge523cfaeaa_0_3)
