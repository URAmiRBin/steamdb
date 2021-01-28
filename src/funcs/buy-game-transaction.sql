-- this is the transaction of buying a game
create or replace PROCEDURE buy_game(sender integer, game integer, receiver integer, amount numeric(5, 2))
as
'begin
	-- first reduce the money from user
	update users
	set wallet = wallet - amount
	where user_id = sender;
	
	-- the commission can be reduced here

	-- then add it to publishers wallet
	update publishers
	set wallet = wallet + amount
	where publisher_id = receiver;
	
	-- insert the game into that users library
	insert into user_games(user_id, game_id)
	values(sender,game);
	
		
end;' LANGUAGE plpgsql;