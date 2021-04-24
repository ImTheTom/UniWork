function createExtraInformation(coin, article) {
  const index = coin.biggest_increase;
  const increase = new Date(coin.daily_changes[index].time);
  const decrease = new Date(coin.daily_changes[coin.biggest_decrease].time);
  return {
    article_after_increase: findSmallestDifference(
      article,
      increase,
      true
    ),
    article_before_increase: findSmallestDifference(
      article,
      increase,
      false
    ),
    article_after_decrease: findSmallestDifference(
      article,
      decrease,
      true
    ),
    article_before_decrease: findSmallestDifference(
      article,
      decrease,
      false
    ),
  };
}

function findSmallestDifference(article, comparative, future) {
  let smallestChange = future ? -Infinity : Infinity;
  let art = null;
  for (let i = 0; i < article.articles.length; i++) {
    const published = article.articles[i].published;
    const diff = comparative - published;
    if (diff < 0 && !future) {
      continue;
    } else if (diff > 0 && future) {
      continue;
    }
    if (diff < smallestChange && !future) {
      smallestChange = diff;
      art = article.articles[i];
    } else if (diff > smallestChange && future) {
      smallestChange = diff;
      art = article.articles[i];
    }
  }
  return art;
}

function createEntireJsonResponse(query, coin, article) {
  extra_info = createExtraInformation(coin, article);
  return {
    coins: coin,
    articles: article,
    extra_information: extra_info,
    name: capitalizeFirstLetter(query),
  };
}

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

module.exports = { createEntireJsonResponse };
