-- logs activities of curators changing game_genres table
CREATE OR REPLACE FUNCTION update_game_genres ( ) RETURNS TRIGGER AS
'BEGIN
	insert into curator_log(game_id_old, game_id_new, genre_id_old, genre_id_new, updated)
	values(OLD.game_id, NEW.game_id, OLD.genre_id, NEW.genre_id, now());
	RETURN NEW;
END;' LANGUAGE plpgsql;

CREATE TRIGGER curator_log_trigger
	AFTER INSERT OR DELETE OR UPDATE
	ON game_genres
	FOR EACH ROW
	EXECUTE PROCEDURE update_game_genres ( );