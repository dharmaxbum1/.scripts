#! /usr/bin/env python

import tweepy

# Authentication credentials - dev.twitter.com
cfg = {
    'consumer_key': 'REPLACE',
    'consumer_secret': 'REPLACE',
    'access_token': 'REPLACE',
    'access_token_secret': 'REPLACE'
}


def get_api_handler(cfg):
    auth = tweepy.OAuthHandler(cfg['consumer_key'], cfg['consumer_secret'])
    auth.set_access_token(cfg['access_token'], cfg['access_token_secret'])
    return tweepy.API(auth)


def main():
    api = get_api_handler(cfg)
    tweet = input('')
    api.update_status(status=tweet)


if __name__ == "__main__":
	main()
