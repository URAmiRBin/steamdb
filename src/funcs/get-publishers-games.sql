-- gets all the games released by a given publisher
CREATE OR REPLACE FUNCTION get_publisher_games(publisher int4)
  RETURNS TABLE(
		game_id int,
		game_name varchar(20),
		publisher_id int,
		release_date DATE,
		rate SMALLINT,
		voted SMALLINT,
		offrate SMALLINT) AS
	'
	begin
	return query select * from games where games.publisher_id = publisher;
	end;' language plpgsql;