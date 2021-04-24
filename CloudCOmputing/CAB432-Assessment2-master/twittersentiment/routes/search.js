const express = require('express');
const router = express.Router();
const serverScriptModule = require('.././public/javascripts/serverScript.js')
const credentials = require('../credentials.json');
const sent = require('./sent.js');
const dotenv = require('dotenv');
const redis = require('redis');
const AWS = require('aws-sdk');
const Twit = require("twit");

dotenv.config();

const TwitterAPI = new Twit({
    consumer_key: credentials.twitterAPI.consumer_key,
    consumer_secret: credentials.twitterAPI.consumer_secret,
    access_token: credentials.twitterAPI.access_token,
    access_token_secret: credentials.twitterAPI.access_token_secret
});

const redisClient = redis.createClient();
redisClient.on('error', (err) => {
    console.log("Error " + err);
});

const bucketName = 'n9702351-assessment-store';
const bucketPromise = new AWS.S3({
    apiVersion: '2006-03-01'
}).createBucket({
    Bucket: bucketName
}).promise();

bucketPromise.then(function(data) {
    console.log("Successfully created " + bucketName);
}).catch(function(err) {
    console.error("error happened ignoring probably cause we already own it");
})

/*
// create bucket - markus
const bucketName = 'markushfossnes-store';

// Create a promise on S3 service object
const bucketPromise = new AWS.S3({apiVersion: '2006-03-01'}).createBucket({Bucket: bucketName}).promise();
bucketPromise.then(function(data) {
    console.log("Successfully created " + bucketName);
})
.catch(function(err) {
    //console.error(err, err.stack);
    console.log("i already own this bucket");
});
*/

// This array holds all tweets for all hastags searched for
// the idea is to save this to cache or a bucket or something
let tweetLibrary = [];

// template book object
let bookTemplate = {
    hashtag: "",
    lastUpdated: 0,
    sampleSize: 0,
    positiveCount: 0,
    negativeCount: 0,
    mixedCount: 0,
    neutralCount: 0,
    latestTweets: []
};

function createNewBook(hashtag, tweets, sentiment, keyWords) {
    let book = {
        hashtag: "",
        lastUpdated: 0,
        updateInterval: 0,
        sampleSize: 0,
        positiveCount: 0,
        negativeCount: 0,
        mixedCount: 0,
        neutralCount: 0,
        latestTweets: []
    };
    book.hashtag = hashtag;
    book.lastUpdated = Date.now();
    book.sampleSize = sentiment.length;
    let sentimentCounts = countSentiment(sentiment);
    book.positiveCount = sentimentCounts.positive;
    book.negativeCount = sentimentCounts.negative;
    book.mixedCount = sentimentCounts.mixed;
    book.neutralCount = sentimentCounts.neutral;
    book.latestTweets = save5LatestTweets(tweets, sentiment, keyWords);
    book.updateInterval = getUpdateInterval(book.latestTweets);
    return book;
}

async function updateBook(book, tweets) {
    let newTweets = getNewTweets(book.lastUpdated, tweets);
    let documents = await sent.createDocumentsFromTweets(newTweets);
    let newSentiment = await sent.fetchSentimentAnalysis(documents);
    let updatedBook = book;

    updatedBook.lastUpdated = Date.now();
    updatedBook.sampleSize += newSentiment.length;
    let sentimentCounts = countSentiment(newSentiment);
    updatedBook.positiveCount += sentimentCounts.positive;
    updatedBook.negativeCount += sentimentCounts.negative;
    updatedBook.mixedCount += sentimentCounts.mixed;
    updatedBook.neutralCount += sentimentCounts.neutral;
    updatedBook.latestTweets = updateLatestTweets(book.latestTweets, newTweets, newSentiment);
    updatedBook.updateInterval = getUpdateInterval(updatedBook.latestTweets);
    return updatedBook;
}

function needsUpdate(book) {
    let needsUpdate = false;
    if (book.lastUpdated + book.updateInterval < Date.now()) needsUpdate = true;
    return needsUpdate;
}

function getUpdateInterval(tweets) {
    let total = 0;
    for (let i = 0; i < tweets.length - 1; ++i) {
        let t1 = Date.parse(tweets[i].date);
        let t2 = Date.parse(tweets[i + 1].date);
        total += t1 - t2;
    }
    // Cap the update interval at 5 min, no longer than that.
    if (total > 300000) total = 300000;
    else if (total < 10000) total = 10000;
    return total;
}

// decides if a tweet is newer than the threshold
function tweetIsNew(threshold, tweet) {
    let tweetdate = Date.parse(tweet.date);
    if (tweetdate > threshold) return true;
    else return false;
}

