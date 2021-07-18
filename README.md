# Tweeter posts analysis
## Overview of analysis
Posts in social media often cause changes in the stock market that may lead to unpredictable losses in one's investment portfolio.
In this project we analyse which words are more powerful and what influence they may have. Will they bring losses or profits to our portfolio? :moneybag:

As an example, we take tweets posted by Elon Musk and investigate how they may impact Tesla's stock prices.

Using [Twitter API](https://developer.twitter.com/en/docs/twitter-api) we collected [all posts made by Elon Musk](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tweets_data.csv) for the last year along with counts of likes, replies, quotes and retweets. All Elon's reposts and replies were excluded from analysis.

[Yahoo_fin library](http://theautomatic.net/yahoo_fin-documentation/) was used to get historical [Tesla's stock price data](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tesla_stocks.csv) for the same period. 

## Communication protocol
There are five members in our team. The role of each team member will vary every week to ensure that everyone can gain experience in different areas of the project. A Slack channel was created to support communication amongst the team, and will be used to assign tickets, provide updates, and discuss any issues. The team will additionally have meetings twice a week to go over project progress and next steps.

## Preprocessing data
<<<<<<< HEAD

The data is preprocessed in three stages. First, it begins obtaining data from various resources via API. Second, after gathering data from various sources, it begins cleaning the data by removing nan values, duplicates, determining data types, converting data types based on their types, and so on. Finally, once everything is clean, the preprocessing begins to experiment with string columns in terms of our NLP preprocessing. And it starts by lowercasing all words and removing a reasonable set of stopwords from the dataset. In addition, as you gain a better understanding of the data's structure, you can add some stop words.

In order to perform machine learning on tweets, we turned the text content into numerical feature vectors. We have used the most popular and simple method of feature extraction – bag-of-words model. We counted words and created model based on how frequently they appear. The order of the words was ignored.
=======
The ```pandas``` library was used to join the twitter datasets, as well as clean the datasets by dropping any unncessary columns and format the data types. 

In order to perform machine learning on tweets, we turned the text content into numerical feature vectors. We have used the most popular and simple method of feature extraction – the bag-of-words model. We counted words and created a model based on how frequently they appear. The order of the words was ignored.
>>>>>>> 125555c77e4ed4875776f72b2bcfadefb0a667b2
To decrease the size of the vocabulary and the number of features accordingly, we applied a few text cleaning techniques:
-	Ignoring case; We made all words lowercase.
-	Ignoring punctuation; We tokenized text.
-	Ignoring words that don’t contain much information; We used the ```nltk``` library to get English stop words and extended the list based on available data.
-	Reducing words to their stem; We used the ```PorterStemmer``` algorithm.

Count of likes, replies, retweets, and quotes were selected as features along with counted words. These metrics reflect the engagement of people, and thus may have an influence on the stock market as well.

As there were hundreds of words counted as features, we applied Principal Component Analysis (PCA) to reduce the number of features to 150. The number of components was chosen based on an explained variance ratio.

![number_of_components]()

The dataset was split into training and testing sets using the ```train_test_split``` method from the ```sklearn``` library with a standard ratio of 3:1. 

## Dashboard
A dashboard was created using Tableau to showcase the exporatory analysis of the twitter and stock datasets. An interactive component was created whereby users can filters the graphs by year to show the changes in Tweets over time. An additional interactive component will be created with findings from the machine learning model whereby users can filter the change in stock price by a key word.

The dashboard can be accessed with the following link: https://public.tableau.com/app/profile/kimberly.charbonneau/viz/TweetsvsStocks/TweetsvsStocks?publish=yes
