-- this happens before user_games table is changed
CREATE OR REPLACE FUNCTION vote_game ( ) RETURNS TRIGGER AS
'BEGIN
	-- game_id and user_id should remain the same
	NEW.game_id = OLD.game_id;
	NEW.user_id = OLD.user_id;
	
	-- if a user has voted before, the vote can not be 
	if NEW.recommended = NULL and OLD.recommended != NULL then
		NEW.recommended = OLD.recommended;
	end if;
	
	-- player only can play games, not unplay it
	if NEW.hours_played < OLD.hours_played then
		NEW.hours_played = OLD.hours_played;
	end if;
	
	RETURN NEW;
END;' LANGUAGE plpgsql;

CREATE TRIGGER update_recommended_trigger
	BEFORE UPDATE
	ON user_games
	FOR EACH ROW
	EXECUTE PROCEDURE vote_game ( );