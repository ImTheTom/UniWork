const axios = require("axios");
const dotenv = require('dotenv');
dotenv.config();

function createDocumentsFromTweets(tweets) {
    let documentArray = [];
    let pos = 0;
    documentArray.push({
        "documents": []
    });
    for (let i = 0; i < tweets.length; i++) {
        if (i % 10 == 0 && i != 0) {
            documentArray.push({
                "documents": []
            });
            ++pos;
        }
        documentArray[pos].documents.push({
            id: tweets[i].id,
            language: "en", // Hard code this for now
            text: String(tweets[i].text)
        });
    }
    return documentArray;
}

function headers_for_microsoft_text_analytics() {
    return {
        headers: {
            "x-rapidapi-host": "microsoft-text-analytics1.p.rapidapi.com",
            "x-rapidapi-key": process.env.RAPIDAPI_KEY,
        }
    }
}


async function fetchSentimentAnalysis(allDocuments) {
    let sentiments = [];
    for (let i = 0; i < allDocuments.length; ++i) {
        let subSentiments = await SentimentAnalysisAPI(allDocuments[i].documents);
        sentiments.push(subSentiments);
    }
    let combinedSentiments = [];
    for (let i = 0; i < sentiments.length; ++i) {
        for (let j = 0; j < sentiments[i].sentiment.length; ++j) {
            combinedSentiments.push(sentiments[i].sentiment[j]);
        }
    }
    return combinedSentiments;

}

// a maximum of 10 documents
async function SentimentAnalysisAPI(documents) {
    //console.log(documents.documents);
    return Promise.resolve(axios.post("https://microsoft-text-analytics1.p.rapidapi.com/sentiment", {
                "documents": documents
            },
            headers_for_microsoft_text_analytics()
        )
        .then((response) => {
            let response_data = createJsonFromSentimentResponse(response.data)
            return response_data;

        })
        .catch((error) => {
            console.log("sentiment error");
            return null
        }));
};

function createJsonFromSentimentResponse(response) {
    let sentiment = [];
    for (let i = 0; i < response.documents.length; i++) {
        sentiment.push({
            id: response.documents[i].id,
            sentiment: response.documents[i].sentiment,
        });
    }
    return {
        "sentiment": sentiment
    }
}

module.exports = {
    fetchSentimentAnalysis,
    createDocumentsFromTweets
}