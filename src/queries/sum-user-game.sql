-- counts how many times a game is sold
SELECT
	game_id,
	COUNT ( game_id ) 
FROM
	user_games 
GROUP BY
	game_id;
	
-- counts how many games a user has bought
SELECT
	user_id,
	COUNT ( user_id ) 
FROM
	user_games 
GROUP BY
	user_id;