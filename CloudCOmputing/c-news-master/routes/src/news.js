const { default: Axios } = require("axios");
const Sentiment = require("sentiment");
const fs = require("fs");
require("dotenv").config();
const fileHelper = require("./file.js")

const fetchNewsData = function (query, url) {
  const fileName = fileHelper.generateFileName("news", query);

  if (fs.existsSync(fileName)) {
    console.log("file exists");
    const data = fs.readFileSync(fileName);
    return JSON.parse(data);
  } else {
    console.log("file does not exist"); // Need to fetch and save response
    return Axios.get(url, {
      headers: { "Ocp-Apim-Subscription-Key": process.env.BING_KEY },
    })
      .then((response) => {
        return fileHelper.saveResponse(fileName, response.data);
      })
      .catch((error) => {
        console.log(error);
        return {};
      });
    return {};
  }
  return {};
};

const createFullArticleJson = function (value) {
  const articles = pullOutInfo(value);
  const data = addSentimentAnalysisAndFormat(articles);
  return data;
};

function pullOutInfo(value) {
  let articles = [];
  for (let i = 0; i < value.length; i++) {
    articles.push({
      name: value[i].name,
      url: value[i].url,
      description: value[i].description,
      published: new Date(value[i].datePublished),
    });
  }
  return articles;
}

function addSentimentAnalysisAndFormat(articles) {
  const sentiment = new Sentiment();
  const positive = [];
  const negative = [];
  const indifferent = [];
  for (let i = 0; i < articles.length; i++) {
    const result = sentiment.analyze(articles[i].description);
    if (result.score > 0) {
      positive.push(i);
    } else if (result.score < 0) {
      negative.push(i);
    } else {
      indifferent.push(i);
    }
  }

  data = {
    articles: articles,
    total: articles.length,
    sentiment: {
      positive: {
        articles: positive,
        count: positive.length,
      },
      negative: {
        articles: negative,
        count: negative.length,
      },
      indifferent: {
        articles: indifferent,
        count: indifferent.length,
      },
    },
  };
  return data;
}

module.exports = { fetchNewsData, createFullArticleJson };
