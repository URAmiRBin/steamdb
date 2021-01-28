CREATE TABLE IF NOT EXISTS
	genres ( genre_id SERIAL PRIMARY KEY , genre_name VARCHAR ( 20 ) NOT NULL UNIQUE );
	
CREATE TABLE IF NOT EXISTS
	regions ( region_id SERIAL PRIMARY KEY, region_name VARCHAR ( 10 ) NOT NULL UNIQUE, region_currency VARCHAR (5) NOT NULL );

CREATE TABLE IF NOT EXISTS
	users (
		user_id SERIAL PRIMARY KEY,
		username VARCHAR ( 20 ) NOT NULL,
		email VARCHAR ( 30 ) NOT NULL UNIQUE,
		wallet NUMERIC(5,2) DEFAULT 0 NOT NULL CHECK(wallet >= 0),
		region_id INT NOT NULL REFERENCES regions (region_id) 
	);
	
CREATE TABLE IF NOT EXISTS 
	publishers (
		publisher_id SERIAL PRIMARY KEY,
		username VARCHAR ( 20 ) NOT NULL UNIQUE,
		email VARCHAR ( 30 ) NOT NULL UNIQUE,
		address VARCHAR ( 60 ) NOT NULL UNIQUE,
		wallet NUMERIC(5,2) DEFAULT 0 NOT NULL
	);

CREATE TABLE IF NOT EXISTS
	games (
		game_id SERIAL PRIMARY KEY,
		game_name VARCHAR ( 20 ) NOT NULL UNIQUE,
		publisher_id INT NOT NULL REFERENCES publishers (publisher_id),
		release_date DATE NOT NULL,
		rate SMALLINT DEFAULT 0 NOT NULL CHECK(rate >= 0),
		voted SMALLINT DEFAULT 0 NOT NULL CHECK(voted >= 0),
		offrate SMALLINT DEFAULT 0 
	);
	
CREATE TABLE IF NOT EXISTS
game_genres (
		game_id INT REFERENCES games ( game_id ) NOT NULL,
		genre_id INT REFERENCES genres ( genre_id ) NOT NULL,
		PRIMARY KEY ( game_id, genre_id ) 
);

CREATE TABLE IF NOT EXISTS
game_prices (
		game_id INT REFERENCES games ( game_id ) NOT NULL,
		region_id INT REFERENCES regions ( region_id ) NOT NULL,
		price NUMERIC ( 5, 2 ) NOT NULL CHECK ( price >= 0 ),
		PRIMARY KEY ( game_id, region_id ) 
);

CREATE TABLE IF NOT EXISTS
user_games (
		user_id INT REFERENCES users ( user_id ) NOT NULL,
		game_id INT REFERENCES games ( game_id ) NOT NULL,
		hours_played NUMERIC ( 4, 1 ) NOT NULL DEFAULT 0 CHECK ( hours_played >= 0 ),
		recommended BOOLEAN DEFAULT NULL,
		PRIMARY KEY ( user_id, game_id ) 
);

CREATE TABLE IF NOT EXISTS
friends (
		sender_id INT REFERENCES users ( user_id ) NOT NULL,
		receiver_id INT REFERENCES users ( user_id ) NOT NULL,
		PRIMARY KEY ( sender_id, receiver_id ) 
);

CREATE TABLE IF NOT EXISTS
curator_log (
		action_id SERIAL PRIMARY KEY,
		game_id_old INT,
		game_id_new INT,
		genre_id_old INT,
		genre_id_new INT,
		updated TIMESTAMP NOT NULL );