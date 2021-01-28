-- checks new inserted games obey the rules
CREATE OR REPLACE FUNCTION add_game_normalize ( ) RETURNS TRIGGER AS
'BEGIN
	-- default rate and voted must be 0
	NEW.rate = 0;
	NEW.voted = 0;

	-- offrate must be between 100 and 0
	IF NEW.offrate > 100 THEN
		NEW.offrate = 100;
	END IF;
	IF NEW.offrate < 0 THEN
		NEW.offrate = 0;
	END IF;
	RETURN NEW;
END;' LANGUAGE plpgsql;

CREATE TRIGGER add_game_trigger
	BEFORE INSERT
	ON games
	FOR EACH ROW
	EXECUTE PROCEDURE add_game_normalize ( );