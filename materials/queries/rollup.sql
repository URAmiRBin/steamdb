-- rolls up publishers and their games and count sales
-- this table shows how many times a game is sold and how many games a publisher has sold
SELECT
	games.publisher_id,
	user_games.game_id,
	COUNT ( user_games.game_id ) 
FROM
	user_games
	INNER JOIN games ON games.game_id = user_games.game_id 
GROUP BY
	ROLLUP ( games.publisher_id, user_games.game_id ) 
ORDER BY
	publisher_id;