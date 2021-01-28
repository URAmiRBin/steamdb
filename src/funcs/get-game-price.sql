-- gets price of a game in a region
-- this function returns necessary information to server in order to generate factors and prices
CREATE OR REPLACE FUNCTION get_game_price(game int4, region int4)
  RETURNS TABLE(
		game_id int,
		game_name varchar(20),
		publisher_id int,
		offrate SMALLINT,
		price numeric(5,2)) AS
	'
	begin
	-- the inner join is to get game_name and other information of the game such as offrate
	return query
		select games.game_id, games.game_name, games.publisher_id, games.offrate, game_prices.price
		from games
		inner join game_prices
		on games.game_id = game_prices.game_id
		where game_prices.region_id = region and games.game_id = game;
	end;' language plpgsql;