# Tweeter posts analysis
## Overview of analysis
Posts in social media often cause changes in stock market that may lead to unpredictable losses in investment portfolio.
In this project we analyse which words are more powerful and what influence they may have. Will they bring losses or profits to our portfolio? :moneybag:

As an example, we take tweets posted by Elon Musk and investigate how they may impact on Tesla's stock prices. 

Using [Twitter API](https://developer.twitter.com/en/docs/twitter-api) we collected [all posts made by Elon Musk](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tweets_data.csv) for the last year along with counts of likes, replies, quotes and retweets. All Elon's reposts and replies were excluded from analysis.

[Yahoo_fin library](http://theautomatic.net/yahoo_fin-documentation/) was used to get historical [Tesla's stock price data](https://github.com/angkohtenko/twitter_vs_stocks/blob/main/Data/tesla_stocks.csv) for the same period. 

## Communication protocol
There are 5 members in a team. The role of each team member varies every week to ensure that everyone tries different kind of tasks. Slack channel was created to support communication in a team: assign tickets, provide updates and message for any issues. Also, the team has meetings twice a week to go over the progress and next steps.
