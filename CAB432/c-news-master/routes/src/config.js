var fs = require("fs");
require("dotenv").config();

function getCurrentResponses() {
    var files = fs.readdirSync("responses/");
    return files.filter((a) => a[0] !== ".");
}

function deleteFile(name) {
    let fileName = 'responses/' + name;
    try {
        fs.unlinkSync(fileName);
        console.log(`DELETED file ${fileName}`);
    } catch (error) {
        console.log(`Could not delete file ${fileName} with error`);
    }
}

String.prototype.replaceAt = function (index, replacement) {
  return (
    this.substr(0, index) +
    replacement +
    this.substr(index + replacement.length)
  );
};

function maskKey(key) {
  let shortened = key.substring(0, 10);
  for(let i = 3; i < 7; i++) {
      shortened = shortened.replaceAt(i, "X");
  }
  return shortened;
}

function getKeys() {
    bingKeyHashed = maskKey(process.env.BING_KEY);
    alphaKeyHashed = maskKey(process.env.ALPHA_VANTAGE_KEY);
    return {
      BING_NEWS: bingKeyHashed,
      ALPHA_VANTAGE: alphaKeyHashed,
    };
}

const fetchCurrentResponses = function() {
    return { files: getCurrentResponses ()};
}

const deleteCurrentResponses = function () {
  let files = getCurrentResponses();
  files.forEach(deleteFile);
  files = getCurrentResponses();
  return { files: files };
};

const fetchCurrentConfig = function () {
    return {
        keys: getKeys(),
        files: getCurrentResponses(),
    };
}

module.exports = {
  fetchCurrentResponses,
  deleteCurrentResponses,
  fetchCurrentConfig,
};