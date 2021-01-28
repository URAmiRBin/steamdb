create function get_publisher(game integer)
returns integer as'
	begin
	return (select publisher_id from games where game_id = game);
end;' LANGUAGE plpgsql;