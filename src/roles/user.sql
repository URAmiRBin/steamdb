-- Add RLS to friends and user games
ALTER TABLE friends ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_games ENABLE ROW LEVEL SECURITY;

CREATE ROLE steam_user
LOGIN
PASSWORD 'user';

-- can select games and related tables
GRANT steam_visitor to steam_user;

-- can edit friends table(using RLS policy)
-- to add new friends and remove friends
GRANT SELECT, INSERT, DELETE
ON friends
TO steam_user;

-- can select user_games(using RLS policy)
GRANT SELECT
ON user_games
TO steam_user;

-- can play or rate games(using RLS policy)
GRANT UPDATE (hours_played, recommended)
ON user_games
TO steam_user;

-- This policy filters the select on friends and only shows friends of this user
-- my.user_id must be set and corresponds to user_id that is using the database
CREATE POLICY friends_select_policy
ON friends
FOR SELECT
TO steam_user
USING (
	CAST(current_setting('my.user_id') AS INTEGER) = (sender_id) OR
	CAST(current_setting('my.user_id') AS INTEGER) = (receiver_id)
	);

-- only add friends if one of the columns is current user
CREATE POLICY friends_add_policy
ON friends
FOR INSERT
TO steam_user
WITH CHECK (
	CAST(current_setting('my.user_id') AS INTEGER) = (sender_id) OR
	CAST(current_setting('my.user_id') AS INTEGER) = (receiver_id)
	);

-- only delete friends if one of the columns is current user
CREATE POLICY friends_delete_policy
ON friends
FOR DELETE
TO steam_user
USING (
	CAST(current_setting('my.user_id') AS INTEGER) = (sender_id) OR
	CAST(current_setting('my.user_id') AS INTEGER) = (receiver_id)
	);

-- only select rows with user_id of current user
CREATE POLICY user_games_select_policy
ON user_games
FOR SELECT
TO steam_user
USING (CAST(current_setting('my.user_id') AS INTEGER) = (user_id));

-- only update user_games with user_id of current user
CREATE POLICY user_games_update_policy
ON user_games
FOR UPDATE
TO steam_user
USING (CAST(current_setting('my.user_id') AS INTEGER) = (user_id));
