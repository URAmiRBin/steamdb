-- ranks top selling games according to how many time people have bought a game
SELECT
	game_id,
	RANK ( ) OVER ( ORDER BY COUNT(game_id) DESC ) top_selling
FROM
	user_games
GROUP BY
	game_id;