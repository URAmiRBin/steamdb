/*
 Navicat Premium Data Transfer

 Source Server         : dblab
 Source Server Type    : PostgreSQL
 Source Server Version : 130000
 Source Host           : localhost:5432
 Source Catalog        : steam
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 130000
 File Encoding         : 65001

 Date: 01/01/2021 16:08:09
*/


-- ----------------------------
-- Sequence structure for curator_log_action_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."curator_log_action_id_seq";
CREATE SEQUENCE "public"."curator_log_action_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for games_game_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."games_game_id_seq";
CREATE SEQUENCE "public"."games_game_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for genres_genre_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."genres_genre_id_seq";
CREATE SEQUENCE "public"."genres_genre_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for publishers_publisher_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."publishers_publisher_id_seq";
CREATE SEQUENCE "public"."publishers_publisher_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for regions_region_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."regions_region_id_seq";
CREATE SEQUENCE "public"."regions_region_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_user_id_seq";
CREATE SEQUENCE "public"."users_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for curator_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."curator_log";
CREATE TABLE "public"."curator_log" (
  "action_id" int4 NOT NULL DEFAULT nextval('curator_log_action_id_seq'::regclass),
  "game_id_old" int4,
  "game_id_new" int4,
  "genre_id_old" int4,
  "genre_id_new" int4,
  "updated" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of curator_log
-- ----------------------------
INSERT INTO "public"."curator_log" VALUES (1, 1, NULL, 4, NULL, '2020-12-30 10:56:26.722714');

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS "public"."friends";
CREATE TABLE "public"."friends" (
  "sender_id" int4 NOT NULL,
  "receiver_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of friends
-- ----------------------------
INSERT INTO "public"."friends" VALUES (1, 2);
INSERT INTO "public"."friends" VALUES (1, 3);
INSERT INTO "public"."friends" VALUES (2, 3);

-- ----------------------------
-- Table structure for game_genres
-- ----------------------------
DROP TABLE IF EXISTS "public"."game_genres";
CREATE TABLE "public"."game_genres" (
  "game_id" int4 NOT NULL,
  "genre_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of game_genres
-- ----------------------------
INSERT INTO "public"."game_genres" VALUES (1, 1);
INSERT INTO "public"."game_genres" VALUES (1, 2);
INSERT INTO "public"."game_genres" VALUES (2, 1);
INSERT INTO "public"."game_genres" VALUES (2, 2);
INSERT INTO "public"."game_genres" VALUES (3, 4);
INSERT INTO "public"."game_genres" VALUES (1, 4);

-- ----------------------------
-- Table structure for game_prices
-- ----------------------------
DROP TABLE IF EXISTS "public"."game_prices";
CREATE TABLE "public"."game_prices" (
  "game_id" int4 NOT NULL,
  "region_id" int4 NOT NULL,
  "price" numeric(5,2) NOT NULL
)
;

-- ----------------------------
-- Records of game_prices
-- ----------------------------
INSERT INTO "public"."game_prices" VALUES (5, 2, 19.99);
INSERT INTO "public"."game_prices" VALUES (5, 3, 19.99);
INSERT INTO "public"."game_prices" VALUES (1, 1, 20.00);
INSERT INTO "public"."game_prices" VALUES (1, 2, 20.00);
INSERT INTO "public"."game_prices" VALUES (3, 1, 5.00);
INSERT INTO "public"."game_prices" VALUES (5, 1, 10.00);
INSERT INTO "public"."game_prices" VALUES (6, 1, 19.99);
INSERT INTO "public"."game_prices" VALUES (6, 2, 19.99);
INSERT INTO "public"."game_prices" VALUES (6, 3, 19.99);

-- ----------------------------
-- Table structure for games
-- ----------------------------
DROP TABLE IF EXISTS "public"."games";
CREATE TABLE "public"."games" (
  "game_id" int4 NOT NULL DEFAULT nextval('games_game_id_seq'::regclass),
  "game_name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "publisher_id" int4 NOT NULL,
  "release_date" date NOT NULL,
  "rate" int2 NOT NULL DEFAULT 0,
  "voted" int2 NOT NULL DEFAULT 0,
  "offrate" int2 DEFAULT 0
)
;

-- ----------------------------
-- Records of games
-- ----------------------------
INSERT INTO "public"."games" VALUES (3, 'Crew', 2, '2020-12-29', 0, 0, 0);
INSERT INTO "public"."games" VALUES (2, 'GTA IV', 1, '2020-12-29', 0, 0, 0);
INSERT INTO "public"."games" VALUES (1, 'GTA V', 1, '2020-12-29', 1, 3, 0);
INSERT INTO "public"."games" VALUES (5, 'GTA San Andreas', 1, '2020-12-29', 0, 0, 50);
INSERT INTO "public"."games" VALUES (6, 'Watch Dogs', 2, '2020-12-30', 0, 0, 33);

-- ----------------------------
-- Table structure for genres
-- ----------------------------
DROP TABLE IF EXISTS "public"."genres";
CREATE TABLE "public"."genres" (
  "genre_id" int4 NOT NULL DEFAULT nextval('genres_genre_id_seq'::regclass),
  "genre_name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of genres
-- ----------------------------
INSERT INTO "public"."genres" VALUES (1, 'Action');
INSERT INTO "public"."genres" VALUES (2, 'Adventure');
INSERT INTO "public"."genres" VALUES (3, 'Anime');
INSERT INTO "public"."genres" VALUES (4, 'Driving');

-- ----------------------------
-- Table structure for publishers
-- ----------------------------
DROP TABLE IF EXISTS "public"."publishers";
CREATE TABLE "public"."publishers" (
  "publisher_id" int4 NOT NULL DEFAULT nextval('publishers_publisher_id_seq'::regclass),
  "username" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "address" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "wallet" int4 NOT NULL DEFAULT 0
)
;

-- ----------------------------
-- Records of publishers
-- ----------------------------
INSERT INTO "public"."publishers" VALUES (1, 'Rockstar Games', 'info@rockstargames.com', 'Scottland', 35);
INSERT INTO "public"."publishers" VALUES (2, 'Ubisoft', 'info@ubi.com', 'Montreal', 46);

-- ----------------------------
-- Table structure for regions
-- ----------------------------
DROP TABLE IF EXISTS "public"."regions";
CREATE TABLE "public"."regions" (
  "region_id" int4 NOT NULL DEFAULT nextval('regions_region_id_seq'::regclass),
  "region_name" varchar(10) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of regions
-- ----------------------------
INSERT INTO "public"."regions" VALUES (1, 'ASIA');
INSERT INTO "public"."regions" VALUES (2, 'EU');
INSERT INTO "public"."regions" VALUES (3, 'US');

-- ----------------------------
-- Table structure for user_games
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_games";
CREATE TABLE "public"."user_games" (
  "user_id" int4 NOT NULL,
  "game_id" int4 NOT NULL,
  "hours_played" numeric(4,1) NOT NULL DEFAULT 0,
  "recommended" bool
)
;

-- ----------------------------
-- Records of user_games
-- ----------------------------
INSERT INTO "public"."user_games" VALUES (2, 2, 0.0, NULL);
INSERT INTO "public"."user_games" VALUES (2, 1, 0.0, 'f');
INSERT INTO "public"."user_games" VALUES (3, 1, 0.0, 't');
INSERT INTO "public"."user_games" VALUES (1, 1, 1.0, 'f');
INSERT INTO "public"."user_games" VALUES (1, 3, 0.0, NULL);
INSERT INTO "public"."user_games" VALUES (1, 5, 0.0, NULL);
INSERT INTO "public"."user_games" VALUES (1, 6, 0.0, NULL);
INSERT INTO "public"."user_games" VALUES (3, 5, 0.0, NULL);
INSERT INTO "public"."user_games" VALUES (3, 6, 0.0, NULL);
INSERT INTO "public"."user_games" VALUES (2, 3, 0.0, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "user_id" int4 NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
  "username" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(30) COLLATE "pg_catalog"."default" NOT NULL,
  "wallet" int4 NOT NULL DEFAULT 0,
  "region_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES (1, 'amirbin', 'ur.amirbin@gmail.com', 32, 1);
INSERT INTO "public"."users" VALUES (3, 'boris', 'boris-leninsky@gmail.ru', 7, 2);
INSERT INTO "public"."users" VALUES (2, 'majima-san', 'majima.real@jmail.com', 10, 1);

-- ----------------------------
-- Function structure for add_friend_constraints
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_friend_constraints"();
CREATE OR REPLACE FUNCTION "public"."add_friend_constraints"()
  RETURNS "pg_catalog"."trigger" AS $BODY$DECLARE
	temp integer;
BEGIN
	IF NEW.sender_id = NEW.receiver_id THEN
		RETURN NULL;
	END IF;
	IF NEW.sender_id > NEW.receiver_id THEN
		temp := NEW.sender_id;
		NEW.sender_id = NEW.receiver_id;
		NEW.receiver_id = temp;
	END IF;
	RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for add_game_normalize
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_game_normalize"();
CREATE OR REPLACE FUNCTION "public"."add_game_normalize"()
  RETURNS "pg_catalog"."trigger" AS $BODY$BEGIN
	NEW.rate = 0;
	NEW.voted = 0;
	IF NEW.offrate > 100 THEN
		NEW.offrate = 100;
	END IF;
	IF NEW.offrate < 0 THEN
		NEW.offrate = 0;
	END IF;
	RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for add_game_prices
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_game_prices"();
CREATE OR REPLACE FUNCTION "public"."add_game_prices"()
  RETURNS "pg_catalog"."trigger" AS $BODY$BEGIN
	INSERT INTO game_prices(game_id, region_id, price)
	SELECT NEW.game_id, region_id, '19.99' FROM regions;
	RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Procedure structure for add_init_data
-- ----------------------------
DROP PROCEDURE IF EXISTS "public"."add_init_data"();
CREATE OR REPLACE PROCEDURE "public"."add_init_data"()
 AS $BODY$
begin
	insert into genres(genre_name) values ('Action'), ('Adventure'), ('Anime'), ('Driving');
	insert into regions(region_name) values ('ASIA'), ('EU'), ('US');
	insert into users(username, email, region_id) values
	('amirbin', 'ur.amirbin@gmail.com', 1),
	('majima-san', 'majima.real@jmail.com', 1),
	('boris', 'boris-leninsky@gmail.ru', 2);
	
	insert into publishers(username, email, address) values
	('Rockstar Games', 'info@rockstargames.com', 'Scottland'),
	('Ubisoft', 'info@ubi.com', 'Montreal');
	
	insert into games(game_name, publisher_id, release_date) values
	('GTA V', 1, now()),
	('GTA IV', 1, now()),
	('Crew', 2, now());
	
	insert into friends values(1,2),(1,3);
	
	insert into game_genres values(1,1),(1,2),(2,1),(2,2),(3,4);
	
	insert into user_games values(1,1),(2,1),(3,1),(1,3),(2,2);
end;$BODY$
  LANGUAGE plpgsql;

-- ----------------------------
-- Procedure structure for buy_game
-- ----------------------------
DROP PROCEDURE IF EXISTS "public"."buy_game"("sender" int4, "receiver" int4, "amount" numeric);
CREATE OR REPLACE PROCEDURE "public"."buy_game"("sender" int4, "receiver" int4, "amount" numeric)
 AS $BODY$begin
	update users
	set wallet = wallet - amount
	where user_id = sender;
	
	update publishers
	set wallet = wallet + amount
	where publisher_id = receiver;
	
		
end;$BODY$
  LANGUAGE plpgsql;

-- ----------------------------
-- Procedure structure for buy_game
-- ----------------------------
DROP PROCEDURE IF EXISTS "public"."buy_game"("sender" int4, "game" int4, "receiver" int4, "amount" numeric);
CREATE OR REPLACE PROCEDURE "public"."buy_game"("sender" int4, "game" int4, "receiver" int4, "amount" numeric)
 AS $BODY$begin
	update users
	set wallet = wallet - amount
	where user_id = sender;
	
	update publishers
	set wallet = wallet + amount
	where publisher_id = receiver;
	
	
	insert into user_games(user_id, game_id)
	values(sender,game);
	
		
end;$BODY$
  LANGUAGE plpgsql;

-- ----------------------------
-- Procedure structure for drop_all_tables
-- ----------------------------
DROP PROCEDURE IF EXISTS "public"."drop_all_tables"();
CREATE OR REPLACE PROCEDURE "public"."drop_all_tables"()
 AS $BODY$
begin
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
$BODY$
  LANGUAGE plpgsql;

-- ----------------------------
-- Function structure for get_game_price
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_game_price"("game" int4, "region" int4);
CREATE OR REPLACE FUNCTION "public"."get_game_price"("game" int4, "region" int4)
  RETURNS TABLE("game_id" int4, "game_name" varchar, "publisher_id" int4, "offrate" int2, "price" numeric) AS $BODY$
	begin
	return query
		select games.game_id, games.game_name, games.publisher_id, games.offrate, game_prices.price
		from games
		inner join game_prices
		on games.game_id = game_prices.game_id
		where game_prices.region_id = region and games.game_id = game;
	end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for get_publisher
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_publisher"("game" int4);
CREATE OR REPLACE FUNCTION "public"."get_publisher"("game" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
	begin
	return (select publisher_id from games where game_id = game);
end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for get_publisher_games
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_publisher_games"("publisher" int4);
CREATE OR REPLACE FUNCTION "public"."get_publisher_games"("publisher" int4)
  RETURNS TABLE("game_id" int4, "game_name" varchar, "publisher_id" int4, "release_date" date, "rate" int2, "voted" int2, "offrate" int2) AS $BODY$
	begin
	return query select * from games where games.publisher_id = publisher;
	end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;

-- ----------------------------
-- Function structure for update_game_genres
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_game_genres"();
CREATE OR REPLACE FUNCTION "public"."update_game_genres"()
  RETURNS "pg_catalog"."trigger" AS $BODY$BEGIN
	insert into curator_log(game_id_old, game_id_new, genre_id_old, genre_id_new, updated)
	values(OLD.game_id, NEW.game_id, OLD.genre_id, NEW.genre_id, now());
	RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Function structure for update_game_rating
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_game_rating"();
CREATE OR REPLACE FUNCTION "public"."update_game_rating"()
  RETURNS "pg_catalog"."trigger" AS $BODY$BEGIN
	NEW.game_id = OLD.game_id;
	NEW.user_id = OLD.user_id;
	
	IF OLD.recommended IS NULL AND NEW.recommended IS NOT NULL THEN
		raise notice 'OLD NULL NOW NOT';

		UPDATE games
		SET voted = voted + 1
		WHERE game_id = NEW.game_id;
		IF NEW.recommended = TRUE THEN
			raise notice 'ADDING POSITIVE';
			UPDATE games
			set rate = rate + 1
			WHERE game_id = NEW.game_id;
		END IF;
	ELSIF OLD.recommended != NEW.recommended THEN
		IF NEW.recommended = FALSE THEN
			UPDATE games
			set rate = rate - 1
			WHERE game_id = NEW.game_id;
		ELSIF NEW.recommended = TRUE THEN
			UPDATE games
			set rate = rate + 1
			WHERE game_id = NEW.game_id;
		END IF;
	END IF;
	RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Procedure structure for update_scores
-- ----------------------------
DROP PROCEDURE IF EXISTS "public"."update_scores"();
CREATE OR REPLACE PROCEDURE "public"."update_scores"()
 AS $BODY$
begin
	update games
	set (rate, voted) = (vote_table.positive, vote_table.voted)
	from (
	select games.game_id,count(recommended) as voted, count(recommended) filter (where recommended = true) as positive
	from games left join user_games on user_games.game_id = games.game_id
	group by games.game_id
				) as vote_table
	where vote_table.game_id = games.game_id;

end;$BODY$
  LANGUAGE plpgsql;

-- ----------------------------
-- Function structure for vote_game
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."vote_game"();
CREATE OR REPLACE FUNCTION "public"."vote_game"()
  RETURNS "pg_catalog"."trigger" AS $BODY$BEGIN
	NEW.game_id = OLD.game_id;
	NEW.user_id = OLD.user_id;
	
	if NEW.recommended = NULL and OLD.recommended != NULL then
		NEW.recommended = OLD.recommended;
	end if;
	
	if NEW.hours_played < OLD.hours_played then
		NEW.hours_played = OLD.hours_played;
	end if;
	
	RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."curator_log_action_id_seq"
OWNED BY "public"."curator_log"."action_id";
SELECT setval('"public"."curator_log_action_id_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."games_game_id_seq"
OWNED BY "public"."games"."game_id";
SELECT setval('"public"."games_game_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."genres_genre_id_seq"
OWNED BY "public"."genres"."genre_id";
SELECT setval('"public"."genres_genre_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."publishers_publisher_id_seq"
OWNED BY "public"."publishers"."publisher_id";
SELECT setval('"public"."publishers_publisher_id_seq"', 3, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."regions_region_id_seq"
OWNED BY "public"."regions"."region_id";
SELECT setval('"public"."regions_region_id_seq"', 4, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_user_id_seq"
OWNED BY "public"."users"."user_id";
SELECT setval('"public"."users_user_id_seq"', 4, true);

-- ----------------------------
-- Primary Key structure for table curator_log
-- ----------------------------
ALTER TABLE "public"."curator_log" ADD CONSTRAINT "curator_log_pkey" PRIMARY KEY ("action_id");

-- ----------------------------
-- Triggers structure for table friends
-- ----------------------------
CREATE TRIGGER "add_friend_trigger" BEFORE INSERT ON "public"."friends"
FOR EACH ROW
EXECUTE PROCEDURE "public"."add_friend_constraints"();

-- ----------------------------
-- Primary Key structure for table friends
-- ----------------------------
ALTER TABLE "public"."friends" ADD CONSTRAINT "friends_pkey" PRIMARY KEY ("sender_id", "receiver_id");

-- ----------------------------
-- Triggers structure for table game_genres
-- ----------------------------
CREATE TRIGGER "curator_log_trigger" AFTER INSERT OR UPDATE OR DELETE ON "public"."game_genres"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_game_genres"();

-- ----------------------------
-- Primary Key structure for table game_genres
-- ----------------------------
ALTER TABLE "public"."game_genres" ADD CONSTRAINT "game_genres_pkey" PRIMARY KEY ("game_id", "genre_id");

-- ----------------------------
-- Checks structure for table game_prices
-- ----------------------------
ALTER TABLE "public"."game_prices" ADD CONSTRAINT "game_prices_price_check" CHECK (price >= 0::numeric);

-- ----------------------------
-- Primary Key structure for table game_prices
-- ----------------------------
ALTER TABLE "public"."game_prices" ADD CONSTRAINT "game_prices_pkey" PRIMARY KEY ("game_id", "region_id");

-- ----------------------------
-- Triggers structure for table games
-- ----------------------------
CREATE TRIGGER "add_game_price_trigger" AFTER INSERT ON "public"."games"
FOR EACH ROW
EXECUTE PROCEDURE "public"."add_game_prices"();
CREATE TRIGGER "add_game_trigger" BEFORE INSERT ON "public"."games"
FOR EACH ROW
EXECUTE PROCEDURE "public"."add_game_normalize"();

-- ----------------------------
-- Uniques structure for table games
-- ----------------------------
ALTER TABLE "public"."games" ADD CONSTRAINT "games_game_name_key" UNIQUE ("game_name");

-- ----------------------------
-- Checks structure for table games
-- ----------------------------
ALTER TABLE "public"."games" ADD CONSTRAINT "games_rate_check" CHECK (rate >= 0);
ALTER TABLE "public"."games" ADD CONSTRAINT "games_voted_check" CHECK (voted >= 0);

-- ----------------------------
-- Primary Key structure for table games
-- ----------------------------
ALTER TABLE "public"."games" ADD CONSTRAINT "games_pkey" PRIMARY KEY ("game_id");

-- ----------------------------
-- Uniques structure for table genres
-- ----------------------------
ALTER TABLE "public"."genres" ADD CONSTRAINT "genres_genre_name_key" UNIQUE ("genre_name");

-- ----------------------------
-- Primary Key structure for table genres
-- ----------------------------
ALTER TABLE "public"."genres" ADD CONSTRAINT "genres_pkey" PRIMARY KEY ("genre_id");

-- ----------------------------
-- Uniques structure for table publishers
-- ----------------------------
ALTER TABLE "public"."publishers" ADD CONSTRAINT "publishers_username_key" UNIQUE ("username");
ALTER TABLE "public"."publishers" ADD CONSTRAINT "publishers_email_key" UNIQUE ("email");
ALTER TABLE "public"."publishers" ADD CONSTRAINT "publishers_address_key" UNIQUE ("address");

-- ----------------------------
-- Primary Key structure for table publishers
-- ----------------------------
ALTER TABLE "public"."publishers" ADD CONSTRAINT "publishers_pkey" PRIMARY KEY ("publisher_id");

-- ----------------------------
-- Uniques structure for table regions
-- ----------------------------
ALTER TABLE "public"."regions" ADD CONSTRAINT "regions_region_name_key" UNIQUE ("region_name");

-- ----------------------------
-- Primary Key structure for table regions
-- ----------------------------
ALTER TABLE "public"."regions" ADD CONSTRAINT "regions_pkey" PRIMARY KEY ("region_id");

-- ----------------------------
-- Triggers structure for table user_games
-- ----------------------------
CREATE TRIGGER "update_recommended_trigger" BEFORE UPDATE ON "public"."user_games"
FOR EACH ROW
EXECUTE PROCEDURE "public"."vote_game"();

-- ----------------------------
-- Checks structure for table user_games
-- ----------------------------
ALTER TABLE "public"."user_games" ADD CONSTRAINT "user_games_hours_played_check" CHECK (hours_played >= 0::numeric);

-- ----------------------------
-- Primary Key structure for table user_games
-- ----------------------------
ALTER TABLE "public"."user_games" ADD CONSTRAINT "user_games_pkey" PRIMARY KEY ("user_id", "game_id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_email_key" UNIQUE ("email");

-- ----------------------------
-- Checks structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_wallet_check" CHECK (wallet >= 0);

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Foreign Keys structure for table friends
-- ----------------------------
ALTER TABLE "public"."friends" ADD CONSTRAINT "friends_receiver_id_fkey" FOREIGN KEY ("receiver_id") REFERENCES "public"."users" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."friends" ADD CONSTRAINT "friends_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "public"."users" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table game_genres
-- ----------------------------
ALTER TABLE "public"."game_genres" ADD CONSTRAINT "game_genres_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games" ("game_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."game_genres" ADD CONSTRAINT "game_genres_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "public"."genres" ("genre_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table game_prices
-- ----------------------------
ALTER TABLE "public"."game_prices" ADD CONSTRAINT "game_prices_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games" ("game_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."game_prices" ADD CONSTRAINT "game_prices_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "public"."regions" ("region_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table games
-- ----------------------------
ALTER TABLE "public"."games" ADD CONSTRAINT "games_publisher_id_fkey" FOREIGN KEY ("publisher_id") REFERENCES "public"."publishers" ("publisher_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_games
-- ----------------------------
ALTER TABLE "public"."user_games" ADD CONSTRAINT "user_games_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "public"."games" ("game_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."user_games" ADD CONSTRAINT "user_games_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_region_id_fkey" FOREIGN KEY ("region_id") REFERENCES "public"."regions" ("region_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
