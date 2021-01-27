-- gets genres of a game
-- the where clause filters which games to show
SELECT
	game_genres.genre_id 
FROM
	games
	INNER JOIN game_genres ON games.game_id = game_genres.game_id 
WHERE
	games.game_id = 1