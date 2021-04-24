const express = require("express");
const router = express.Router();
const configHelper = require("./src/config")
require("dotenv").config();

router.get("/healthz", function (req, res, next) {
  return res.status(200).json({
    healthz: "yes",
  });
});

router.get("/", function (req, res, next) {
  return res.status(200).json(configHelper.fetchCurrentConfig());
});


router.get("/files", function (req, res, next) {
  return res.status(200).json(configHelper.fetchCurrentResponses());
});

router.delete("/files", function (req, res, next) {
  return res.status(200).json(configHelper.deleteCurrentResponses());
});

module.exports = router;
