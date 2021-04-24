const fs = require("fs");

const generateFileName = function(prefix, query) {
  const today = new Date();
  const date =
    today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
  const fileName = `responses/${prefix}-${date}-${query}.json`;
  console.log(`Looking for file: ${fileName}`);
  return fileName;
}

const saveResponse = function(path, value) {
  const jsonContent = JSON.stringify(value);
  fs.writeFileSync(path, jsonContent);
  console.log("File created");
  return JSON.parse(jsonContent);
}

module.exports = { generateFileName, saveResponse };
