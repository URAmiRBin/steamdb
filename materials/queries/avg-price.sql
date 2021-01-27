-- average of price according to regions
SELECT region_id, avg(price)
FROM game_prices
GROUP BY region_id;

-- average of price according to games
select game_id, avg(price)
from game_prices
GROUP BY game_id;

-- average of price according to publishers
select publisher_id, avg(game_prices.price)
from games INNER JOIN game_prices
on games.game_id = game_prices.game_id
group by games.publisher_id;