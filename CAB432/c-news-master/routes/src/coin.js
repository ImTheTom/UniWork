const generateCoinUrl = function (coin) {
  timestamps = getTimestampsForUrl();
  return `https://api.coingecko.com/api/v3/coins/${coin}/market_chart/range?vs_currency=usd&from=${timestamps[0]}&to=${timestamps[1]}`;
};

const getTimestampsForUrl = function () {
  const current = new Date();
  let monthAgo = new Date();
  monthAgo.setMonth(current.getMonth() - 1);
  return [getDateAsEpoch(monthAgo), getDateAsEpoch(current)];
};

const getDateAsEpoch = function (date) {
  return Math.floor(date.getTime() / 1000);
};

const createFullCoinJsonFromResponse = function (prices) {
  dayChanges = pullOutDays(prices);
  dayChanges = addOnPriceChange(dayChanges);
  data = {
    daily_changes: dayChanges,
    monthly_change: calculateChange(
      dayChanges[dayChanges.length - 1].price,
      dayChanges[0].price
    ),
    biggest_increase: findBiggestChange(dayChanges),
    biggest_decrease: findBiggestDecrease(dayChanges),
  };
  return data;
};

const createFullStockJsonFromResponse = function (prices) {
  dayChanges = pullOutDaysStocks(prices);
  dayChanges = addOnPriceChange(dayChanges);
  data = {
    daily_changes: dayChanges,
    monthly_change: calculateChange(
      dayChanges[dayChanges.length - 1].price,
      dayChanges[0].price
    ),
    biggest_increase: findBiggestChange(dayChanges),
    biggest_decrease: findBiggestDecrease(dayChanges),
  };
  return data;
}

const pullOutDaysStocks = function (prices) {
  let dayPrices = [];
  var keys = Object.keys(prices);
  for (let i = 0; i < 30; i++) {
    dayPrices.push({
      time: new Date(keys[i]).toUTCString(),
      price: parseFloat(prices[keys[i]]["4. close"]),
    });
  }
  return dayPrices;
};

const pullOutDays = function (prices) {
  let dayPrices = [];
  let hourPrices = [];

  for (let i = 0; i < prices.length; i++) {
    hourPrices.push(prices[i][1]);
    if(hourPrices.length > 23) {
        dayPrices.push({
          time: new Date(prices[i][0]).toUTCString(),
          price: calcAverage(hourPrices),
        });

        hourPrices = [];
    }
  }
  return dayPrices;
};

const calcAverage = function (hourPrices) {
    let total = 0;
    for (let i = 0; i < hourPrices.length; i++) {
        total += hourPrices[i];
    }
    return total / hourPrices.length;
}

const addOnPriceChange = function (prices) {
  for (let i = 0; i < prices.length; i++) {
    if (i == 0) {
      prices[0].change = 0;
      continue;
    }
    prices[i].change = calculateChange(prices[i].price, prices[i - 1].price);
  }
  return prices;
};

const calculateChange = function (newValue, originalValue) {
  let change = newValue - originalValue;
  return ((change / originalValue) * 100).toFixed(4);
};

const findBiggestChange = function (values) {
  var index = 0;
  var largest = values[0].change;

  for (var i = 0; i < values.length; i++) {
    if (largest < values[i].change) {
      largest = values[i].change;
      index = i;
    }
  }
  return index;
};

// This function is disgusting. IDK why it doesnt work normally similar to findBiggestChange
const findBiggestDecrease = function (values) {
  var smallest = values[0].change;
  let index = 0;

  for (var i = 1; i < values.length; i++) {
    if(values[i].change < 0) {
    let tmp = Math.abs(values[i].change);
    if (tmp > smallest) {
      smallest = tmp;
      index = i;
    }
  }
}
  return index;
};

module.exports = {
  generateCoinUrl,
  createFullCoinJsonFromResponse,
  createFullStockJsonFromResponse,
};