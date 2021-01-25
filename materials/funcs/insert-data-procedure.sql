create or replace procedure add_init_data() as
'
begin
	insert into genres(genre_name) values (''Action''), (''Adventure''), (''Anime''), (''Driving'');
	insert into regions(region_name, region_currency) values (''ASIA'', ''$''), (''EU'', ''€''), (''US'', ''$'');
	insert into users(username, email, region_id) values
	(''amirbin'', ''ur.amirbin@gmail.com'', 1),
	(''majima-san'', ''majima.real@jmail.com'', 1),
	(''boris'', ''boris-leninsky@gmail.ru'', 2);
	
	insert into publishers(username, email, address) values
	(''Rockstar Games'', ''info@rockstargames.com'', ''Scottland''),
	(''Ubisoft'', ''info@ubi.com'', ''Montreal'');
	
	insert into games(game_name, publisher_id, release_date) values
	(''GTA V'', 1, now()),
	(''GTA IV'', 1, now()),
	(''Crew'', 2, now());
	
	insert into friends values(1,2),(1,3);
	
	insert into game_genres values(1,1),(1,2),(2,1),(2,2),(3,4);
	
	insert into user_games values(1,1),(2,1),(3,1);
end;' language plpgsql;