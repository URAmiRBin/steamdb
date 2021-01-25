-- updates scores using updated user votes
-- this should be called once a day
-- the filter makes the count only count the recommended games
-- the left join is to handle games without sells
create or replace procedure update_scores() as
'
begin
	update games
	set (rate, voted) = (vote_table.positive, vote_table.voted)
	from (
		select games.game_id,count(recommended) as voted, count(recommended) filter (where recommended = true) as positive
		from games left join user_games on user_games.game_id = games.game_id
		group by games.game_id
		) as vote_table
	where vote_table.game_id = games.game_id;

end;' language plpgsql;