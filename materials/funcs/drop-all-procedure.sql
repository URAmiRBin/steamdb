create or replace PROCEDURE drop_all_tables() as
'
begin
	drop table if exists curator_log;
	drop table if exists game_genres;
	drop table if exists game_prices;
	drop table if exists friends;
	drop table if exists user_games;
	drop table if exists users;
	drop table if exists games;
	drop table if exists publishers;
	drop table if exists regions;
	drop table if exists genres;
end;
' language plpgsql;

call drop_all_tables();