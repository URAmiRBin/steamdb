-- adds default price of 19.99 to every region whenever a game is added
CREATE OR REPLACE FUNCTION add_game_prices ( ) RETURNS TRIGGER AS
'BEGIN
	-- the select statement selects every region
	INSERT INTO game_prices(game_id, region_id, price)
	SELECT NEW.game_id, region_id, ''19.99'' FROM regions;
	RETURN NEW;
END;' LANGUAGE plpgsql;

CREATE TRIGGER add_game_price_trigger
	AFTER INSERT
	ON games
	FOR EACH ROW
	EXECUTE PROCEDURE add_game_prices ( );