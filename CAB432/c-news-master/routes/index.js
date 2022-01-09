const express = require("express");
const router = express.Router();
const { default: Axios } = require("axios");

router.get("/", function (req, res, next) {
  const protocol = req.protocol;
  const host = req.headers.host;
  const url = `http://localhost:3000/api/coins_initial?protocol=${protocol}&host=${host}`;
  console.log(`Fetching index with url: ${url}`);
  Axios.get(url)
    .then((response) => {
      res.render("index", response.data);
    })
    .catch((err) => {
      res.render("error");
    });
});

router.get("/search", function (req, res, next) {
  const query = req.query.query.trim();
  const protocol = req.protocol;
  const host = req.headers.host;
  const url = `http://localhost:3000/api/stock_search?query=${query}&protocol=${protocol}&host=${host}`;
  console.log(`Fetching search with url: ${url}`);
  Axios.get(url)
    .then((response) => {
      res.render("search", response.data);
    })
    .catch((err) => {
      res.render("error");
    });
});

router.get("/about", function (req, res, next) {
  res.render("about");
});

module.exports = router;
