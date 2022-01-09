function createIndexCoinOptionsFromResponse(response, protocol, host) {
  const trends = [];
  for (let i = 0; i < response.coins.length; i++) {
    const item = response.coins[i].item;
    trends.push({
      name: item.name,
      id: item.id,
      url: `${protocol}://${host}/view?query=${item.id}&type=crypto`,
    });
  }
  return trends;
}

function getTopCoins(protocol, host) {
  const coins = [
    {
      name: "Bitcoin",
      id: "bitcoin",
      url: `${protocol}://${host}/view?query=bitcoin&type=crypto`,
    },
    {
      name: "Ethereum",
      id: "ethereum",
      url: `${protocol}://${host}/view?query=ethereum&type=crypto`,
    },
    {
      name: "Tether",
      id: "tether",
      url: `${protocol}://${host}/view?query=tether&type=crypto`,
    },
    {
      name: "Xrp",
      id: "ripple",
      url: `${protocol}://${host}/view?query=ripple&type=crypto`,
    },
    {
      name: "Bitcoin Cash",
      id: "bitcoin-cash",
      url: `${protocol}://${host}/view?query=bitcoin-cash&type=crypto`,
    },
    {
      name: "Litecoin",
      id: "litecoin",
      url: `${protocol}://${host}/view?query=litecoin&type=crypto`,
    },
    {
      name: "Dogecoin",
      id: "dogecoin",
      url: `${protocol}://${host}/view?query=dogecoin&type=crypto`,
    },
  ];
  return coins;
}

function getStockOptions(protocol, host) {
  const stocks = [
    {
      name: "IBM",
      id: "IBM",
      url: `${protocol}://${host}/view?query=IBM&type=stock`,
    },
    {
      name: "Amazon",
      id: "AMZN",
      url: `${protocol}://${host}/view?query=AMZN&type=stock`,
    },
    {
      name: "Facebook",
      id: "FB",
      url: `${protocol}://${host}/view?query=FB&type=stock`,
    },
    {
      name: "Twitter",
      id: "TWTR",
      url: `${protocol}://${host}/view?query=TWTR&type=stock`,
    },
  ];
  return stocks;
}

function createFromResponseQuote(secondResponse) {
  const randomElement =
    secondResponse[Math.floor(Math.random() * secondResponse.length)];
  return {
    text: randomElement.text,
    author: randomElement.author ? randomElement.author : "anonymous",
  };
}

const createFullJsonFromResponse = function (response, protocol, host, secondResponse) {
  return {
    coins: getTopCoins(protocol, host),
    trending: createIndexCoinOptionsFromResponse(response, protocol, host),
    stocks: getStockOptions(protocol, host),
    quote: createFromResponseQuote(secondResponse),
  };
};

module.exports = { createFullJsonFromResponse };
