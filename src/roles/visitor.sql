drop role steam_visitor;
CREATE ROLE steam_visitor
LOGIN
PASSWORD 'visitor';

GRANT SELECT
ON
	games,
	game_genres,
	game_prices,
	genres,
	regions
TO steam_visitor;
