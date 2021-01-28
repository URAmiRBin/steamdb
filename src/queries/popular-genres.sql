-- counts how many games each genre has and sorts it
SELECT
	game_genres.genre_id,
	COUNT ( games.game_id ) 
FROM
	games
	INNER JOIN game_genres ON games.game_id = game_genres.game_id 
GROUP BY
	game_genres.genre_id 
ORDER BY
	COUNT ( games.game_id ) DESC