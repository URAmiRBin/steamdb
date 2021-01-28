-- gets average hours of each played game
SELECT
	game_id,
	AVG ( hours_played ) 
FROM
	user_games 
GROUP BY
	game_id;