-- gets sum of play hour of each player who has more than some hours of play
-- the having clause filters players with at least some amount of play hours
SELECT
	user_id,
	SUM ( hours_played ) 
FROM
	user_games 
GROUP BY
	user_id 
HAVING
	SUM ( hours_played ) > 1;