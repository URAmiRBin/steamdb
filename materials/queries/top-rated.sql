-- gets top rated games and shows top 3
-- rate of game is rate/voted
-- the case clause is to avoid division by zero error
-- the round and cast is to round the score to 2 decimals 
SELECT
	game_id,
	game_name,
	publisher_id,
	CASE	
		WHEN voted = 0 THEN 0
		ELSE round( CAST ( rate AS DECIMAL ) / voted, 2 ) 
	END AS user_rating 
FROM
	games 
ORDER BY
	user_rating DESC 
	LIMIT 3