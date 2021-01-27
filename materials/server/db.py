import psycopg2
import pymongo
from decimal import Decimal
from config_parser import config
from datetime import datetime

class Server:
    def __init__(self, postgres_conf, mongo_conf):
        # Connect to postgresql
        self.conn = psycopg2.connect(**postgres_conf)
        self.cur = self.conn.cursor()
        # Connect to mongo
        self.client = pymongo.MongoClient(mongo_conf['host'])
        self.mongodb = self.client["steam"]
        self.factors = self.mongodb["factors"]

    
    # CONCRETE SERVER METHODS
    def __buy_game_transaction(self, user_id, game_id, publisher_id, amount):
        # Transaction for sending amount of money from user to publisher and adding a game to user's library
        self.cur.execute(" call buy_game(%s, %s, %s, %s) ", (user_id, game_id, publisher_id, amount))
        
    def __cart_transaction(self, user_id, factor):
        # Do all the transactions before commiting
        try:
            # Buy each game one by one
            for i in range(len(factor["games"])):
                game_id = int(factor["games"][i]["game_id"])
                publisher_id = self.__get_publisher(game_id)
                if publisher_id == -1:
                    raise Exception('Invalid game_id. publisher does not exist')
                amount = float(factor["games"][i]["price"])
                # TODO: amount should be converted to USD
                self.__buy_game_transaction(user_id, game_id, publisher_id, amount)
            self.conn.commit()
            self.__insert_factor(factor)
        except Exception as error:
            print("ERROR: ", error)



    # Mongo add factor
    def __insert_factor(self, content):
        try:
            self.factors.insert_one(content)
        except Exception as error:
            print("ERROR: ", error)
        
    # INTERFACE METHODS
    # Called from paypal interface
    def add_wallet(self, user_id, amount):
        try:
            if amount <= 0:
                raise Exception('Paid money is less than 0, pay gateway error')
            self.cur.execute(" update users set wallet = wallet + %s where user_id = %s", (amount, user_id))
            if self.cur.rowcount == 0:
                raise Exception('No user exists with id ', user_id, ' refund using paypal id')
            self.conn.commit()
        except Exception as error:
            print("ERROR: ", error)

    # Called from user client
    def buy_request(self, user_id, cart):
        games = []
        region = self.__get_user_region(user_id)
        if region == -1:
            return
        for item in cart:
            offrate, price = db.__get_price(item, region)
            if offrate == -1:
                print("Invalid cart")
                return
            # TODO: currency should be added for later transactions
            games.append({"game_id": str(item), "price": str(self.__calculate_off_price(offrate, price))})
        
        now = datetime.now()
        date_time = now.strftime("%m/%d/%Y, %H:%M:%S")
        
        factor = {"user_id": str(user_id), "games": games, "date": date_time}
        self.__cart_transaction(user_id, factor)

    
    # LOG AND MISC METHODS
    def print_factors(self):
        return self.factors.find()

    def __get_user_region(self, user_id):
        # It's good practice to check if the result is not null, even though the db constraint exists
        try:
            self.cur.execute("select region_id from users where user_id = %s;", (user_id,))
            row = self.cur.fetchone()
            if self.cur.rowcount == 0:
                raise Exception('User does not exists')
            if row == None:
                raise Exception('This user has no region! (database error)')
            return row[0]
        except Exception as error:
            print("ERROR: ", error, " args = ", user_id)
            return -1

    def __get_price(self, game_id, region_id):
        try:
            self.cur.execute("select offrate,price from get_game_price(%s, %s)", (game_id, region_id))
            row = self.cur.fetchone()
            if self.cur.rowcount == 0:
                raise Exception('This region/game does not exist')
            return row
        except Exception as error:
            print("ERROR: ", error, " args = ", game_id, region_id)
            return -1

    def __get_publisher(self, game_id):
        try:
            self.cur.execute("select publisher_id from games where game_id = %s", (game_id,))
            row = self.cur.fetchone()
            return row[0]
        except:
            print("ERROR: game does not exist")
            return -1

    # Calculates final price after applying off percentage
    def __calculate_off_price(self, offrate, price):
        if price == 0:
            return 0
        return price - price * Decimal(offrate/100)

    def close_connections(self):
        print("CLOSING CONNECTIONS")
        self.cur.close()
        self.conn.close()
        self.client.close()



        
if __name__ == '__main__':
    db = None
    # Read config file to connect to database
    # config.ini has two sections, postgresql and mongo
    try:
        postgres_conf = config('config.ini','postgresql')
        mongo_conf = config('config.ini','mongo')
    except Exception as error:
        print(error)
        exit()

    # Connect to database
    try:
        db = Server(postgres_conf, mongo_conf)    
    except Exception as error:
        print("Execption Caught: ", error)
        exit()

    # INSERT YOUR CODE HERE
    db.buy_request(1, [1,2,3])
    

    db.close_connections()