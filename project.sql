CREATE TABLE IF NOT EXISTS User (
  uuid int not null AUTO_INCREMENT,
  last_name varchar(25) NOT NULL,
  first_name varchar(25) NOT NULL,
  email VARCHAR(40) NOT NULL,
  password VARCHAR(25) NOT NULL,
  PRIMARY KEY (uuid)
);
CREATE TABLE IF NOT EXISTS  Customer (
  cuid int not null AUTO_INCREMENT,
  last_name varchar(255) NOT NULL,
  first_name varchar(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (cuid)
);
CREATE TABLE IF NOT EXISTS Host (
  huid int not null AUTO_INCREMENT,
  last_name varchar(25) NOT NULL,
  first_name varchar(25) NOT NULL,
  email VARCHAR(40) NOT NULL,
  password VARCHAR(25) NOT NULL,
  PRIMARY KEY (huid)
);
CREATE TABLE IF NOT EXISTS  AdminUser (
  auid int not null AUTO_INCREMENT,
  last_name varchar(25) NOT NULL,
  first_name varchar(25) NOT NULL,
  email VARCHAR(40) NOT NULL,
  password VARCHAR(25) NOT NULL,
  PRIMARY KEY (auid)
);
CREATE TABLE IF NOT EXISTS  BlackList (
  user_id int not null,
  admin_id int not null,
  user_type ENUM ('H', 'C'),
  PRIMARY KEY (user_id),
  FOREIGN KEY (admin_id) REFERENCES AdminUser(auid)
);
CREATE TABLE IF NOT EXISTS  Listing (
  listing_id INT NOT NULL AUTO_INCREMENT,
  listing_title VARCHAR(50) NOT NULL,
  host_id int Not NUll,
  admin_id int NOT NULL ,
  PRIMARY KEY(listing_id),
  FOREIGN KEY (admin_id) REFERENCES AdminUser(auid),
  FOREIGN KEY (host_id) REFERENCES Host(huid)
);
CREATE TABLE IF NOT EXISTS HistoryList (
  historyList_id INT NOT NULL AUTO_INCREMENT,
  price DECIMAL(6,2) NOT NULL,
  listing_id INT NOT NULL ,
  time_of_state datetime NOT NULL,
  primary key (historyList_id),
  foreign key (listing_id) references Listing(listing_id)
);
CREATE TABLE IF NOT EXISTS  Room (
  room_id INT NOT NULL AUTO_INCREMENT,
  x_coordinate DECIMAL(8,6) NOT NULL,
  y_coordinate DECIMAL (9,6) NOT NULL,
  price DECIMAL (6,2) NOT NULL,
  PRIMARY KEY(room_id)
);
CREATE TABLE IF NOT EXISTS  Shared_Room (
  bed_size ENUM('K','Q','F','T') NOT NULL,
  no_of_beds INT NOT NULL,
  sharedroom_type VARCHAR(10) NOT NULL,
  x_coordinate DECIMAL(8,6) NOT NULL,
  y_coordinate DECIMAL (9,6) NOT NULL,
  price DECIMAL (6,2) NOT NULL,
  room_id INT NOT NULL,
  host_id INT NOT NULL,
  FOREIGN KEY (room_id) REFERENCES Room(room_id),
  FOREIGN KEY (host_id) REFERENCES Host(huid),
  PRIMARY KEY(room_id,host_id)
);
CREATE TABLE IF NOT EXISTS  Payment_System (
  transaction_id INT NOT NULL auto_increment,
  price DECIMAL (6,2) NOT NULL,
  customer_id INT NOT NULL,
  host_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(cuid),
  FOREIGN KEY (host_id) REFERENCES Host(huid),
  PRIMARY KEY(transaction_id)
);
CREATE TABLE IF NOT EXISTS  Payment_Confirmation (
  confirmation_No INT NOT NULL auto_increment,
  transaction_id INT NOT NULL,
  price DECIMAL (6,2) NOT NULL,
  customer_id INT NOT NULL,
  date_of_payment DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(cuid),
  FOREIGN KEY (transaction_id) REFERENCES Payment_System(transaction_id),
  PRIMARY KEY(confirmation_No)
);
CREATE TABLE IF NOT EXISTS Favorited_Listings(
customer_id INT NOT NULL,
listing_id INT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customer(cuid),
FOREIGN KEY (listing_id) REFERENCES Listing(listing_id),
PRIMARY KEY(customer_id,listing_id)
);
CREATE TABLE IF NOT EXISTS Reviews (
  no_of_reviews INT NOT NULL,
  last_review_date DATE NOT NULL,
  minimum_nights INT NOT NULL,
  customer_id INT NOT NULL,
  room_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(cuid),
  FOREIGN KEY (room_id) REFERENCES Room(room_id),
  PRIMARY KEY (room_id, customer_id)
);

CREATE TABLE IF NOT EXISTS  Shared_BedSize(
room_id INT NOT NULL,
bed_size ENUM('K','Q','F','T') NOT NULL,
FOREIGN KEY (room_id) REFERENCES Room(room_id),
PRIMARY KEY(room_id,bed_size)
);
CREATE TABLE IF NOT EXISTS  Private_Room (
  privateRoomId INT NOT NULL AUTO_INCREMENT,
  no_of_beds INT NOT NULL DEFAULT 1,
  privateroom_type VARCHAR(10) NOT NULL DEFAULT "Small",
  x_coordinate DECIMAL(8,6) NOT NULL,
  y_coordinate DECIMAL (9,6) NOT NULL,
  price DECIMAL (6,2) NOT NULL,
  room_id INT NOT NULL,
  host_id INT NOT NULL,
  FOREIGN KEY (room_id) REFERENCES Room(room_id),
  FOREIGN KEY (host_id) REFERENCES Host(huid),
  PRIMARY KEY(privateRoomId)
);
CREATE TABLE IF NOT EXISTS  Private_BedSize(
room_id INT NOT NULL,
bed_size ENUM('K','Q','F','T') NOT NULL,
FOREIGN KEY (room_id) REFERENCES Room(room_id),
PRIMARY KEY(room_id,bed_size)
);
CREATE TABLE IF NOT EXISTS  EntireHouse_or_Appt (
  no_of_rooms INT NOT NULL DEFAULT 1 ,
  no_of_bathrooms INT NOT NULL DEFAULT 1,
  x_coordinate DECIMAL(8,6) NOT NULL,
  y_coordinate DECIMAL (9,6) NOT NULL,
  price DECIMAL (6,2) NOT NULL,
  room_id INT NOT NULL,
  host_id INT NOT NULL,
  FOREIGN KEY (room_id) REFERENCES Room(room_id),
  FOREIGN KEY (host_id) REFERENCES Host(huid),
  PRIMARY KEY(room_id,host_id)
);


INSERT INTO HOST(last_name, first_name, email, password) VALUES ("Tran", "Thong", "thongtran11@gmail.com", "somethingspecial");
INSERT INTO HOST(last_name, first_name, email, password) VALUES ("Tran", "Quyen", "quyentran190@gmail.com", "somethingspecial2");
INSERT INTO HOST(last_name, first_name, email, password) VALUES ("Nguyen", "Cac", "dk1231@gmail.com", "somethingspecial");
INSERT INTO HOST(last_name, first_name, email, password) VALUES ("Tran", "Lon", "quyentdsad123190@gmail.com", "somethingspecial2");

INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (1, "Tran", "Lon", "quyentdsad123190@gmail.com", "somethingspecial2");
INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (2, "Tran", "Lon1", "quyentdsad123190@gmail.com", "somethingspecial2");
INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (3, "Tran", "Lon2", "quyentdsad123190@gmail.com", "somethingspecial2");
INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (4, "Tranfd", "Lon3", "quyentdsad123190@gmail.com", "somethingspecial2");
INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (5, "Tran23", "Lon4", "quyentdsad123190@gmail.com", "somethingspecial2");
INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (6, "Tra2fdn", "Lon5", "quyentdsad123190@gmail.com", "somethingspecial2");
INSERT INTO Customer(cuid, last_name, first_name, email, password) VALUES (7, "Tranda", "Lon6", "quyentdsad123190@gmail.com", "somethingspecial2");

INSERT INTO AdminUser(auid, last_name, first_name, email, password) VALUES (1, "Con", "Cac", "quyentdsad123190@gmail.com", "somethingspecial2");

-- Run this after running sql.py script to make the room available
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("12", "2019-02-14", "3", 1, 1354);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("10", "2019-02-14", "3", 2, 1360);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("1", "2019-02-14", "3", 3, 1361);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("32", "2019-02-14", "3", 1, 1362);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("12", "2019-02-14", "3", 3, 1363);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("3", "2019-02-14", "3", 1, 1364);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("4", "2019-02-14", "3", 3, 1365);
INSERT INTO Reviews(no_of_reviews, last_review_date, minimum_nights , customer_id, room_id) VALUES("19", "2019-02-14", "3", 4, 1366);

INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(1, 1372);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(1, 1373);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(1, 1374);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(1, 1375);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(1, 1376);

INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(2, 1332);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(2, 1333);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(2, 1334);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(2, 1335);
INSERT INTO Favorited_Listings(customer_id, listing_id) VALUES(2, 1336);


--          Querries SQL

-- Show the favorite listing of the customer whose last name is Tran and first name is Lon
select listing_id, listing_title from listing where listing_id in (select listing_id from Favorited_Listings where customer_id=(select cuid from customer where last_name="Tran" and first_name="Lon"));
-- Show the privates room which price is at most 75.00
select * from private_room where price <= 75;
-- Show the privates room which price is in between 75.00 and 150.00
select * from private_room where price >= 75 and price <= 150;
-- Show the privates room which is small room type
select * from private_room where privateroom_type = "Small";
-- Show the privates room of the host whose first name is Heather
select * from private_room where host_id in (select huid from host where first_name="Heather" );
-- Show the number of reviews of the room where room id is 1354
select no_of_reviews from reviews  where room_id=1354;
-- Show the rooms that customer id 3 has been reviewed
select room_id from reviews where customer_id = 3;
-- Show who is the admin
select first_name, last_name from AdminUser;
-- Display the total number of the hosts
select count(*) as "total of hosts" from host;
-- Display the total number of the hosts whose first name is David
select count(*) from host where first_name="david";
-- Display the total number of available House and Apt
select count(distinct room_id) as "number of house and apt" from EntireHouse_or_Appt; -- 834
-- Display the total number of available private room
select count(distinct room_id) as "number of private room" from private_room; -- 537
