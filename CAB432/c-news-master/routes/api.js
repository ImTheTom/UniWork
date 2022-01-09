const express = require("express");
const { default: Axios } = require("axios");
const coinHelper = require("./src/coin.js");
const newsHelper = require("./src/news.js");
const combineHelper = require("./src/combine.js");
const trendsHelper = require("./src/trends.js");
const stockHelper = require("./src/stock.js");
const router = express.Router();
require("dotenv").config();

const fetchCoin = function (req) {
  const query = req.query.query.trim();
  const url = coinHelper.generateCoinUrl(query);

  return Axios.get(url)
    .then((response) => {
      return (resultJson = coinHelper.createFullCoinJsonFromResponse(
        response.data.prices
      ));
    })
    .catch((err) => {
      return err;
    });
};

router.get("/coins", function (req, res, next) {
  Promise.resolve(fetchCoin(req)).then(function (data) {
    return res.status(200).json(data);
  });
});

router.get("/stock_search", function (req, res, next) {
  const query = req.query.query.trim();
  const url = `https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=${query}&apikey=${process.env.ALPHA_VANTAGE_KEY}`;
  const protocol = req.query.protocol.trim();
  const host = req.query.host.trim();

  return Axios.get(url)
    .then((response) => {
      console.log(response.data);
      let results = stockHelper.createSearchResponse(response.data, protocol, host);
      console.log(results)
      return res.status(200).json({
        name: query,
        stocks: results
      });
    })
    .catch((err) => {
      return res.status(500).json({});
    });
});

router.get("/stocks", function (req, res, next) {
  const query = req.query.query.trim();
  const url = `https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=${query}&apikey=${process.env.ALPHA_VANTAGE_KEY}`;

  Promise.resolve(stockHelper.fetchStockData(query, url)).then(function (data) {
    data = coinHelper.createFullStockJsonFromResponse(
      data["Time Series (Daily)"]
    );
    return res.status(200).json(data);
  });
});

router.get("/healthz", function (req, res, next) {
  return res.status(200).json({
    healthz: "yes",
  });
});

router.get("/news", function (req, res, next) {
  const query = req.query.query.trim();
  const url = `https://api.cognitive.microsoft.com/bing/v7.0/news/search?count=100&q=${query}&cc=us&category=business&freshness=month`;

  Promise.resolve(newsHelper.fetchNewsData(query, url)).then(function (data) {
    data = newsHelper.createFullArticleJson(data.value);
    return res.status(200).json(data);
  });
});

router.get("/full", function (req, res, next) {
  const query = req.query.query.trim();
  const type = req.query.type.trim();

  const newsUrl = `https://api.cognitive.microsoft.com/bing/v7.0/news/search?count=100&q=${query}&cc=us&category=business&freshness=month`;

  if (type == "crypto") {
    Promise.resolve(fetchCoin(req)).then(function (coinData) {
      Promise.resolve(newsHelper.fetchNewsData(query, newsUrl))
        .then(function (data) {
          data = newsHelper.createFullArticleJson(data.value);
          const fullResponse = combineHelper.createEntireJsonResponse(
            query,
            coinData,
            data
          );
          return res.status(200).json(fullResponse);
        })
        .catch((err) => {
          return res.status(500).json({});
        });
    });
  } else if (type == "stock") {
    const url = `https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=${query}&apikey=${process.env.ALPHA_VANTAGE_KEY}`;

    Promise.resolve(stockHelper.fetchStockData(query, url))
      .then(function (stockData) {
        stockData = coinHelper.createFullStockJsonFromResponse(
          stockData["Time Series (Daily)"]
        );
        Promise.resolve(newsHelper.fetchNewsData(query, newsUrl))
          .then(function (data) {
            data = newsHelper.createFullArticleJson(data.value);
            const fullResponse = combineHelper.createEntireJsonResponse(
              query,
              stockData,
              data
            );
            return res.status(200).json(fullResponse);
          })
          .catch((err) => {
            return res.status(500).json({});
          });
      })
      .catch((err) => {
        return res.status(500).json({});
      });;
  } else {
    return res.status(404).json("NOT FOUND");
  }
});

router.get("/coins_initial", function (req, res, next) {
  // Fetch and generate dynamic options on the index page
  const url = `https://api.coingecko.com/api/v3/search/trending`;
  const protocol = req.query.protocol.trim();
  const host = req.query.host.trim();

  return Axios.all([Axios.get(url), Axios.get(`https://type.fit/api/quotes`)])
    .then(
      Axios.spread((firstResponse, secondResponse) => {
        return res
          .status(200)
          .json(
            trendsHelper.createFullJsonFromResponse(
              firstResponse.data,
              protocol,
              host,
              secondResponse.data
            )
          );
      })
    )
    .catch((err) => {
      return res.status(500).json({
        coins: [],
      });
    });
});

module.exports = router;
