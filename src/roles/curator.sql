CREATE ROLE steam_curator
LOGIN
PASSWORD 'curator';

-- can select games and related tables
GRANT steam_visitor to steam_curator;

-- can edit game_genres to assign genres to games
GRANT INSERT, DELETE, UPDATE
ON game_genres
TO steam_curator;

-- can insert new genres
GRANT INSERT
ON genres
TO steam_curator;

-- this is done through trigger to log changes on game_genres table
GRANT INSERT
ON curator_log
TO steam_curator;

-- this allows steam_curator to use trigger on curator_log table
GRANT USAGE, SELECT ON SEQUENCE curator_log_action_id_seq TO steam_curator;
GRANT usage, SELECT ON  sequence genres_genre_id_seq to steam_curator;