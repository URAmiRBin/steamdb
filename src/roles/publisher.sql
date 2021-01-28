-- Activate rls for games and game_prices
ALTER TABLE games ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_prices ENABLE ROW LEVEL SECURITY;


CREATE ROLE steam_publisher
LOGIN
PASSWORD 'publisher';

-- can select games and related tables
GRANT steam_visitor to steam_publisher;

-- can insert to games(using RLS policy)
GRANT INSERT
ON games
TO steam_publisher;

-- publishers can change the offrate of their games(using RLS policy)
GRANT UPDATE (offrate)
ON games
TO steam_publisher;

-- publishers can change the price of their games(using RLS policy)
GRANT UPDATE (price)
ON game_prices
TO steam_publisher;

-- publishers can also remove a game from game_prices(indicating users of that region can not buy that game)
-- as well as adding a game to game_prices
GRANT INSERT, DELETE
ON game_prices
TO steam_publisher;

-- only insert games which its publisher id is current publisher
-- my.publisher_id indicates current publisher
CREATE POLICY games_insert_policy
ON games
FOR INSERT
TO steam_publisher
WITH CHECK (CAST(current_setting('my.publisher_id') AS INTEGER) = (publisher_id));

-- onlu update games which its publisher id is current publisher
CREATE POLICY games_update_policy
ON games
FOR UPDATE
TO steam_publisher
USING (CAST(current_setting('my.publisher_id') AS INTEGER) = (publisher_id));

-- only update/insert/select game prices whose publisher is current publisher
CREATE POLICY games_update_policy
ON game_prices
FOR UPDATE
TO steam_publisher
USING ((CAST(current_setting('my.publisher_id') AS INTEGER)) = get_publisher(game_id) );

CREATE POLICY games_price_insert_policy
ON game_prices
FOR INSERT
TO steam_publisher
WITH CHECK ((CAST(current_setting('my.publisher_id') AS INTEGER)) = get_publisher(game_id) );

CREATE POLICY games_price_delete_policy
ON game_prices
FOR DELETE
TO steam_publisher
USING ((CAST(current_setting('my.publisher_id') AS INTEGER)) = get_publisher(game_id) );

-- every user can select from games; deactivate RLS for select
CREATE POLICY games_select_policy
ON games
FOR SELECT
TO steam_visitor
USING (true);

-- every user can select from game_prices; deactivate RLS for select
CREATE POLICY game_prices_select_policy
ON game_prices
FOR SELECT
TO steam_visitor
USING (true);

-- adding default game prices after adding games trigger needs this
GRANT USAGE, SELECT ON SEQUENCE games_game_id_seq TO steam_publisher;
