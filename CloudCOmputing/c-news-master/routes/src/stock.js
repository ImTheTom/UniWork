const fileHelper = require("./file.js");
const { default: Axios } = require("axios");
const fs = require("fs");

const fetchStockData = function (query, url) {
  const fileName = fileHelper.generateFileName("stock", query);

  if (fs.existsSync(fileName)) {
    console.log("file exists");
    const data = fs.readFileSync(fileName);
    return JSON.parse(data);
  } else {
    console.log("file does not exist"); // Need to fetch and save response
    return Axios.get(url)
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

const createSearchResponse = function (response, protocol, host) {
  let searchResponse = [];
  for(let i = 0; i < response.bestMatches.length; i++) {
    searchResponse.push({
      name: response.bestMatches[i]["2. name"],
      id: response.bestMatches[i]["1. symbol"],
      url: `${protocol}://${host}/view?query=${response.bestMatches[i]["1. symbol"]}&type=stock`,
    });
  }
  return searchResponse
}

module.exports = { fetchStockData, createSearchResponse };