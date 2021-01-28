-- temp is used to switch places of sender_id and receiver_id
-- sender_id must always be less than receiver_id
CREATE OR REPLACE FUNCTION add_friend_constraints ( ) RETURNS TRIGGER AS
'DECLARE
	temp integer;
BEGIN
	-- check sender_id is not equal to receiver_id
	IF NEW.sender_id = NEW.receiver_id THEN
		RETURN NULL;
	END IF;

	-- sender_id must be smaller than receiver_id
	IF NEW.sender_id > NEW.receiver_id THEN
		temp := NEW.sender_id;
		NEW.sender_id = NEW.receiver_id;
		NEW.receiver_id = temp;
	END IF;
	RETURN NEW;
END;' LANGUAGE plpgsql;

CREATE TRIGGER add_friend_trigger
	BEFORE INSERT
	ON friends
	FOR EACH ROW
	EXECUTE PROCEDURE add_friend_constraints ( );