import twitter
import json
import os

# load api keys
consumer_key = os.environ["TestTwitterApp_Consumer_Key"]
consumer_secret = os.environ["TestTwitterApp_Consumer_Secret"]
access_token = os.environ["TestTwitterApp_Access_Key"]
access_token_secret = os.environ["TestTwitterApp_Access_Secret"]

# connect with twitter api
api = twitter.Api(consumer_key=consumer_key,
                  consumer_secret=consumer_secret,
                  access_token_key=access_token,
                  access_token_secret=access_token_secret)

## FOLLOWING FUNCTION WILL COLLECT REAL-TIME TWEETS IN OUR COMPUTER

# data returned will be for any tweet mentioning strings in the list FILTER
FILTER = [':)']

# Languages to filter tweets by is a list. This will be joined by Twitter
# to return data mentioning tweets only in the english language.
LANGUAGES = ['en']

# Specify where the tweets are from
# e.g.: LOCATIONS = ['-79.506683','43.972928','-79.429779','44.015781'] # Bound box lon/lat for Aurora ON, Canada
LOCATIONS = []

def main():
    with open('stream_smile_emo_tweets.txt', 'a') as f:
        # api.GetStreamFilter will return a generator that yields one status
        # message (i.e., Tweet) at a time as a JSON dictionary.
        for line in api.GetStreamFilter(track=FILTER, locations=LOCATIONS, languages=LANGUAGES):
            f.write(json.dumps(line))
            f.write('\n')
            
if __name__ == "__main__":
    main()