-- number of genres for each user and number of users for each genre
-- count how many games a genre have
SELECT
	user_id,
	game_genres.genre_id,
	COUNT ( game_genres.genre_id ) 
FROM
	user_games
	INNER JOIN game_genres ON user_games.game_id = game_genres.game_id 
GROUP BY
	CUBE ( user_id, game_genres.genre_id ) 
ORDER BY
	user_id