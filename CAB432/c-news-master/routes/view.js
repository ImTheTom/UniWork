const express = require("express");
const { default: Axios } = require("axios");
const router = express.Router();

router.get("/", function (req, res, next) {
  const query = req.query.query.trim();
  const type = req.query.type.trim();
  const url = `http://localhost:3000/api/full?query=${query}&type=${type}`;
  console.log(`Fetching view with url: ${url}`);
  Axios.get(url).then(
    (response) => {
      res.render("view", response.data);
    },
    (error) => {
      res.render("error");
    }
  );
});

module.exports = router;