// This function sorts out the tweets created before the given date and returns only the latest tweets
function getNewTweets(date, tweets) {
    let newTweets = [];
    for (let i = 0; i < tweets.length; ++i) {
        if (tweetIsNew(date, tweets[i])) {
            newTweets.push(tweets[i]);
        } else break;
    }
    return newTweets;
}

function countSentiment(sentiment) {
    sentimentCounts = {
        positive: 0,
        negative: 0,
        mixed: 0,
        neutral: 0,
    };

    for (let i = 0; i < sentiment.length; ++i) {
        if (sentiment[i].sentiment == "neutral") ++sentimentCounts.neutral;
        else if (sentiment[i].sentiment == "mixed") ++sentimentCounts.mixed;
        else if (sentiment[i].sentiment == "positive") ++sentimentCounts.positive;
        else if (sentiment[i].sentiment == "negative") ++sentimentCounts.negative;
    };
    return sentimentCounts;
}

// function that adds sentiment and keywords to the 5 latest tweets and returns them
function save5LatestTweets(tweets, sentiment, keywords) {
    let latestTweets = [];
    for (let i = 0; i < Math.min(tweets.length, 5); ++i) {
        for (let j = 0; j < sentiment.length; ++j) {
            if (sentiment[j].id == tweets[i].id) { // they are in order so this is just a double check
                tweets[i].sentiment = sentiment[j].sentiment;
                break;
            }
        }
        for (let j = 0; j < keywords.length; ++j) {
            if (keywords[j].id == tweets[i].id) { // they are in order so this is just a double check
                tweets[i].keywords = keywords[j].key_words;
                break;
            }
        }
        latestTweets.push(tweets[i]);
    }
    return latestTweets;
}

// this function makes sure there always are 5 tweets to be displayed
// even if there are less than 5 new tweets, it will re-use old ones
function updateLatestTweets(oldTweets, newTweets, newSentiment) {
    let latestTweets = [];
    console.log("new tweets");
    console.log(newTweets);
    for (let i = 0; i < Math.min(newTweets.length, 5); ++i) {
        for (let j = 0; j < newSentiment.length; ++j) {
            if (newSentiment[j].id == newTweets[i].id) { // they are in order so this is just a double check
                newTweets[i].sentiment = newSentiment[j].sentiment;
                break;
            }
        }
        latestTweets.push(newTweets[i]);
    }
    if (latestTweets.length < 5) {
        for (let i = 0; i < 5 - latestTweets.length; ++i) {
            latestTweets.push(oldTweets[i]);
        }
    }
    return latestTweets;
}

// This function takes a status object from the twitter API and creates a tweet object
function createTweetObject(status) {
    let tweet = {
        id: status.id,
        date: serverScriptModule.parseTweetDate(status.created_at),
        sentiment: 'neutral',
        name: status.user.name,
        text: String(status.full_text),
        keywords: []
    };
    return tweet;
}

async function getTweetsFromAPI(tag) {
    let tweetsArray = [];
    let response = await TwitterAPI.get('search/tweets', {
        q: tag,
        count: 100,
        lang: "en",
        tweet_mode: "extended"
    }).catch(() => {
        return null
    });
    if (response == null) {
        console.log("There was an error with the twitter API");
        return null;
    }

    let statuses = response.data.statuses;

    if (response.data.statuses.length == 0) {
        console.log("no tweets with that hashtag"); // this needs to show an error and go back to the search page
        return null;
    };
    for (let i = 0; i < statuses.length; ++i) {
        if (statuses[i].in_reply_to_status_id != null) continue;
        let tweet = createTweetObject(statuses[i]);
        tweetsArray.push(tweet);
    };
    return tweetsArray;
};

/* GET home page. */
router.get('/:hashtag', async (req, res) => {
    let tag = "#" + req.params.hashtag;

    const redisKey = `hashtag:${tag}`;
    const s3Key = `hashtag:${tag}`;

    // Check S3
    const params = {
        Bucket: bucketName,
        Key: s3Key
    };

    // Try fetching the result from Redis first in case we have it cached
    return redisClient.get(redisKey, async (err, result) => {
        // If that key exist in Redis store
        console.log("trying redis");
        if (result) {
            let redisBook = JSON.parse(result);
            console.log("Result from redis");
            //console.log(redisBook);

            if (needsUpdate(redisBook)) {
                console.log("Updating book");
                let tweetsArray = await getTweetsFromAPI(tag);

                if (tweetsArray == null) {
                    console.log("Couldn't get tweets from API");
                    res.render('error', {
                        title: 'TwitterSentiment - ' + tag,
                        status: "Twitter API error",
                        stack: "Looks like there are no tweets with that hashtag"
                    });
                    return;
                }
                redisBook = await updateBook(redisBook, tweetsArray);

                // Update the book in the redis cache
                redisClient.setex(redisKey, 60, JSON.stringify({
                    source: 'Redis Cache',
                    ...redisBook,
                }));;
                // Update the book in the bucket
                const body = JSON.stringify({
                    source: 'S3 Bucket',
                    ...redisBook
                });
                const objectParams = {
                    Bucket: bucketName,
                    Key: s3Key,
                    Body: body
                };
                const uploadPromise = new AWS.S3({
                    apiVersion: '2006-03-01'
                }).putObject(objectParams).promise();
                uploadPromise.then(function(data) {
                    console.log("Successfully uploaded data to " + bucketName + "/" + s3Key);
                });

            }
            console.log("Serving from redis");
            return res.render('results', {
                title: 'TwitterSentiment - ' + tag,
                hashtag: tag,
                book: redisBook,
                fs: {
                    serverScriptModule
                }
            });
        } else {
            console.log("Not found in redis");
            console.log("Trying bucket");
            return new AWS.S3({
                apiVersion: '2006-03-01'
            }).getObject(params, async (err, result) => {
                if (result) {
                    // Serve from S3
                    //console.log(result);
                    console.log("Retreiving from bucket");
                    let bucketBook = JSON.parse(result.Body);

                    console.log("Result from bucket");
                    console.log(bucketBook);

                    // Check if the book needs updating
                    if (needsUpdate(bucketBook)) {
                        console.log("Updating book");
                        let tweetsArray = await getTweetsFromAPI(tag); // this works

                        if (tweetsArray == null) {
                            console.log("Couldn't get tweets from API");
                            res.render('error', {
                                title: 'TwitterSentiment - ' + tag,
                                status: "Twitter API error",
                                stack: "Looks like there are no tweets with that hashtag"
                            });
                            return;
                        }
                        bucketBook = await updateBook(bucketBook, tweetsArray);

                        // Update the book in the bucket
                        const body = JSON.stringify({
                            source: 'S3 Bucket',
                            ...bucketBook
                        });
                        const objectParams = {
                            Bucket: bucketName,
                            Key: s3Key,
                            Body: body
                        };
                        const uploadPromise = new AWS.S3({
                            apiVersion: '2006-03-01'
                        }).putObject(objectParams).promise();
                        uploadPromise.then(function(data) {
                            console.log("Successfully uploaded data to " + bucketName + "/" + s3Key);
                        });

                    }

                    console.log("Saving result to redis");
                    // save result to resis cache
                    redisClient.setex(redisKey, 60, JSON.stringify({
                        source: 'Redis Cache',
                        ...bucketBook,
                    }));

                    console.log("Serving from bucket");
                    return res.render('results', {
                        title: 'TwitterSentiment - ' + tag,
                        hashtag: tag,
                        book: bucketBook,
                        fs: {
                            serverScriptModule
                        }
                    });

                } else {
                    console.log("Not found in bucket");
                    console.log("Trying web");

                    // Serve from Twitter API and store in S3
                    let tweetsArray = await getTweetsFromAPI(tag); // this works

                    // Check if request was sucessful
                    if (tweetsArray == null) {
                        console.log("Couldn't get tweets from API");
                        res.render('error', {
                            title: 'TwitterSentiment - ' + tag,
                            status: "Twitter API error",
                            stack: "Looks like there are no tweets with that hashtag"
                        });
                        return;
                    }

                    // Fetch sentiment analysis
                    let documents = await sent.createDocumentsFromTweets(tweetsArray)
                    let sentiment = await sent.fetchSentimentAnalysis(documents);

                    // Create book
                    let book = await createNewBook(tag, tweetsArray, sentiment, [""]);


                    // save to redis
                    console.log("Saving to redis");
                    redisClient.setex(redisKey, 60, JSON.stringify({
                        source: 'Redis Cache',
                        ...book,
                    }));

                    // save to bucket
                    console.log("Saving to bucket");
                    const body = JSON.stringify({
                        source: 'S3 Bucket',
                        ...book
                    });
                    const objectParams = {
                        Bucket: bucketName,
                        Key: s3Key,
                        Body: body
                    };
                    const uploadPromise = new AWS.S3({
                        apiVersion: '2006-03-01'
                    }).putObject(objectParams).promise();
                    uploadPromise.then(function(data) {
                        console.log("Successfully uploaded data to " + bucketName + "/" + s3Key);
                    });

                    console.log("Serving from web")
                    return res.render('results', {
                        title: 'TwitterSentiment - ' + tag,
                        hashtag: tag,
                        book: book,
                        fs: {
                            serverScriptModule
                        }
                    });
                }
            });
        }
    });
});

module.exports = router;